import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player_app/Constant/helper_size.dart';
import 'package:music_player_app/Controllers/sms_verifyed_controller.dart';

import '../gen/assets.gen.dart';

// ignore: must_be_immutable
class SmsVerifiedCodeSendView extends StatelessWidget {
  final SmsVerifyedController smsVC = Get.put(SmsVerifyedController());
  final TextEditingController sendedCode = TextEditingController();
  late String mobilePhone;
  late String verificationCode;
  SmsVerifiedCodeSendView({super.key}) {
    mobilePhone = Get.arguments['mobile'];
    verificationCode = Get.arguments['code'];
  }
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    // var size = MediaQuery.of(context).size;
    sendedCode.text = verificationCode;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "ورود به حساب کاربری",
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            // عکس کاربر

            Image.asset(
              Assets.svg.userProfilePic1.path,
              alignment: Alignment.center,
              fit: BoxFit.fill,
              height: 95,
              width: 95,
            ),
            // بخش تایید کد
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "ورود کد تایید",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            SizedBox(
              height: responsive.screenHeight / 100,
            ),
            //تکست فیلد برای ورود کد تایید
            Padding(
              padding: const EdgeInsets.only(right: 50, left: 50),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                width: responsive.screenHeight / 1,
                // height: size.height / 4,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // فقط اعداد را مجاز می‌کند
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: sendedCode,
                  enabled: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "ورود کد تایید",
                      hintStyle:
                          Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Colors.black45,
                              )),
                  cursorColor: Colors.black45,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
            ),
            SizedBox(
              height: responsive.screenHeight / 20,
            ),
            //دکمه تایید ارسال کد
            Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF39FF14), // رنگ سبز
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.screenWidth / 10,
                        vertical: responsive.screenHeight / 50,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      await smsVC.verifiedSendCode(
                          mobilePhone, int.parse(sendedCode.text));
                      if (smsVC.isSuccess.value == true) {
                        // اگر کد تایید صحیح بود، به صفحه اصلی بروید
                        Get.offAndToNamed("/HomePage", arguments: {
                          "mobile": mobilePhone,
                          "code": sendedCode.text,
                          "token": smsVC.token.value
                        });
                        GetStorage().write("token", smsVC.token.value);
                      }
                      debugPrint(
                          "isSuccess: ${smsVC.isSuccess.value} , token: ${smsVC.token.value}");
                    },
                    child: Text(
                      "تایید کد",
                      style: TextStyle(
                          color: Color(0xFF3C5782),
                          fontFamily: 'Peyda-M',
                          fontSize: responsive.screenHeight / 66,
                          fontWeight: FontWeight.w700),
                    ))),
            SizedBox(
              height: responsive.screenHeight / 25,
            ),
            Obx(() => Text(
                  smsVC.resultMessage.value,
                  style: Theme.of(context).textTheme.titleMedium,
                )),
          ],
        ),
      ),
    );
  }
}
