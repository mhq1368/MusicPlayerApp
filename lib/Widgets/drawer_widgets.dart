import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player_app/Constant/functions.dart';
import 'package:music_player_app/Constant/helper_size.dart';
import 'package:music_player_app/Controllers/user_info_controller.dart';
import 'package:music_player_app/gen/assets.gen.dart';
import 'package:music_player_app/main.dart';

final box = GetStorage();
final UserInfoController userInfoController = Get.put(UserInfoController());
Drawer drawerApp(BuildContext context) {
  final responsive = ResponsiveHelper(context);
  String? token = box.read('token');
  if (token != null && token.isNotEmpty) {
    // بررسی انقضای توکن JWT و خروج در صورت انقضا
    checkJwtExpirationAndLogout(token);
  }
  return Drawer(
    width: responsive.screenWidth / 1.4,
    backgroundColor: Color(0xFF1A2B47).withOpacity(0.9),
    child: ListView(
      children: [
        Column(
          children: [
            SizedBox(
              height: responsive.screenHeight / 45,
            ),
            Icon(
              CupertinoIcons.profile_circled,
              color: Colors.white,
              size: responsive.screenHeight / 9.5,
            ),
            SizedBox(
              height: responsive.screenHeight / 55,
            ),
            userInfoController.fullName.value.isEmpty
                ? Text(userInfoController.phone.value,
                    style: Theme.of(context).textTheme.bodyLarge)
                : Text(userInfoController.fullName.value,
                    style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
        SizedBox(
          height: responsive.screenHeight / 55,
        ),
        ListTile(
          leading: Icon(CupertinoIcons.profile_circled, color: Colors.white),
          title: token != null
              ? Text('پروفایل', style: Theme.of(context).textTheme.bodyLarge)
              : Text('ورود', style: Theme.of(context).textTheme.bodyLarge),
          onTap: () {
            if (token != null) {
              Get.offAndToNamed(AppRoutes.userProfileInfo, arguments: {
                'token': token,
              });
              // Navigate to profile
            } else {
              Get.offAndToNamed(AppRoutes.smsVerify);
              // Navigate to login
            }
            // Navigate to home
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(),
        ),
        ListTile(
          leading: Icon(Icons.share, color: Colors.white),
          title: Text('معرفی به دوستان',
              style: Theme.of(context).textTheme.bodyLarge),
          onTap: () {
            // Navigate to settings
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(),
        ),
        ListTile(
          leading: Icon(Icons.info, color: Colors.white),
          title:
              Text('درباره ما', style: Theme.of(context).textTheme.bodyLarge),
          onTap: () {
            // Navigate to about
          },
        ),
      ],
    ),
  );
}
