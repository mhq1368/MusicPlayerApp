import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player_app/Controllers/all_music_list_controller.dart';
import 'package:music_player_app/Views/home_screen_views.dart';
import 'package:music_player_app/Views/play_now_music.dart';
import 'package:music_player_app/Widgets/back_bottom_navbar.dart';
import 'package:music_player_app/Widgets/bottom_navbar.dart';

import '../gen/assets.gen.dart';

class AllMusicsListPage extends StatelessWidget {
  AllMusicsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AllMusicListController musicsController =
        Get.put(AllMusicListController());
    var size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false, // جلوگیری از بستن پیش‌فرض صفحه
      onPopInvokedWithResult: (didPop, result) {
        Get.offAll(() => HomePage());
      },
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 60,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
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
        body: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 35, 0, 25),
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
                              end: Alignment
                                  .bottomCenter, // نقطه‌ی پایان گرادینت
                            ),
                          ),
                        )
                      ]),
                    ),
                  ]),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * .51,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Obx(
                      () => ListView.builder(
                        itemCount: musicsController.allmusiclist.length,
                        itemBuilder: (context, index) {
                          var music = musicsController.allmusiclist[index];
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                  child: Container(
                                    height: size.height / 11.5,
                                    width: size.width / 1.1,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        gradient: LinearGradient(
                                            colors: [
                                              Color(0xff6987B7),
                                              Color(0xaa40577D),
                                              Color(0xff1A2B47),
                                            ],
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 25, left: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => PlayNowMusic(),
                                              arguments: {
                                                'music': musicsController
                                                    .allmusiclist[index],
                                                'singerid': musicsController
                                                    .allmusiclist[index]
                                                    .singerId
                                              });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(music.musicName!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall),
                                            Expanded(
                                              child: SizedBox(
                                                width: 20,
                                              ),
                                            ),
                                            Text(music.musictime!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall),
                                            IconButton(
                                              onPressed: () {
                                                Get.to(() => PlayNowMusic(),
                                                    arguments: {
                                                      'music': musicsController
                                                          .allmusiclist[index],
                                                      'singerid':
                                                          musicsController
                                                              .allmusiclist[
                                                                  index]
                                                              .singerId
                                                    });
                                              },
                                              icon: Icon(CupertinoIcons
                                                  .play_circle_fill),
                                              style: ButtonStyle(
                                                  iconColor:
                                                      WidgetStatePropertyAll(
                                                          Colors.white)),
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
                  ),
                ),
              )
            ],
          ),
          BackbottomNavbar(size: size),
          BottomNavbar(size: size)
        ]),
      ),
    );
  }
}
