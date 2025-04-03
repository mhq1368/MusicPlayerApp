import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Services/dio_connection.dart';
import '../constant/url_const.dart'; // مسیر درست رو تنظیم کن

class SmsVerifyController extends GetxController {
  var isLoading = false.obs;
  var resultMessage = ''.obs;
  var remainSeconds = 0.obs;
  Timer? _timer;
  final RxBool isenabledverifycode = false.obs;
  void startTimer() {
    remainSeconds.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainSeconds.value > 0) {
        remainSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> sendVerificationCode(String mobileNumber) async {
    if (mobileNumber.isEmpty || mobileNumber.length != 10) {
      resultMessage.value = "شماره موبایل نامعتبر است";
      return;
    }

    isLoading.value = true;
    resultMessage.value = '';
    isenabledverifycode.value = true;

    try {
      final response =
          await DioServices().postMethod(UrlConst.sendCodeToUser, mobileNumber);
      resultMessage.value = response.data['message'] ?? 'کد تایید ارسال شد';
      startTimer();
    } on DioException catch (e) {
      resultMessage.value = _handleDioError(e);
    } catch (e) {
      resultMessage.value = 'خطای غیرمنتظره: $e';
    } finally {
      isLoading.value = false;
    }

    isLoading.value = false;
    isenabledverifycode.value = false;
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'زمان اتصال به پایان رسید';
      case DioExceptionType.sendTimeout:
        return 'خطا در ارسال اطلاعات';
      case DioExceptionType.receiveTimeout:
        return 'دریافت اطلاعات طول کشید';
      case DioExceptionType.badResponse:
        return 'پاسخ نامعتبر از سرور';
      case DioExceptionType.cancel:
        return 'درخواست لغو شد';
      case DioExceptionType.connectionError:
        return 'خطا در اتصال به اینترنت';
      case DioExceptionType.unknown:
      default:
        return 'خطای نامشخص: ${e.message}';
    }
  }
}
