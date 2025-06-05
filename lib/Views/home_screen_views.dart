// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player_app/Constant/functions.dart';
import 'package:music_player_app/Constant/helper_size.dart';
import 'package:music_player_app/Controllers/user_info_controller.dart';

import 'package:music_player_app/Widgets/Widgets_View/singers_list.dart';
import 'package:music_player_app/Widgets/back_bottom_navbar.dart';
import 'package:music_player_app/Widgets/bottom_navbar.dart';
import 'package:music_player_app/Widgets/drawer_widgets.dart';
import 'package:music_player_app/Widgets/my_bottom_app.dart';
import 'package:music_player_app/gen/assets.gen.dart';
import 'package:music_player_app/main.dart';

final box = GetStorage();

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<ScaffoldState> drawer = GlobalKey();
  final TextEditingController _search = TextEditingController();
  final UserInfoController userInfoController = Get.put(UserInfoController());
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    var responsive = ResponsiveHelper(context);
    String? token = box.read('token');
    if (token != null && token.isNotEmpty) {
      // بررسی انقضای توکن JWT و خروج در صورت انقضا
      checkJwtExpirationAndLogout(token);
    }
    userInfoController.getUserInfo();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: drawer,
      drawer: drawerApp(responsive.scaledBoxSize(20, 50), context),
      appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      drawer.currentState!.openDrawer();
                    },
                    icon: Icon(Icons.menu)),

                //لوگو اپ با ایجاد سایه
                Stack(alignment: Alignment.center, children: [
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.amber.withOpacity(0.6),
                        BlendMode.srcATop,
                      ),
                      child: Image.asset(
                        Assets.icons.logo.path,
                        height: responsive.screenHeight / 15,
                      ),
                    ),
                  ),
                  Image.asset(
                    Assets.icons.logo.path,
                    height: responsive.screenHeight / 15,
                  ),
                ]),
                token == null || token.isEmpty
                    ? IconButton(
                        iconSize: responsive.screenHeight / 30,
                        onPressed: () {
                          Get.offAndToNamed(AppRoutes.smsVerify);
                        },
                        icon: Icon(CupertinoIcons.profile_circled))
                    : Container(
                        decoration: BoxDecoration(
                            // color: Colors.black,
                            // borderRadius: BorderRadius.circular(50)
                            ),
                        padding: EdgeInsets.all(5),
                        child: InkWell(
                          onTap: () {
                            Get.offAndToNamed(AppRoutes.userProfileInfo);
                          },
                          child: Column(
                            children: [
                              Icon(
                                CupertinoIcons.profile_circled,
                                size: responsive.screenHeight / 27,
                              ),
                              Obx(
                                () {
                                  userInfoController.isLoading.value
                                      ? Center(child: Text("data"))
                                      : Container();

                                  if (userInfoController
                                      .fullName.value.isEmpty) {
                                    return Text(
                                      userInfoController.phone.value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                    );
                                  } else {
                                    return Text(
                                      userInfoController.fullName.value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          )),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Stack(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  width: responsive.screenHeight / 1.2,
                  // height: size.height / 4,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _search,
                    autocorrect: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "خواننده ، نوا ، آلبوم",
                        hintStyle: Theme.of(context).textTheme.labelSmall),
                    cursorColor: Colors.black,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
              Center(
                  child: myBottomAppBar(
                      context,
                      Text(
                        "جستجو",
                        style: TextStyle(
                            color: Color(0xFF3C5782),
                            fontFamily: "Peyda-M",
                            fontWeight: FontWeight.w800,
                            fontSize: responsive.screenHeight / 50),
                      ))),

              //خوانندگان برتر
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "خوانندگان برتر",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    InkWell(
                      onTap: () {
                        Get.offAndToNamed(AppRoutes.singersListPage);
                      },
                      child: Text(
                        "نمایش همه",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
              SingersListHomePage(),
            ],
          ),
          BackbottomNavbar(size: responsive.scaledBoxSize(0, 700)),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavbar(size: responsive.scaledBoxSize(0, 20)),
          ),
        ]),
      ),
    );
  }
}
