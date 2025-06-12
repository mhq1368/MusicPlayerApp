import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player_app/Constant/functions.dart';
import 'package:music_player_app/Constant/helper_size.dart';
import 'package:music_player_app/Controllers/singers_controller.dart';
import 'package:music_player_app/Widgets/back_bottom_navbar.dart';
import 'package:music_player_app/Widgets/bottom_navbar.dart';
import 'package:music_player_app/Widgets/loading_spin_kit_pulse.dart';
import 'package:music_player_app/main.dart';

import '../gen/assets.gen.dart';

final box = GetStorage();

class SingersListPage extends StatelessWidget {
  SingersListPage({super.key});

  final SingersController singersController = Get.put(SingersController());
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    String? token = box.read('token');
    if (token != null && token.isNotEmpty) {
      // بررسی انقضای توکن JWT و خروج در صورت انقضا
      checkJwtExpirationAndLogout(token);
    }
    return Scaffold(
      appBar: AppBar(
          scrolledUnderElevation:
              0, //باعث میشه موقع اسکرول لیست رنگ Appbar تغییر نکنه
          elevation: 0,
          toolbarHeight: responsive.screenHeight / 13,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: responsive.scaledPaddingLTRB(5, 20, 5, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "لیست خوانندگان",
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
                      height: responsive.screenHeight / 25,
                    )),
              ],
            ),
          )),
      body: SafeArea(
        child: Stack(children: [
          Padding(
            padding: responsive.scaledPaddingLTRB(15, 0, 15, 30),
            child: Obx(() {
              if (singersController.singerlist.isEmpty) {
                return Center(
                  child: mainLoadingPulse(responsive.screenHeight / 2),
                );
              }
              return ListView.builder(
                padding: responsive.scaledPaddingLTRB(
                    0, 10, 0, 70), // 👈 این خط مهمه
                shrinkWrap: true,
                itemCount: singersController.singerlist.length,
                itemBuilder: (context, index) {
                  final singer = singersController.singerlist[index];
                  return Padding(
                    padding: responsive.scaledPaddingLTRB(5, 0, 5, 0),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.musicsListPageBySinger,
                            arguments: singersController.singerlist[index]);
                      },
                      child: Column(
                        children: [
                          Container(
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
                                padding:
                                    const EdgeInsets.fromLTRB(15, 20, 15, 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(CupertinoIcons.music_note,
                                        color: Colors.white, size: 22),
                                    SizedBox(
                                      width: responsive.screenHeight / 90,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("${singer.singername}"),
                                        SizedBox(
                                          height: responsive.screenHeight / 100,
                                        ),
                                        Text(
                                            "تعداد نواها : ${singer.musiccount ?? 0}"),
                                      ],
                                    ),
                                    Expanded(child: SizedBox()),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(1000),
                                      child: CachedNetworkImage(
                                        imageUrl: singer.singerpicurl!,
                                        height: responsive.screenHeight / 8,
                                        width: responsive.screenHeight / 8,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                        placeholder: (context, url) => Center(
                                            child: mainLoadingPulse(
                                                responsive.screenHeight / 2)),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          BackbottomNavbar(
              size: responsive.scaledBoxSize(responsive.screenHeight, 700)),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavbar(size: responsive.scaledBoxSize(0, 20)),
          ),
        ]),
      ),
    );
  }
}
