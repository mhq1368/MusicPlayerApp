import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Constant/helper_size.dart';
import 'package:music_player_app/Controllers/musics_list_controller_by_singer.dart';
import 'package:music_player_app/Models/singer_model.dart';
import 'package:music_player_app/Widgets/back_bottom_navbar.dart';
import 'package:music_player_app/Widgets/bottom_navbar.dart';
import 'package:music_player_app/Widgets/myloading.dart';
import 'package:music_player_app/gen/assets.gen.dart';
import 'package:music_player_app/main.dart';

// ignore: must_be_immutable
class MusicsListBySingerId extends StatelessWidget {
  late MusicsListControllerBySinger musicsListControllerBySinger;
  late SingersModel singerModel;
  MusicsListBySingerId({super.key}) {
    singerModel = Get.arguments;
    musicsListControllerBySinger = Get.put(MusicsListControllerBySinger(
      singerid: singerModel.singerid,
    ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final responsive = ResponsiveHelper(context);
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "آهنگ های خواننده",
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
                InkWell(
                    onTap: () {
                      Get.offAllNamed(
                          AppRoutes.homePage); // به صفحه اصلی برمی‌گردد
                    },
                    child: SvgPicture.asset(
                      Assets.icons.arrowSmallLeft,
                      // ignore: deprecated_member_use
                      color: Colors.white,
                      height: 32,
                    )),
              ],
            ),
          )),
      body: SafeArea(
        child: Stack(children: [
          SizedBox(
            height: size.height,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 25, 10, 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: CachedNetworkImage(
                          height: size.height / 5.5,
                          width: size.width / 2.5,
                          fit: BoxFit.cover,
                          imageUrl: singerModel.singerpicurl!,
                          placeholder: (context, url) =>
                              Center(child: mainLoading(size.height / 2)),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 5.5,
                        width: size.width / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, top: 35),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    Assets.icons.microphone,
                                    // ignore: deprecated_member_use
                                    color: Colors.white70,
                                  ),
                                  SizedBox(
                                    width: size.width / 30,
                                  ),
                                  Text(
                                    singerModel.singername!,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 45, top: 25),
                              child: Obx(
                                () => Text(
                                    'تعداد نوا :   ${musicsListControllerBySinger.countmusics}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // لیست آهنگ های خواننده
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: SizedBox(
                        height: size.height / 2,
                        width: size.width,
                        child: Obx(() {
                          if (musicsListControllerBySinger.isloading.value) {
                            return mainLoading(size.height);
                          }
                          if (musicsListControllerBySinger
                              .musiclistbysinger.isEmpty) {
                            return Center(
                              child: Text(
                                "آهنگی برای این خواننده وجود ندارد",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            );
                          }

                          return ListView.builder(
                              itemCount: musicsListControllerBySinger
                                  .musiclistbysinger.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.offAndToNamed(AppRoutes.playNow,
                                              arguments: {
                                                'music':
                                                    musicsListControllerBySinger
                                                            .musiclistbysinger[
                                                        index],
                                                'singerid': singerModel.singerid
                                              });
                                        },
                                        child: Container(
                                          height: size.height / 11.5,
                                          width: size.width / 1.1,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
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
                                            child:

                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment.spaceEvenly,
                                                //   children: [
                                                //     Text(
                                                //       musicsListControllerBySinger
                                                //           .musiclistbysinger[index]
                                                //           .musicName!,
                                                //       style: Theme.of(context)
                                                //           .textTheme
                                                //           .titleSmall,
                                                //     ),
                                                //     Expanded(
                                                //       child: SizedBox(),
                                                //     ),
                                                //     Text(
                                                //       musicsListControllerBySinger
                                                //           .musiclistbysinger[index]
                                                //           .musictime!,
                                                //       style: Theme.of(context)
                                                //           .textTheme
                                                //           .titleSmall,
                                                //     ),
                                                //     IconButton(
                                                //       onPressed: () {},
                                                //       icon: Icon(CupertinoIcons
                                                //           .play_circle_fill),
                                                //       style: ButtonStyle(
                                                //           iconColor:
                                                //               WidgetStatePropertyAll(
                                                //                   Colors.white)),
                                                //     )
                                                //   ],
                                                // ),
                                                Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Icon(
                                                    CupertinoIcons.music_note,
                                                    color: Colors.white,
                                                    size: 22),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        musicsListControllerBySinger
                                                            .musiclistbysinger[
                                                                index]
                                                            .musicName!,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        musicsListControllerBySinger
                                                            .musiclistbysinger[
                                                                index]
                                                            .musictime!,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                              color: Colors
                                                                  .white70,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                      CupertinoIcons
                                                          .play_circle_fill,
                                                      size: 24),
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              });
                        })),
                  )
                ],
              ),
            ),
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
