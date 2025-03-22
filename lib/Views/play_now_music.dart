import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Controllers/music_by_id_controller_play_now.dart';
import 'package:music_player_app/Controllers/musics_list_controller_by_singer.dart';
import 'package:music_player_app/Controllers/play_audio_controller.dart';
import 'package:music_player_app/Models/musics_model.dart';
import 'package:music_player_app/Views/home_screen_views.dart';
import 'package:music_player_app/Widgets/myloading.dart';

import '../gen/assets.gen.dart';

// ignore: must_be_immutable
class PlayNowMusic extends StatefulWidget {
  @override
  _PlayNowMusicState createState() => _PlayNowMusicState();
}

class _PlayNowMusicState extends State<PlayNowMusic> {
  late MusicModel musicModel; // تبدیل به Rxn برای واکنش به تغییرات
  late int singerid;
  late MusicByIdControllerPlayNow musicByIdControllerPlayNow;
  late PlayAudioController playAudioController;
  // final MusicsListControllerBySinger musicControllerBySingerId = Get.find();

  @override
  void initState() {
    super.initState();
    var args = Get.arguments;
    if (args is Map<String, dynamic>) {
      musicModel = args['music'] as MusicModel;
      singerid = args['singerid'] as int;
    }
    musicByIdControllerPlayNow =
        Get.put(MusicByIdControllerPlayNow(musicid: singerid));
    playAudioController = Get.put(
        PlayAudioController(musicid: musicModel.musicId, singerid: singerid));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Audio List: ${playAudioController.audiolist}");
    // playAudioController.currentmusic.value = musicModel.musicId!;
    debugPrint("Singer ID :$singerid");
    debugPrint("Music ID :${musicModel.musicId}");

    var size = MediaQuery.of(context).size;
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
                                    .audiolist[
                                        playAudioController.currentmusic.value]
                                    .musicCover!
                                    .toString(),
                                placeholder: (context, url) =>
                                    Center(child: mainLoading(size.height)),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
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
                                    Icon(Icons.error),
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
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  )
                                : Text(
                                    "در حال بارگذاری ...",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
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
                                if (playAudioController.isplaying.value ==
                                    true) {
                                  playAudioController.isplaying.value = false;
                                  playAudioController.player.stop();
                                  Get.offAll(() => PlayNowMusic(), arguments: {
                                    'music':
                                        playAudioController.audiolist[index],
                                    'singerid': musicModel.singerId
                                  });
                                }

                                debugPrint("s");
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 0),
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
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
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                              playAudioController
                                                  .audiolist[index].musicName!,
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
                                                  .audiolist[index].musictime!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(CupertinoIcons
                                                .play_circle_fill),
                                            style: ButtonStyle(
                                                iconColor:
                                                    WidgetStatePropertyAll(
                                                        Colors.white)),
                                          )
                                        ]),
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
                    ProgressBar(
                      barHeight: 10,
                      bufferedBarColor: Color.fromARGB(255, 237, 216, 178),
                      timeLabelTextStyle:
                          Theme.of(context).textTheme.labelSmall,
                      thumbColor: Color(0xffF2E1C1),
                      progressBarColor: Color.fromARGB(255, 237, 216, 178),
                      baseBarColor: Color(0xfff5f5f5),
                      progress: Duration(seconds: 25),
                      total: Duration(seconds: 120),
                      buffered: Duration(seconds: 15),
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
                            // playAudioController.playNextTrack();
                          },
                          child: SvgPicture.asset(
                            Assets.icons.forward,
                            height: 32,
                            // ignore: deprecated_member_use
                            color: Color(0xffF2E1C1),
                          ),
                        ),
                        // شروع کردن به پخش موزیک
                        GestureDetector(
                          onTap: () async {
                            if (playAudioController.isplaying.value == false) {
                              playAudioController.isplaying.value = true;
                              playAudioController.currentmusic.value =
                                  playAudioController.player.currentIndex!;
                              playAudioController.player.play();
                            } else if (playAudioController.isplaying.value ==
                                true) {
                              playAudioController.isplaying.value = false;
                              playAudioController.player.pause();
                            }
                          },
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Obx(
                              () => Center(
                                  child: playAudioController.isplaying.value ==
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
                            ),
                          ),
                        ),
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
      ),
    );
  }
}
