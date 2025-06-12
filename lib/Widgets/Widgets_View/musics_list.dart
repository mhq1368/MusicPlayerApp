import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player_app/Constant/functions.dart';
import 'package:music_player_app/Constant/helper_size.dart';
import 'package:music_player_app/Controllers/all_music_list_controller.dart';
import 'package:music_player_app/Widgets/loading_spin_kit_pulse.dart';
import 'package:music_player_app/Widgets/myloading.dart';
import 'package:music_player_app/main.dart';

// ignore: must_be_immutable
class MusicsListHomePage extends StatefulWidget {
  late AllMusicListController musiccontroller;
  MusicsListHomePage({super.key}) {
    musiccontroller = Get.put(AllMusicListController());
  }

  @override
  State<MusicsListHomePage> createState() => _MusicsListHomePageState();
}

final box = GetStorage();

class _MusicsListHomePageState extends State<MusicsListHomePage> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    String? token = box.read('token');
    debugPrint("TokenHome: $token");

    // اگر توکن وجود نداشت، چیزی نمایش نده یا پیام بده
    if (token == null || token.isEmpty) {
      return Center(
        child: Text("برای مشاهده لیست خواننده‌ها ابتدا وارد شوید."),
      );
    }
    checkJwtExpirationAndLogout(token);

    return SizedBox(
      height: responsive.screenHeight / 2.1,
      width: double.infinity,
      child: Obx(() {
        if (widget.musiccontroller.isloading.value ||
            widget.musiccontroller.lasttenmusiclist.isEmpty) {
          return mainLoadingPulse(
              responsive.screenHeight / 2); // return اضافه شد
        } else {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.musiccontroller.lasttenmusiclist.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: responsive.scaledPaddingLTRB(20, 10, 20, 10),
                        child: GestureDetector(
                          onTap: () {
                            Get.offAndToNamed(AppRoutes.playNow, arguments: {
                              'music': widget
                                  .musiccontroller.lasttenmusiclist[index],
                              'singerid': widget.musiccontroller
                                  .lasttenmusiclist[index].singerId,
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: CachedNetworkImage(
                              width: responsive.screenWidth / 2.5,
                              height: responsive.screenHeight / 5.5,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              imageUrl: widget.musiccontroller
                                  .lasttenmusiclist[index].musicCover!
                                  .toString(),
                              placeholder: (context, url) => Center(
                                  child:
                                      mainLoading(responsive.screenHeight / 2)),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        widget.musiccontroller.lasttenmusiclist[index]
                                    .musicName!.length >
                                15
                            ? "${widget.musiccontroller.lasttenmusiclist[index].musicName!.substring(0, 15)}..."
                            : widget.musiccontroller.lasttenmusiclist[index]
                                .musicName!,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }
      }),
    );
  }
}
