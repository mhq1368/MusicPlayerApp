import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Constant/functions.dart';
import 'package:music_player_app/Constant/helper_size.dart';
import 'package:music_player_app/Constant/strings_const.dart';
import 'package:music_player_app/Controllers/sms_verify_controller.dart';
import 'package:music_player_app/Views/sms_verified_code_send_view.dart';
import 'package:music_player_app/Widgets/Widgets_View/info_box.dart';
import 'package:music_player_app/Widgets/Widgets_View/privacy_widget.dart';
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
        resizeToAvoidBottomInset: false,
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
          padding: responsive.scaledPaddingLTRB(0, 30, 0, 0),
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
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          // فقط اعداد را مجاز می‌کند
                          FilteringTextInputFormatter.digitsOnly,
                          firstDigitNotZeroFormatter()
                        ],
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
                            horizontal: responsive.screenWidth / 10,
                            vertical: responsive.screenHeight / 50,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          final validPhoneNumber =
                              validPhone(_mobilephone.text);
                          if (smsVC.isLoading.value ||
                              smsVC.remainSeconds.value > 0) {
                            return;
                          }
                          {
                            if (validPhoneNumber != null) {
                              Get.snackbar(
                                "خطا",
                                validPhoneNumber, // پیام خطا از همون تابع
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                              return; // جلوی ادامه اجرا رو بگیر
                            }
                            await smsVC.sendVerificationCode(_mobilephone.text);
                            Get.to(() => SmsVerifiedCodeSendView(), arguments: {
                              'mobile': _mobilephone.text,
                              'code': smsVC.verificationCode.value
                            });

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
                                  "کد تایید رو ارسال کن",
                                  style: TextStyle(
                                      color: Color(0xFF3C5782),
                                      fontFamily: 'Peyda-M',
                                      fontSize: responsive.screenHeight / 66,
                                      fontWeight: FontWeight.w700),
                                );
                        }))),
                SizedBox(
                  height: responsive.screenHeight / 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsConst.txtcondition1,
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontFamily: 'Peyda-M',
                          fontSize: responsive.screenHeight / 75,
                          fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                        onTap: () {
                          Get.showSnackbar(GetSnackBar(
                            messageText: PrivacyUsers(responsive: responsive),
                            title: StringsConst.txtcondition3,
                          ));
                        },
                        child: Text(
                          StringsConst.txtcondition,
                          style: TextStyle(
                              color: Color.fromARGB(255, 162, 213, 247),
                              fontFamily: 'Peyda-M',
                              fontSize: responsive.screenHeight / 55,
                              fontWeight: FontWeight.w700),
                        )),
                    Text(
                      StringsConst.txtcondition2,
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontFamily: 'Peyda-M',
                          fontSize: responsive.screenHeight / 75,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                // باکس اطلاع به کاربر
                myInfoBox(responsive: responsive),
              ],
            ),
          ),
        ));
  }
}
