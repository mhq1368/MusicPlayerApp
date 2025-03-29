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
import '../gen/assets.gen.dart';

class PlayNowMusic extends StatefulWidget {
  const PlayNowMusic({super.key});

  @override
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
    debugPrint("Audio List: ${playAudioController.audiolist.toList()}");

    debugPrint("Singer ID :$singerid");
    debugPrint("Music ID :${musicModel.musicId}");
    playAudioController.currentmusic.value = musicModel.musicId!;
    var size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false, // جلوگیری از بستن پیش‌فرض صفحه
      onPopInvokedWithResult: (didPop, result) {
        // playAudioController.player.stop();
        Get.offAll(() => HomePage());
      },
      child: Scaffold(
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
                          Get.offAll(() => HomePage());
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
                          child: Obx(
                            () => playAudioController.audiolist.isNotEmpty
                                ? CachedNetworkImage(
                                    width: size.width / 1.2,
                                    height: size.height / 4,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                    imageUrl: playAudioController
                                        .audiolist[playAudioController
                                            .currentmusic.value]
                                        .musicCover!
                                        .toString(),
                                    placeholder: (context, url) =>
                                        Center(child: mainLoading(size.height)),
                                    errorWidget: (context, url, error) =>
                                        Center(
                                      child: mainLoading(size.height / 3),
                                    ),
                                  )
                                : CachedNetworkImage(
                                    width: size.width / 1.2,
                                    height: size.height / 4,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                    imageUrl: "",
                                    placeholder: (context, url) =>
                                        Center(child: mainLoading(size.height)),
                                    errorWidget: (context, url, error) =>
                                        Center(
                                            child:
                                                mainLoading(size.height / 3)),
                                  ),
                          ),
                        ),
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
                                () => playAudioController.audiolist.isNotEmpty
                                    ? Text(
                                        playAudioController
                                            .audiolist[playAudioController
                                                .currentmusic.value]
                                            .musicName!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      )
                                    : Text(
                                        "در حال بارگذاری ...",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                      //لیست آهنگ های خواننده
                      SingleChildScrollView(
                        child: SizedBox(
                          height: size.height / 3,
                          width: double.infinity,
                          child: Obx(() {
                            return ListView.builder(
                              itemCount: playAudioController.audiolist.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    playAudioController.isplaying.value = false;
                                    playAudioController.player.stop();
                                    Get.offAll(() => PlayNowMusic(),
                                        arguments: {
                                          'music': playAudioController
                                              .audiolist[index],
                                          'singerid': musicModel.singerId
                                        });

                                    debugPrint("s");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 20, 10, 0),
                                    child: Container(
                                      height: 60,
                                      width: double.infinity,
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
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 15, 0),
                                        child: Obx(
                                          () => Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                    playAudioController
                                                        .audiolist[index]
                                                        .musicName!,
                                                    style: playAudioController
                                                                .currentmusic ==
                                                            index
                                                        ? Theme.of(context)
                                                            .textTheme
                                                            .displaySmall
                                                        : Theme.of(context)
                                                            .textTheme
                                                            .displayLarge),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: 20,
                                                  ),
                                                ),
                                                Text(
                                                    playAudioController
                                                        .audiolist[index]
                                                        .musictime!,
                                                    style: playAudioController
                                                                .currentmusic ==
                                                            index
                                                        ? Theme.of(context)
                                                            .textTheme
                                                            .displaySmall
                                                        : Theme.of(context)
                                                            .textTheme
                                                            .displayLarge),
                                                IconButton(
                                                  onPressed: () {
                                                    playAudioController
                                                        .isplaying
                                                        .value = false;
                                                    playAudioController.player
                                                        .stop();
                                                    Get.offAll(
                                                        () => PlayNowMusic(),
                                                        arguments: {
                                                          'music':
                                                              playAudioController
                                                                      .audiolist[
                                                                  index],
                                                          'singerid': musicModel
                                                              .singerId
                                                        });
                                                  },
                                                  icon: Icon(CupertinoIcons
                                                      .play_circle_fill),
                                                  style: playAudioController
                                                              .currentmusic ==
                                                          index
                                                      ? ButtonStyle(
                                                          iconColor:
                                                              WidgetStatePropertyAll(
                                                                  Colors.white))
                                                      : ButtonStyle(
                                                          iconColor:
                                                              WidgetStatePropertyAll(
                                                                  Color(
                                                                      0x90ffffff))),
                                                )
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
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
                  padding: const EdgeInsets.only(top: 5, bottom: 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 120,
                    child: Column(
                      children: [
                        //ProgressBar  برای پخش موزیک
                        Obx(
                          () => ProgressBar(
                            barHeight: 10,
                            bufferedBarColor:
                                Color.fromARGB(255, 237, 216, 178),
                            timeLabelTextStyle:
                                Theme.of(context).textTheme.labelSmall,
                            thumbColor: Color(0xffF2E1C1),
                            progressBarColor:
                                Color.fromARGB(255, 237, 216, 178),
                            baseBarColor: Color(0xfff5f5f5),
                            progress: playAudioController.progressValue.value,
                            total: playAudioController.player.duration ??
                                Duration(seconds: 0),
                            buffered: playAudioController.bufferedValue.value,
                            onSeek: (position) {
                              playAudioController.player.seek(position);
                              playAudioController.player.playing
                                  ? playAudioController.startProgress()
                                  : playAudioController.timer!.cancel();
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              Assets.icons.bookmarkSvg,
                              height: 25,
                              // ignore: deprecated_member_use
                              color: Color(0xffF2E1C1),
                            ),
                            //رفتن به موزیک بعدی
                            GestureDetector(
                              onTap: () async {
                                playAudioController.player.seekToNext();
                                playAudioController.currentmusic.value =
                                    playAudioController.player.currentIndex!;
                              },
                              child: SvgPicture.asset(
                                Assets.icons.forward,
                                height: 32,
                                // ignore: deprecated_member_use
                                color: Color(0xffF2E1C1),
                              ),
                            ),
                            // شروع کردن به پخش موزیک
                            Obx(() => GestureDetector(
                                onTap: () async {
                                  playAudioController
                                      .player.processingStateStream
                                      .listen((state) {
                                    if (state == ProcessingState.completed) {
                                      playAudioController.player.seek(
                                          Duration.zero); // بازگشت به اول آهنگ
                                      playAudioController.player
                                          .play(); // دوباره پخش کن
                                    }
                                  });

                                  if (playAudioController.player.playing) {
                                    playAudioController.player.pause();
                                    playAudioController.isplaying.value = false;
                                  } else {
                                    playAudioController.isplaying.value = true;
                                    playAudioController.startProgress();
                                    playAudioController.player.play();
                                    playAudioController.isplaying.value =
                                        playAudioController.player.playing;

                                    playAudioController.currentmusic.value =
                                        playAudioController
                                            .player.currentIndex!;
                                  }
                                },
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                      child: playAudioController
                                                  .isplaying.value ==
                                              false
                                          ? SvgPicture.asset(
                                              Assets.icons
                                                  .play, // Path to your triangle SVG
                                              width: 30,
                                              height: 30,
                                              // ignore: deprecated_member_use
                                              color: Color(
                                                  0xff3C5782) // Set the color of the triangle
                                              )
                                          : Icon(
                                              CupertinoIcons.pause_solid,
                                              color: Color(0xff3C5782),
                                              size: 37,
                                            )),
                                ))),

                            //برگشت به موزیک قبلی
                            GestureDetector(
                              onTap: () {
                                playAudioController.player.seekToPrevious();
                                playAudioController.currentmusic.value =
                                    playAudioController.player.currentIndex!;
                              },
                              child: SvgPicture.asset(
                                Assets.icons.rewind,
                                height: 32,
                                // ignore: deprecated_member_use
                                color: Color(0xffF2E1C1),
                              ),
                            ),
                            SvgPicture.asset(
                              Assets.icons.shuffle,
                              height: 25,
                              // ignore: deprecated_member_use
                              color: Color(0xffF2E1C1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
