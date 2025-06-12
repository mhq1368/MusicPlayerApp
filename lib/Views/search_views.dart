import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_player_app/Controllers/my_search_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Constant/helper_size.dart';
import 'package:music_player_app/Controllers/singers_controller.dart';
import 'package:music_player_app/Models/musics_model.dart';
import 'package:music_player_app/Models/search_model.dart';
import 'package:music_player_app/Models/singer_model.dart';
import 'package:music_player_app/Widgets/back_bottom_navbar.dart';
import 'package:music_player_app/Widgets/bottom_navbar.dart';
import 'package:music_player_app/Widgets/loading_spin_kit_pulse.dart';
import 'package:music_player_app/main.dart';

import '../gen/assets.gen.dart';

class SearchViewsPage extends StatelessWidget {
  late SingersModel sm;
  late String query;
  late MySearchControllers searchController;
  late SingersController singersController;
  late SearchModel searchModel;
  late String type;
  SearchViewsPage({super.key}) {
    searchController = Get.put(MySearchControllers());
    query = Get.arguments['query'];
    searchController.searchMusic(query);
  }
// تبدیل SearchModel به SingersModel
  SingersModel mapSearchToSinger(SearchModel model) {
    return SingersModel(
      singerid: model.singerId,
      singername: model.name,
      singerpicurl: model.picUrl,
    );
  }

  MusicModel mapSearchToMusic(SearchModel model) {
    return MusicModel(
      musicId: model.musicId,
      musicName: model.name,
      musicCover: model.cover,
      musicUrl: model.url,
      musictime: '', // اگر مدت زمان در SearchModel نیست
      singerId: 0, // اگر مشخص نیست، صفر بذار یا مقدار پیش‌فرض
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    return Scaffold(
      appBar: AppBar(
          scrolledUnderElevation:
              0, //باعث میشه موقع اسکرول لیست رنگ Appbar تغییر نکنه
          elevation: 0,
          toolbarHeight: responsive.screenHeight / 13,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: responsive.scaledPaddingLTRB(5, 20, 5, 20),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  searchController.type.value == "Music"
                      ? Text(
                          "لیست آهنگ ها",
                          style: Theme.of(context).appBarTheme.titleTextStyle,
                        )
                      : Text(
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
            ),
          )),
      body: SafeArea(
        child: Stack(children: [
          Padding(
            padding: responsive.scaledPaddingLTRB(15, 0, 15, 30),
            child: Obx(() {
              return ListView.builder(
                padding: responsive.scaledPaddingLTRB(
                    0, 10, 0, 70), // 👈 این خط مهمه
                shrinkWrap: true,
                itemCount: searchController.musicListSearch.length,
                itemBuilder: (context, index) {
                  final itmes = searchController.musicListSearch[index];
                  return Padding(
                    padding: responsive.scaledPaddingLTRB(5, 0, 5, 0),
                    child: GestureDetector(
                      onTap: () {
                        final singer = mapSearchToSinger(itmes);
                        final music = mapSearchToMusic(itmes);
                        if (searchController.type.value == "Singer") {
                          Get.toNamed(AppRoutes.musicsListPageBySinger,
                              arguments: singer);
                        } else {
                          Get.toNamed(AppRoutes.playNow, arguments: {
                            'music': music,
                            'singerid': singer.singerid,
                          });
                        }
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
                                    const EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                                        Text("${itmes.name}"),
                                      ],
                                    ),
                                    Expanded(child: SizedBox()),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            itmes.picUrl ?? itmes.cover ?? "",
                                        height: responsive.screenHeight / 13,
                                        width: responsive.screenHeight / 13,
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
