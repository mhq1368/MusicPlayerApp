// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:music_player_app/Constant/functions.dart';
// import 'package:music_player_app/Constant/helper_size.dart';
// import 'package:music_player_app/Controllers/user_info_controller.dart';
// import 'package:music_player_app/Widgets/divider.dart';
// import 'package:music_player_app/gen/assets.gen.dart';
// import 'package:music_player_app/main.dart';

// class UserProfileViewPage extends StatefulWidget {
//   const UserProfileViewPage({super.key});

//   @override
//   State<UserProfileViewPage> createState() => _UserProfileViewPageState();
// }

// final UserInfoController uic = Get.put(UserInfoController());

// final TextEditingController nameUser = TextEditingController();

// class _UserProfileViewPageState extends State<UserProfileViewPage> {
//   RxBool isEditing = false.obs;

//   @override
//   void initState() {
//     super.initState();
//     uic.getUserInfo();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
//     final responsive = ResponsiveHelper(context);
//     final token = GetStorage().read('token');
//     if (token != null && token.isNotEmpty) {
//       // بررسی انقضای توکن JWT و خروج در صورت انقضا
//       checkJwtExpirationAndLogout(token);
//     }
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//           elevation: 0,
//           toolbarHeight: 60,
//           automaticallyImplyLeading: false,
//           title: Padding(
//             padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "پروفایل کاربری",
//                   style: Theme.of(context).appBarTheme.titleTextStyle,
//                 ),
//                 InkWell(
//                     onTap: () {
//                       Get.offAllNamed(
//                           AppRoutes.homePage); // به صفحه اصلی برمی‌گردد
//                     },
//                     child: SvgPicture.asset(
//                       Assets.icons.arrowSmallLeft,
//                       // ignore: deprecated_member_use
//                       color: Colors.white,
//                       height: 32,
//                     )),
//               ],
//             ),
//           )),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             AnimatedContainer(
//               duration: Duration(seconds: 1),
//               curve: Curves.easeInOutCubicEmphasized,
//               height: isKeyboardOpen
//                   ? responsive.screenHeight / 10 // وقتی کیبورد بازه کوچیک‌تر
//                   : responsive.screenHeight / 6, // حالت عادی بزرگ‌تر
//               child: Image.asset(
//                 Assets.svg.userProfilePic1.path,
//                 alignment: Alignment.center,
//                 fit: BoxFit.fill,
//                 height: responsive.screenHeight / 6,
//               ),
//             ),
//             SizedBox(
//               height: responsive.screenHeight / 40,
//             ),
//             Obx(() {
//               return Column(
//                 spacing: 15,
//                 children: [
//                   if (uic.fullName.value.isNotEmpty && !isEditing.value)
//                     Padding(
//                       padding: responsive.scaledPaddingLTRB(0, 0, 50, 0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Icon(Icons.person),
//                           SizedBox(width: responsive.screenWidth / 50),
//                           Text(
//                             "نام کاربری : ",
//                             style: Theme.of(context).textTheme.bodyMedium,
//                           ),
//                           Text(
//                             uic.fullName.value,
//                             style: Theme.of(context).textTheme.titleMedium,
//                           ),
//                           IconButton(
//                               onPressed: () {
//                                 isEditing.value = true;
//                               },
//                               icon: Icon(Icons.edit)),
//                         ],
//                       ),
//                     )
//                   else
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Icon(Icons.person),
//                         SizedBox(width: responsive.screenWidth / 50),
//                         Text(
//                           "نام کاربری : ",
//                           style: Theme.of(context).textTheme.bodyMedium,
//                         ),
//                         Text(
//                           "نام شما ثبت نشده",
//                           style: Theme.of(context).textTheme.bodyMedium,
//                         ),
//                         IconButton(
//                             onPressed: () {
//                               isEditing.value = true;
//                             },
//                             icon: Icon(Icons.edit)),
//                       ],
//                     ),
//                   MyDivider(appWidth: responsive.screenHeight / 20),
//                   Padding(
//                     padding: responsive.scaledPaddingLTRB(0, 0, 50, 0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Icon(Icons.phone_android),
//                         SizedBox(width: responsive.screenWidth / 50),
//                         Text(
//                           uic.phone.value.isNotEmpty
//                               ? "شماره تلفن :   ${uic.phone.value}"
//                               : "شماره تلفن",
//                           style: Theme.of(context).textTheme.bodyMedium,
//                         ),
//                       ],
//                     ),
//                   ),
//                   MyDivider(appWidth: responsive.screenWidth),
//                   Padding(
//                     padding: responsive.scaledPaddingLTRB(0, 0, 50, 0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         SvgPicture.asset(
//                           Assets.icons.subscription,
//                           height: responsive.screenHeight / 35,
//                           // ignore: deprecated_member_use
//                           color: Colors.white,
//                         ),
//                         SizedBox(width: responsive.screenWidth / 50),
//                         Text("وضعیت اشتراک : ",
//                             style: Theme.of(context).textTheme.bodyMedium),
//                         Text(
//                           uic.isSubscriber.value
//                               ? "اشتراک فعال دارید"
//                               : "اشتراک فعال ندارید",
//                           style: Theme.of(context).textTheme.bodyMedium,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: responsive.screenHeight / 40,
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       await GetStorage().remove('token'); // حذف توکن از حافظه
//                       if (GetStorage().read('token') == null) {
//                         Get.offAllNamed(AppRoutes.smsVerify);
//                       }
//                     },
//                     // استایل دکمه خروج
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF39FF14), // رنگ سبز
//                       padding: EdgeInsets.symmetric(
//                         horizontal: responsive.screenWidth / 7,
//                         vertical: responsive.screenHeight / 50,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text("خروج"),
//                   ),
//                   if (isEditing.value == true)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: responsive.screenWidth / 1.5,
//                           padding: responsive.scaledPaddingLTRB(10, 5, 10, 5),
//                           decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 255, 255, 255),
//                               borderRadius: BorderRadius.circular(10)),
//                           child: TextField(
//                             // focusNode: _focusNode,
//                             controller: nameUser,
//                             enabled: true,
//                             decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: "نام خود را وارد کنید",
//                                 hintStyle: Theme.of(context)
//                                     .textTheme
//                                     .labelMedium
//                                     ?.copyWith(
//                                       color: Colors.black45,
//                                     )),
//                             maxLines: 1,
//                             cursorColor: Colors.black45,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .labelMedium
//                                 ?.copyWith(
//                                   color: Colors.black,
//                                 ),
//                           ),
//                         ),
//                         IconButton(
//                             onPressed: () async {
//                               await uic.updateUserInfo(
//                                 fullName: nameUser.text, // اگه فقط نام عوض شده
//                                 isSubscriber: false, // اگه لازم بود
//                               );
//                               isEditing.value =
//                                   false; // بعد از ویرایش برمی‌گرده
//                             },
//                             icon: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.green,
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Padding(
//                                 padding:
//                                     EdgeInsets.all(responsive.scaleHeight * 15),
//                                 child: Icon(Icons.check),
//                               ),
//                             )),
//                       ],
//                     ),
//                 ],
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player_app/Constant/functions.dart';
import 'package:music_player_app/Constant/helper_size.dart';
import 'package:music_player_app/Controllers/user_info_controller.dart';
import 'package:music_player_app/Widgets/divider.dart';
import 'package:music_player_app/main.dart';

import '../gen/assets.gen.dart';

class UserProfileViewPage extends StatefulWidget {
  const UserProfileViewPage({super.key});

  @override
  State<UserProfileViewPage> createState() => _UserProfileViewPageState();
}

final UserInfoController uic = Get.put(UserInfoController());

final TextEditingController nameUser = TextEditingController();

class _UserProfileViewPageState extends State<UserProfileViewPage> {
  RxBool isEditing = false.obs;
  @override
  void initState() {
    super.initState();
    uic.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    // final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;//کیبورد
    final responsive = ResponsiveHelper(context);
    final token = GetStorage().read('token');
    if (token != null && token.isNotEmpty) {
      // بررسی انقضای توکن JWT و خروج در صورت انقضا
      checkJwtExpirationAndLogout(token);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(responsive.scaleHeight * 20),
                    bottomRight: Radius.circular(responsive.scaleHeight * 20),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 10.0, sigmaY: 10.0), // شدت تاری شیشه
                    child: Container(
                      height: responsive.screenHeight / 4,
                      width: responsive.screenWidth,
                      decoration: BoxDecoration(
                        color: Color(0xFF1A2B47)
                            .withOpacity(0.4), // رنگ شیشه‌ای با شفافیت

                        borderRadius: BorderRadius.only(
                          bottomLeft:
                              Radius.circular(responsive.scaleHeight * 20),
                          bottomRight:
                              Radius.circular(responsive.scaleHeight * 20),
                        ),
                      ),
                      child: Padding(
                        padding: responsive.scaledPaddingLTRB(15, 60, 15, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "پروفایل کاربری",
                              style:
                                  Theme.of(context).appBarTheme.titleTextStyle,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.offAllNamed(AppRoutes
                                      .homePage); // به صفحه اصلی برمی‌گردد
                                },
                                child: SvgPicture.asset(
                                  Assets.icons.arrowSmallLeft,
                                  // ignore: deprecated_member_use
                                  color: Colors.white,
                                  height: 32,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: responsive.screenWidth / 8,
                  top: responsive.screenHeight / 5.5,
                  child: Container(
                    height: responsive.screenHeight / 9,
                    width: responsive.screenWidth / 4.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: responsive.scaledPadding(7),
                      child: Image.asset(
                        Assets.svg.userProfilePic1.path,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        height: responsive.screenHeight / 6,
                      ),
                    ),
                  ),
                ),
                // دکمه خروج از اپ
                Positioned(
                  top: responsive.screenHeight / 5.2,
                  right: responsive.screenHeight / 2.65,
                  child: IconButton(
                    onPressed: () async {
                      await GetStorage().remove('token'); // حذف توکن از حافظه
                      if (GetStorage().read('token') == null) {
                        Get.offAllNamed(AppRoutes.smsVerify);
                      }
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                          color: Colors.white90,
                          borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: responsive.scaledPadding(10),
                        child: Image.asset(
                          Assets.icons.leavePng.path,
                          fit: BoxFit.cover,
                          width: responsive.screenHeight / 23,
                          height: responsive.screenHeight / 23,
                          color: Color.fromARGB(255, 255, 0, 102),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // بخش نام کاربر و ویرایش نام کاربر
            Padding(
              padding: responsive.scaledPaddingLTRB(0, 35, 20, 0),
              child: Obx(() {
                return Column(
                  children: [
                    if (uic.fullName.value.isNotEmpty)
                      Padding(
                        padding: responsive.scaledPaddingLTRB(0, 0, 50, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              uic.fullName.value,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            IconButton(
                                onPressed: () {
                                  isEditing.value = !isEditing.value;
                                  debugPrint("salamsas");
                                },
                                icon: Icon(Icons.edit)),
                          ],
                        ),
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "نام شما ثبت نشده",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          IconButton(
                              onPressed: () {
                                isEditing.value = !isEditing.value;
                              },
                              icon: Icon(Icons.edit)),
                        ],
                      ),
                    //کادر نام کاربر
                    if (isEditing.value == true)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: responsive.screenWidth / 1.5,
                            padding: responsive.scaledPaddingLTRB(10, 5, 10, 5),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              controller: nameUser,
                              enabled: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "نام خود را وارد کنید",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: Colors.black45,
                                      )),
                              maxLines: 1,
                              cursorColor: Colors.black45,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                await uic.updateUserInfo(
                                  fullName:
                                      nameUser.text, // اگه فقط نام عوض شده
                                  // isSubscriber: false, // اگه لازم بود
                                );
                                isEditing.value =
                                    false; // بعد از ویرایش برمی‌گرده
                              },
                              icon: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      responsive.scaleHeight * 15),
                                  child: Icon(Icons.check),
                                ),
                              )),
                        ],
                      ),
                  ],
                );
              }),
            ),
            SizedBox(
              height: responsive.screenHeight / 25,
            ),
            Padding(
              padding: responsive.scaledPaddingLTRB(0, 0, 50, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.phone_android),
                  SizedBox(width: responsive.screenWidth / 50),
                  Text(
                    uic.phone.value.isNotEmpty
                        ? "شماره تلفن :   ${uic.phone.value}"
                        : "شماره تلفن",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            MyDivider(appWidth: responsive.screenWidth),
            Padding(
              padding: responsive.scaledPaddingLTRB(0, 10, 50, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    Assets.icons.subscription,
                    height: responsive.screenHeight / 35,
                    // ignore: deprecated_member_use
                    color: Colors.white,
                  ),
                  SizedBox(width: responsive.screenWidth / 50),
                  Text("وضعیت اشتراک : ",
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text(
                    uic.isSubscriber.value
                        ? "اشتراک فعال دارید"
                        : "اشتراک فعال ندارید",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
