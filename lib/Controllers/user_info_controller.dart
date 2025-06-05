import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player_app/Constant/url_const.dart';
import 'package:music_player_app/Services/dio_connection.dart';

class UserInfoController extends GetxController {
  var isLoading = false.obs;
  var fullName = ''.obs;
  var phone = ''.obs;
  var isVerified = false.obs;
  var isSubscriber = false.obs;
  var errorMessage = ''.obs;

  Future<void> getUserInfo() async {
    var response = await DioServices()
        .getMethod(UrlConst.apiuserinfoshow, token: GetStorage().read('token'));

    if (response.statusCode == 200) {
      final data = response.data;
      fullName.value = data['fullName'] ?? '';
      phone.value = data['phone'] ?? '';
      isVerified.value = data['isVerified'] ?? false;
      isSubscriber.value = data['isSubscriber'] ?? false;
      debugPrint("User Info: $data");
    } else {
      errorMessage.value = 'خطا در دریافت اطلاعات کاربر';
    }
  }

  Future<void> updateUserInfo({
    String? fullName,
    bool? isSubscriber,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final token = GetStorage().read('token');
      final response = await DioServices().updateUserInfo(
        url: UrlConst.apiuserinfoedit,
        token: token,
        name: fullName,
        userSubscribers: isSubscriber,
      );
      isLoading.value = false;
      if (response.statusCode == 200 && response.data['success'] == true) {
        // می‌تونی بعد از ویرایش مجدد اطلاعات رو بخونی
        await getUserInfo();
      } else {
        return errorMessage.value =
            response.data['message'] ?? 'خطا در ویرایش اطلاعات';
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'خطا در ارتباط با سرور';
    }
  }
}
