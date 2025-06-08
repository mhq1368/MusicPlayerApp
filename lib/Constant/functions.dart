import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player_app/Constant/url_const.dart';
import 'package:music_player_app/Controllers/sms_verify_controller.dart';
import 'package:music_player_app/Services/dio_connection.dart';
import 'package:music_player_app/main.dart';

final SmsVerifyController smsVC = Get.put(SmsVerifyController());

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
        "مدت زمان ورود قبلی شما منقضی شده است. لطفاً دوباره وارد شوید.",
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

// تنظیمات بالا و پایین سیستم

void setMySystemUIStyle() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: const Color(0xFF1A2B47).withAlpha(100),
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: const Color(0xff1A2B47),
    systemNavigationBarContrastEnforced: true,
    statusBarBrightness: Brightness.dark,
    systemStatusBarContrastEnforced: true,
  ));
}

// جلوگیری از ورود عدد صفر در ابتدای شماره تلفن
TextInputFormatter firstDigitNotZeroFormatter() {
  return TextInputFormatter.withFunction(
    (oldValue, newValue) {
      if (newValue.text.startsWith('0')) {
        return oldValue; // اگر شماره با صفر شروع شود، مقدار قبلی را برگردان
      }
      return newValue;
    },
  );
}

// تابع بررسی معتبر بودن شماره تلفن

// این تابع شماره تلفن را بررسی می‌کند که آیا معتبر است یا خیر
const validPrefixes = [
  // همراه اول
  '910', '911', '912', '913', '914', '915', '916', '917', '918', '919',
  // ایرانسل
  '930', '933', '935', '936', '937', '938', '939', '901', '902', '903', '904',
  '905',
  // رایتل
  '920', '921', '922',
  // شاتل
  '998', '999',
  // آپدیت با توجه به نیازت...
];

String? validPhone(String val) {
  if (!RegExp(r'^\d+$').hasMatch(val)) {
    return "فقط عدد وارد کنید";
  }
  if (val.length != 10) {
    return "شماره باید دقیقاً ۱۰ رقم و بدون صفر اول باشد";
  }
  if (!val.startsWith('9')) {
    return "شماره باید با 9 شروع شود";
  }

  // چک پیش‌شماره
  String prefix = val.substring(0, 3);
  if (!validPrefixes.contains(prefix)) {
    return "پیش‌شماره نامعتبر است";
  }

  return null;
}
