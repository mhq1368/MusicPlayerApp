import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Services/dio_connection.dart';
import 'package:music_player_app/constant/url_const.dart';

class SmsVerifyedController extends GetxController {
  RxBool isloading = false.obs;
  var resultMessage = ''.obs;
  RxBool isSuccess = false.obs;

  Future<void> verifiedSendCode(String mobile, int codeSend) async {
    final response = await DioServices()
        .postSendedCode(UrlConst.verifideSendedCode, mobile.trim(), codeSend);
    if (response.statusCode == 200) {
      isSuccess.value = response.data['success'] ?? true;
    } else {
      isSuccess.value = response.data['success'] ?? false;
    }
    debugPrint("isSuccess: ${isSuccess.value}");
  }
}
