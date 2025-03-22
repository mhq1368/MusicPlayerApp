import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Controllers/singers_controller.dart';
import 'package:music_player_app/Views/musics_list_by_singer_id.dart';
import 'package:music_player_app/Widgets/myloading.dart';

// ignore: must_be_immutable
class SingersListHomePage extends StatelessWidget {
  late SingersController singersController;
  SingersListHomePage({super.key}) {
    singersController = Get.put(SingersController());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 3.1,
      width: double.infinity,
      child: Obx(() {
        if (singersController.singerlist.isEmpty) {
          mainLoading(size.height / 2);
        }
        if (singersController.isloading.value) {
          mainLoading(size.height / 2);
        } else {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: singersController.singerlist.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: GestureDetector(
                          onTap: () {
                            Get.off(() => MusicsListBySingerId(),
                                arguments: singersController.singerlist[index]);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: CachedNetworkImage(
                              width: size.width / 2,
                              height: size.height / 4,
                              fit: BoxFit.cover,
                              imageUrl: singersController
                                  .singerlist[index].singerpicurl!,
                              placeholder: (context, url) =>
                                  Center(child: mainLoading(size.height)),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        singersController.singerlist[index].singername!,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }
        return mainLoading(size.height);
      }),
    );
  }
}
