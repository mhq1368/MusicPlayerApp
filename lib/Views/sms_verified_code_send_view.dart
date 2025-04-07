import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Controllers/sms_verifyed_controller.dart';

class SmsVerifiedCodeSendView extends StatelessWidget {
  final SmsVerifyedController smsVC = Get.put(SmsVerifyedController());
  final TextEditingController sendedCode = TextEditingController();
  late String mobilePhone;
  SmsVerifiedCodeSendView({super.key}) {
    mobilePhone = Get.arguments['mobile'];
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
            height: size.height / 100,
          ),
          //تکست فیلد برای ورود کد تایید
          Padding(
            padding: const EdgeInsets.only(right: 50, left: 50),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              width: size.width / 1,
              // height: size.height / 4,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: sendedCode,
                enabled: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "ورود کد تایید",
                    hintStyle: Theme.of(context).textTheme.labelMedium),
                cursorColor: Colors.black45,
              ),
            ),
          ),
          SizedBox(
            height: size.height / 20,
          ),
          //دکمه تایید ارسال کد
          Center(
              child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () {
                    smsVC.verifiedSendCode(
                        mobilePhone, int.parse(sendedCode.text));
                  },
                  child: Text(
                    "تایید کد",
                    style: Theme.of(context).textTheme.labelSmall,
                  ))),
          SizedBox(
            height: size.height / 25,
          ),
          Obx(() => Text(
                smsVC.resultMessage.value,
                style: Theme.of(context).textTheme.titleMedium,
              )),
        ],
      ),
    );
  }
}
