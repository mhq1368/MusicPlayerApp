// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player_app/Constant/functions.dart';
import 'package:music_player_app/Controllers/play_audio_controller.dart';
import 'package:music_player_app/Models/musics_model.dart';
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

  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    String? token = box.read('token');
    if (token != null && token.isNotEmpty) {
      // بررسی انقضای توکن JWT و خروج در صورت انقضا
      checkJwtExpirationAndLogout(token);
    }
    var appScreen = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("پخش نوا",
                  style: Theme.of(context).appBarTheme.titleTextStyle),
              InkWell(
                onTap: () {
                  Get.offAndToNamed(AppRoutes.homePage);
                  if (playAudioController.isplaying.value == true) {
                    playAudioController.isplaying.value = false;
                    playAudioController.player.stop();
                  }
                },
                child: SvgPicture.asset(
                  Assets.icons.arrowSmallLeft,
                  color: Colors.white,
                  height: 32,
                ),
              ),
            ],
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Stack(
          children: [
            Column(
              children: [
                // تصویر کاور
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(deviceBasedRadius(context)),
                        topRight: Radius.circular(deviceBasedRadius(context))),
                    child: Obx(() {
                      final list = playAudioController.audiolist;
                      final index = playAudioController.currentmusic.value;

                      if (list.isEmpty) {
                        return SizedBox(
                          width: appScreen.size.width / 1.2,
                          height: appScreen.size.height / 4,
                          child:
                              Center(child: mainLoading(appScreen.size.height)),
                        );
                      }
                      // ایندکس امن با استفاده از مدولو
                      final safeIdx = list.isEmpty ? 0 : index % list.length;
                      return CachedNetworkImage(
                        width: appScreen.size.width / 1.2,
                        height: appScreen.size.height / 4,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        imageUrl: list[safeIdx].musicCover!,
                        placeholder: (context, url) =>
                            Center(child: mainLoading(appScreen.size.height)),
                        errorWidget: (context, url, error) => Center(
                            child: mainLoading(appScreen.size.height / 3)),
                      );
                    }),
                  ),
                ),

                // باکس اطلاعات آهنگ
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(deviceBasedRadius(context)),
                      bottomRight: Radius.circular(deviceBasedRadius(context)),
                    ),
                    child: Container(
                      width: appScreen.size.width / 1.2,
                      height: appScreen.size.height / 13,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xffF2E1C1), Color(0xffd2ba90)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(color: Colors.white24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          SvgPicture.asset(
                            Assets.icons.microphone,
                            height: 24,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Obx(() {
                              playAudioController.waitForDuration();
                              final list = playAudioController.audiolist;
                              final index =
                                  playAudioController.currentmusic.value;
                              final safeIdx =
                                  list.isEmpty ? 0 : index % list.length;
                              return Text(
                                list.isEmpty
                                    ? "در حال بارگذاری..."
                                    : list[safeIdx].musicName!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.black87),
                                overflow: TextOverflow.ellipsis,
                              );
                            }),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ),
                ),

                // لیست آهنگ‌ها
                SizedBox(height: appScreen.size.height / 90),
                SizedBox(
                  width: double.infinity,
                  height: appScreen.size.height / 2 + appScreen.padding.bottom,
                  child: Obx(() {
                    final list = playAudioController.audiolist;
                    return list.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.only(
                                bottom: appScreen.padding.bottom +
                                    appScreen.size.height / 4.9),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final iscurrent = index ==
                                  playAudioController.currentmusic.value;
                              return GestureDetector(
                                onTap: () async {
                                  // if (playAudioController.isplaying.value) {
                                  //   playAudioController.isplaying.value = false;
                                  //   playAudioController.player.stop();
                                  // }

                                  await playAudioController.playAnotherMusic(
                                      list[index].singerId!,
                                      list[index].musicId!);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF273A5D),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: Colors.white24, width: 1.2),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color.fromARGB(35, 105, 135, 183),
                                          Color(0xaa40577D),
                                          Color.fromARGB(133, 26, 43, 71),
                                        ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 20),
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
                                                list[index].musicName ?? "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                list[index].musictime ?? "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: Colors.white70),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Get.to(() => const PlayNowMusic(),
                                                arguments: {
                                                  'music': list[index],
                                                  'singerid':
                                                      list[index].singerId,
                                                });
                                          },
                                          icon: const Icon(
                                            CupertinoIcons.play_circle_fill,
                                            size: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(child: mainLoading(appScreen.size.height / 3));
                  }),
                ),
              ],
            ),

            // ✅ پلیر پایین
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: player(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

// کنترل موزیک
  Padding player(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: SizedBox(
        height: size.height / 5.2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  Obx(() => ProgressBar(
                        barHeight: 7,
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
                      )),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _controlIcon(Assets.icons.bookmarkSvg),
                      GestureDetector(
                          onTap: () {
                            playAudioController.player.seekToNext();
                            playAudioController.currentmusic.value =
                                playAudioController.player.currentIndex ?? 0;
                          },
                          child: _controlIcon(Assets.icons.forward)),
                      GestureDetector(
                        onTap: () async {
                          if (playAudioController.isplaying.value) {
                            await playAudioController.player.pause();
                            playAudioController.isplaying.value = false;
                          } else {
                            await playAudioController.player.play();
                            playAudioController.isplaying.value = true;
                            playAudioController.startProgress();
                          }
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xffF2E1C1), Color(0xffd2ba90)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
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
                      ),
                      GestureDetector(
                          onTap: () {
                            playAudioController.player.seekToPrevious();
                            playAudioController.currentmusic.value =
                                playAudioController.player.currentIndex ?? 0;
                          },
                          child: _controlIcon(Assets.icons.rewind)),
                      _controlIcon(Assets.icons.shuffle),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 🎯 ویجت آیکن دکمه کناری
Widget _controlIcon(String asset) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.05),
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white24),
    ),
    child: SvgPicture.asset(
      asset,
      height: 24,
      color: const Color(0xffF2E1C1),
    ),
  );
}
