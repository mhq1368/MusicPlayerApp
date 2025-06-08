// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player_app/Constant/functions.dart';
import 'package:music_player_app/Constant/helper_size.dart';
import 'package:music_player_app/Controllers/all_music_list_controller.dart';
import 'package:music_player_app/Views/home_screen_views.dart';
import 'package:music_player_app/Widgets/back_bottom_navbar.dart';
import 'package:music_player_app/Widgets/bottom_navbar.dart';
import 'package:music_player_app/main.dart';

import '../gen/assets.gen.dart';

class AllMusicsListPage extends StatelessWidget {
  const AllMusicsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AllMusicListController musicsController =
        Get.put(AllMusicListController());
    var size = MediaQuery.of(context).size;
    final responsive = ResponsiveHelper(context);
    String? token = box.read('token');
    if (token != null && token.isNotEmpty) {
      // بررسی انقضای توکن JWT و خروج در صورت انقضا
      checkJwtExpirationAndLogout(token);
    }
    return Scaffold(
      appBar: AppBar(
          scrolledUnderElevation: 0,
          elevation: 0,
          toolbarHeight: responsive.screenHeight / 11,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: responsive.scaledPaddingLTRB(15, 20, 15, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "لیست  نوا ها",
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
                InkWell(
                    onTap: () {
                      Get.off(() => HomePage());
                    },
                    child: SvgPicture.asset(
                      Assets.icons.arrowSmallLeft,
                      color: Colors.white,
                      height: 32,
                    )),
              ],
            ),
          )),
      body: WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(AppRoutes.homePage);
          return false;
        },
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height / 35,
              ),
              Center(
                child: Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Stack(children: [
                      Image.asset(
                        Assets.images.freepik42489730.path,
                        fit: BoxFit.cover,
                        alignment: Alignment.topRight,
                        width: size.width / 1.3,
                        height: size.height / 3.5,
                      ),
                      Container(
                        width: size.width / 1.3,
                        height: size.height / 3.5,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0x00ffffff),
                              Color.fromARGB(61, 255, 255, 255),
                              Color.fromARGB(129, 245, 245, 245)
                            ], // لیست رنگ‌ها
                            begin: Alignment.topCenter, // نقطه‌ی شروع گرادینت
                            end: Alignment.bottomCenter, // نقطه‌ی پایان گرادینت
                          ),
                        ),
                      )
                    ]),
                  ),
                ]),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: musicsController.allmusiclist.length,
                    itemBuilder: (context, index) {
                      var music = musicsController.allmusiclist[index];
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Container(
                                height: size.height / 11.5,
                                width: size.width / 1.1,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF273A5D),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white24,
                                    width: 1.2,
                                  ),
                                  gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(90, 105, 135, 183),
                                        Color(0xaa40577D),
                                        Color(0xff1A2B47),
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15, left: 15),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.offAndToNamed(AppRoutes.playNow,
                                          arguments: {
                                            'music': musicsController
                                                .allmusiclist[index],
                                            'singerid': musicsController
                                                .allmusiclist[index].singerId
                                          });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(CupertinoIcons.music_note,
                                            color: Colors.white, size: 22),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                music.musicName ?? "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                music.musictime ?? "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Colors.white70,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              CupertinoIcons.play_circle_fill,
                                              size: 24),
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          BackbottomNavbar(
              size: responsive.scaledBoxSize(responsive.screenHeight, 700)),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavbar(size: size),
          ),
        ]),
      ),
    );
  }
}
