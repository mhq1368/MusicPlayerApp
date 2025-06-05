import 'dart:ui'; // برای blur

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Constant/helper_size.dart';
import 'package:music_player_app/main.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    final responsive = ResponsiveHelper(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: 75,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(20), // شیشه‌ای با شفافیت
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withAlpha(70),
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.homePage);
                    },
                    icon: Column(
                      children: [
                        Icon(
                          Icons.home_filled,
                          color: Colors.white,
                        ),
                        SizedBox(height: responsive.screenHeight / 100),
                        Text("خانه",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.allMusicsListPage);
                    },
                    icon: Column(
                      children: [
                        Icon(
                          CupertinoIcons.music_note_list,
                          color: Colors.white,
                        ),
                        SizedBox(height: responsive.screenHeight / 100),
                        Text("نواها",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.singersListPage);
                    },
                    icon: Column(
                      children: [
                        Icon(
                          Icons.group,
                          color: Colors.white,
                        ),
                        SizedBox(height: responsive.screenHeight / 100),
                        Text("خوانندگان",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
