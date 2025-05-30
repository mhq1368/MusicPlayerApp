import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Services/dio_connection.dart';
import 'package:music_player_app/constant/url_const.dart';

class SmsVerifyedController extends GetxController {
  RxBool isloading = false.obs;
  var resultMessage = ''.obs;
  RxBool isSuccess = false.obs;
  var token = ''.obs;

  Future<void> verifiedSendCode(String mobile, int codeSend) async {
    final response = await DioServices()
        .postSendedCode(UrlConst.verifideSendedCode, mobile.trim(), codeSend);
    if (response.statusCode == 200) {
      isSuccess.value = response.data['success'] ?? true;
      token.value = response.data['token'] ?? 'isnothing';
    } else {
      isSuccess.value = response.data['success'] ?? false;
    }
    debugPrint("isSuccess: ${isSuccess.value}");
  }
}


// {
//   "success": true,
//   "message": "کد تایید صحیح است",
//   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwicGhvbmUiOiI5MTc3NzA1ODMxIiwianRpIjoiZDU4NTMxM2MtZTY1NS00ZDIxLTk1YmQtNWM0MTgwNWQ1YTdmIiwiZXhwIjoxNzQ4NjM2Mjg0LCJuYmYiOjE3NDg1NDk4ODQsImlzcyI6InlvdXJfaXNzdWVyIiwiYXVkIjoieW91cl9hdWRpZW5jZSJ9.fGRHpC7nveD6hcYgrNC3m6Xj4q2P9oxXQ-9W0QtnTWg"
// }