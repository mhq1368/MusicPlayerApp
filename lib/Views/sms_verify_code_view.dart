import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Constant/helper_size.dart';
import 'package:music_player_app/Controllers/sms_verify_controller.dart';
import 'package:music_player_app/Views/sms_verified_code_send_view.dart';
import 'package:music_player_app/gen/assets.gen.dart';

class SmsVerifyPage extends StatelessWidget {
  SmsVerifyPage({super.key});
  final SmsVerifyController smsVC = Get.put(SmsVerifyController());
  final TextEditingController _mobilephone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    // var size = MediaQuery.of(context).size;
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
          child: SizedBox(
            height: responsive.screenHeight,
            width: double.infinity,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "شماره همراه",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              fontSize: 14,
                              color: const Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
                SizedBox(
                  height: responsive.screenHeight / 100,
                ),
                //تکست فیلد برای ورود شماره همراه کاربر
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
                        enabled: true,
                        controller: _mobilephone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "نمونه درست : 9121234567",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.black45),
                        ),
                        cursorColor: const Color.fromARGB(115, 100, 27, 27),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: Colors.black),
                      )),
                ),
                SizedBox(
                  height: responsive.screenHeight / 30,
                ),
                //دکمه تایید ارسال کد
                Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle:
                              TextStyle(color: Color.fromARGB(255, 6, 6, 6)),
                          backgroundColor: Color(0xFF39FF14), // رنگ سبز
                          padding: EdgeInsets.symmetric(
                            horizontal: responsive.screenWidth / 7,
                            vertical: responsive.screenHeight / 50,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          if (smsVC.isLoading.value ||
                              smsVC.remainSeconds.value > 0) {
                            return;
                          } else {
                            // if (smsVC.verificationCode.value.isNotEmpty) {
                            await smsVC.sendVerificationCode(_mobilephone.text);
                            Get.to(() => SmsVerifiedCodeSendView(), arguments: {
                              'mobile': _mobilephone.text,
                              'code': smsVC.verificationCode.value
                            });
                            // }

                            debugPrint(_mobilephone.text);
                            debugPrint("Code:${smsVC.verificationCode.value}");
                          }
                        },
                        child: Obx(() {
                          return smsVC.isLoading.value == true ||
                                  smsVC.remainSeconds.value > 0
                              ? Text(
                                  smsVC.remainSeconds.value.toString(),
                                  style: Theme.of(context).textTheme.titleSmall,
                                )
                              : Text(
                                  "ارسال کد",
                                  style: TextStyle(
                                      color: Color(0xFF3C5782),
                                      fontFamily: 'Peyda-M',
                                      fontSize: responsive.screenHeight / 55,
                                      fontWeight: FontWeight.w800),
                                );
                        }))),
                SizedBox(
                  height: responsive.screenHeight / 25,
                ),
                // Obx(() => Text(
                //       smsVC.resultMessage.value,
                //       style: Theme.of(context).textTheme.titleSmall,
                //     )),
              ],
            ),
          ),
        ));
  }
}
