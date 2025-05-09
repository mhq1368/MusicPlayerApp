// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:music_player_app/Views/all_music_list_views.dart';
// import 'package:music_player_app/Views/home_screen_views.dart';

// class BottomNavbar extends StatelessWidget {
//   const BottomNavbar({
//     super.key,
//     required this.size,
//   });

//   final Size size;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 20,
//       left: 15,
//       right: 15,
//       child: Container(
//         height: 75,
//         width: double.infinity,
//         padding: EdgeInsets.symmetric(horizontal: 5),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: Color(0xff1A2B47),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//                 onPressed: () {
//                   Get.offAll(() => HomePage());
//                 },
//                 icon: Icon(
//                   Icons.home,
//                   color: Colors.white,
//                 )),
//             IconButton(
//                 onPressed: () {
//                   Get.offAll(() => AllMusicsListPage());
//                 },
//                 icon: Icon(
//                   CupertinoIcons.music_note_list,
//                   color: Colors.white,
//                 )),
//             IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   CupertinoIcons.profile_circled,
//                   color: Colors.white,
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: deprecated_member_use

import 'dart:ui'; // برای blur

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Views/all_music_list_views.dart';
import 'package:music_player_app/Views/home_screen_views.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
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
                color: Colors.white.withOpacity(0.1), // شیشه‌ای با شفافیت
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.offAll(() => HomePage());
                    },
                    icon: const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.offAll(() => const AllMusicsListPage());
                    },
                    icon: const Icon(
                      CupertinoIcons.music_note_list,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.profile_circled,
                      color: Colors.white,
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
