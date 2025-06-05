import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player_app/Constant/url_const.dart';
import 'package:music_player_app/Services/dio_connection.dart';
import 'package:music_player_app/main.dart';

//گردی گوشه های کادرها براساس عرض دیوایس
double deviceBasedRadius(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < 390) return 16;
  if (width < 450) return 24;
  return 32;
}

String? getPhoneFromToken(String token) {
  try {
    final parts = token.split('.');
    if (parts.length != 3) return null;

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final decoded = utf8.decode(base64Url.decode(normalized));

    final payloadMap = json.decode(decoded);
    return payloadMap['phone']; // یا 'Phone' بسته به سمت سرور
  } catch (e) {
    debugPrint("Error decoding token: $e");
    return null;
  }
}

/// بررسی انقضای توکن JWT
void checkJwtExpirationAndLogout(String token) {
  try {
    final parts = token.split('.');
    if (parts.length != 3) return;

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final decoded = utf8.decode(base64Url.decode(normalized));

    final payloadMap = json.decode(decoded);

    final exp = payloadMap['exp'];
    if (exp == null) return;

    final expirationDate =
        DateTime.fromMillisecondsSinceEpoch(exp * 1000); // تبدیل به datetime

    final now = DateTime.now();

    if (now.isAfter(expirationDate)) {
      // توکن منقضی شده → پاکسازی و هدایت به صفحه ورود
      final box = GetStorage();
      box.remove('token');

      Get.offAllNamed('/SmsVerify'); // مسیر ورود
      Get.snackbar(
        "هشدار",
        "نشست شما منقضی شده است. لطفاً دوباره وارد شوید.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  } catch (e) {
    debugPrint("Error decoding JWT expiration: $e");
  }
}

// تست api کانکشن
Future<void> testApiConnection() async {
  {
    final response = await DioServices().getMethod(UrlConst.baseapi);

    //صبر اجباری
    await Future.delayed(Duration(seconds: 2));
    if (response.statusCode == 200) {
      // اگر API در دسترس بود، به صفحه اصلی برو
      final token = GetStorage().read('token');
      if (token == null) {
        // کاربر وارد نشده؛ برو به صفحه ورود
        Get.offAllNamed(AppRoutes.smsVerify);
        return;
      }
      Get.offNamed(AppRoutes.homePage);
    }
  }
}
