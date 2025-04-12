import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/Controllers/play_audio_controller.dart';
import 'package:music_player_app/Models/musics_model.dart';
import 'package:music_player_app/Views/home_screen_views.dart';
import 'package:music_player_app/Widgets/myloading.dart';
import 'package:music_player_app/main.dart';
import '../gen/assets.gen.dart';

class PlayNowMusic extends StatefulWidget {
  const PlayNowMusic({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlayNowMusicState createState() => _PlayNowMusicState();
}

class _PlayNowMusicState extends State<PlayNowMusic> {
  late MusicModel musicModel;
  late int singerid;

  // late MusicByIdControllerPlayNow musicByIdControllerPlayNow;
  late PlayAudioController playAudioController;
  @override
  void initState() {
    super.initState();
    var args = Get.arguments;
    if (args is Map<String, dynamic>) {
      musicModel = args['music'] as MusicModel;
      singerid = args['singerid'] as int;
    }
    playAudioController = Get.put(
        PlayAudioController(musicid: musicModel.musicId, singerid: singerid));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Singer ID :$singerid");
    debugPrint("Music ID :${musicModel.musicId}");
    var size = MediaQuery.of(context).size;
    debugPrint("Audio List: ${playAudioController.audiolist.toList()}");
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
                    "پخش آهنگ",
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                  InkWell(
                      onTap: () {
                        Get.offAndToNamed(AppRoutes.homePage);
                        if (playAudioController.isplaying.value == true) {
                          playAudioController.isplaying.value == false;
                          playAudioController.player.stop();
                        }
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
        body: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25)),
                          child: Obx(() {
                            final list = playAudioController.audiolist;
                            final index =
                                playAudioController.currentmusic.value;

                            if (list.isEmpty || index >= list.length) {
                              return Container(
                                width: size.width / 1.2,
                                height: size.height / 4,
                                child: Center(child: mainLoading(size.height)),
                              );
                            }

                            return CachedNetworkImage(
                              width: size.width / 1.2,
                              height: size.height / 4,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              imageUrl: list[index].musicCover ?? "",
                              placeholder: (context, url) =>
                                  Center(child: mainLoading(size.height)),
                              errorWidget: (context, url, error) =>
                                  Center(child: mainLoading(size.height / 3)),
                            );
                          })),
                    ),

                    Container(
                      height: 65,
                      width: size.width / 1.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25)),
                          color: Color(0xffF1D9AB)),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              Assets.icons.microphone,
                              height: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Obx(
                              () {
                                final list = playAudioController.audiolist;
                                final index =
                                    playAudioController.currentmusic.value;

                                if (list.isEmpty || index >= list.length) {
                                  return Text("در حال بارگذاری ...",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(color: Colors.black87));
                                }

                                return Text(
                                  list[index].musicName ??
                                      "نام آهنگ نامشخص است",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.black87),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    //لیست آهنگ های خواننده
                    SingleChildScrollView(
                      child: SizedBox(
                        height: size.height / 3,
                        width: double.infinity,
                        child: Obx(
                          () {
                            final list = playAudioController.audiolist;
                            return list.isNotEmpty
                                ? ListView.builder(
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      final iscurrent = index ==
                                          playAudioController
                                              .currentmusic.value;

                                      return GestureDetector(
                                        onTap: () {
                                          playAudioController.isplaying.value =
                                              false;
                                          playAudioController.player.stop();
                                          Get.offAndToNamed(AppRoutes.playNow,
                                              arguments: {
                                                'music': list[index],
                                                'singerid': list[index].singerId
                                              });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 20, 10, 0),
                                          child: Container(
                                            height: 60,
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
                                                end: Alignment.bottomLeft,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
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
                                                          list[index]
                                                                  .musicName ??
                                                              "",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        const SizedBox(
                                                            height: 4),
                                                        Text(
                                                          list[index]
                                                                  .musictime ??
                                                              "",
                                                          style:
                                                              Theme.of(context)
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
                                                    onPressed: () {
                                                      Get.to(
                                                          () => PlayNowMusic(),
                                                          arguments: {
                                                            'music':
                                                                list[index],
                                                            'singerid':
                                                                list[index]
                                                                    .singerId,
                                                          });
                                                    },
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
                                      );
                                    },
                                  )
                                : mainLoading(size.height / 2);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // بخش کنترل پخش موزیک
            Positioned(
              bottom: 10,
              left: 15,
              right: 15,
              top: size.height / 1.45,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  width: double.infinity,
                  height: 120,
                  child: Column(
                    children: [
                      // ProgressBar
                      Obx(
                        () => ProgressBar(
                          barHeight: 10,
                          bufferedBarColor:
                              const Color.fromARGB(255, 237, 216, 178),
                          timeLabelTextStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                          thumbColor: const Color(0xffF2E1C1),
                          progressBarColor:
                              const Color.fromARGB(255, 237, 216, 178),
                          baseBarColor: const Color(0xfff5f5f5),
                          progress: playAudioController.progressValue.value,
                          total: playAudioController.player.duration ??
                              Duration.zero,
                          buffered: playAudioController.bufferedValue.value,
                          onSeek: (position) {
                            playAudioController.player.seek(position);
                            if (playAudioController.isplaying.value) {
                              playAudioController.startProgress();
                            } else {
                              playAudioController.timer?.cancel();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      // دکمه‌های کنترل
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            Assets.icons.bookmarkSvg,
                            height: 25,
                            color: const Color(0xffF2E1C1),
                          ),
                          // دکمه بعدی
                          GestureDetector(
                            onTap: () {
                              playAudioController.player.seekToNext();
                              playAudioController.currentmusic.value =
                                  playAudioController.player.currentIndex ?? 0;
                            },
                            child: SvgPicture.asset(
                              Assets.icons.forward,
                              height: 32,
                              color: const Color(0xffF2E1C1),
                            ),
                          ),
                          // دکمه پخش/توقف
                          GestureDetector(
                            onTap: () async {
                              if (playAudioController.isplaying.value) {
                                await playAudioController.player.pause();
                                playAudioController.isplaying.value = false;
                              } else {
                                await playAudioController.player.play();
                                playAudioController.isplaying.value =
                                    true; // 🔁 حتماً بعد از play
                                playAudioController.startProgress();
                              }
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Obx(() => Center(
                                    child: playAudioController.isplaying.value
                                        ? const Icon(
                                            CupertinoIcons.pause_solid,
                                            color: Color(0xff3C5782),
                                            size: 37,
                                          )
                                        : SvgPicture.asset(
                                            Assets.icons.play,
                                            width: 30,
                                            height: 30,
                                            color: const Color(0xff3C5782),
                                          ),
                                  )),
                            ),
                          ), // دکمه قبلی
                          GestureDetector(
                            onTap: () {
                              playAudioController.player.seekToPrevious();
                              playAudioController.currentmusic.value =
                                  playAudioController.player.currentIndex ?? 0;
                            },
                            child: SvgPicture.asset(
                              Assets.icons.rewind,
                              height: 32,
                              color: const Color(0xffF2E1C1),
                            ),
                          ),
                          SvgPicture.asset(
                            Assets.icons.shuffle,
                            height: 25,
                            color: const Color(0xffF2E1C1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
