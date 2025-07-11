import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player_app/Constant/functions.dart';
import 'package:music_player_app/Constant/helper_size.dart';
import 'package:music_player_app/Controllers/singers_controller.dart';
import 'package:music_player_app/Widgets/loading_spin_kit_pulse.dart';
import 'package:music_player_app/Widgets/myloading.dart';
import 'package:music_player_app/main.dart';

// ignore: must_be_immutable
class SingersListHomePage extends StatefulWidget {
  late SingersController singersController;
  SingersListHomePage({super.key}) {
    singersController = Get.put(SingersController());
  }

  @override
  State<SingersListHomePage> createState() => _SingersListHomePageState();
}

final box = GetStorage();

class _SingersListHomePageState extends State<SingersListHomePage> {
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
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

    return RefreshIndicator(
      onRefresh: () async {
        // ریفرش کردن لیست خوانندگان
        await widget.singersController.showsingerslist();
      },
      child: SizedBox(
        height: responsive.screenHeight / 3.5,
        width: double.infinity,
        child: Obx(() {
          if (widget.singersController.isloading.value ||
              widget.singersController.singerlist.isEmpty) {
            return mainLoadingPulse(
                responsive.screenHeight / 2); // return اضافه شد
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.singersController.singerlist.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: responsive.scaledPaddingLTRB(20, 10, 20, 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.offAndToNamed(
                                  AppRoutes.musicsListPageBySinger,
                                  arguments: widget
                                      .singersController.singerlist[index]);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: CachedNetworkImage(
                                width: responsive.screenWidth / 2.5,
                                height: responsive.screenHeight / 5.5,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                imageUrl: widget.singersController
                                    .singerlist[index].singerpicurl!,
                                placeholder: (context, url) => Center(
                                    child: mainLoading(
                                        responsive.screenHeight / 2)),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          widget
                              .singersController.singerlist[index].singername!,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          }
        }),
      ),
    );
  }
}
