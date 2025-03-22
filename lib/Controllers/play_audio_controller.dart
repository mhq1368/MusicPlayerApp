import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/Constant/url_const.dart';
import 'package:music_player_app/Models/musics_model.dart';
import 'package:music_player_app/Services/dio_connection.dart';

class PlayAudioController extends GetxController {
  var singerid, musicid;
  PlayAudioController({this.singerid, this.musicid});
  RxList<MusicModel> audiolist = RxList();
  RxBool isplaying = false.obs;
  RxBool loading = false.obs;
  final player = AudioPlayer();
  late var playList;
  RxInt currentmusic = (0).obs;
  var response;
  @override
  void onInit() async {
    super.onInit();

    playList = ConcatenatingAudioSource(children: [], useLazyPreparation: true);
    player.currentIndexStream.listen((index) {
      if (index != null) {
        currentmusic.value = index;
      }
    });
    await playAudio(singerid, musicid);
    await player.setAudioSource(playList,
        initialIndex: 0, initialPosition: Duration.zero);
  }

  playAudio(singerId, musicid) async {
    try {
      // isplaying.value = true;
      loading.value = true;
      audiolist.clear();
      playList.clear();
      debugPrint(
          "Requesting: ${UrlConst.apimusiclistsinger + singerId.toString()}");
      response = await DioServices()
          .getMethod(UrlConst.apimusiclistsinger + singerId.toString());
      if (response.statusCode == 200) {
        var musics = response.data['musics'] as List;
        // debugPrint("My Music Length: ${musics.length}");
// یافتن آیتم موردنظر
        var targetMusic = musics.firstWhere(
          (music) => music['musicId'] == musicid,
          orElse: () => null,
        );
        if (targetMusic != null) {
          musics.remove(targetMusic); // حذف از لیست
          musics.insert(0, targetMusic); // اضافه کردن به اول لیست
        }
        for (int i = 0; i <= musics.length - 1; i++) {
          if (i > musics.length) {
            i = musics[i]['musicId'];
          }
        }

        for (var elements in musics) {
          var musicModel = MusicModel.fromJson(elements);
          audiolist.add(musicModel);
          playList.add(AudioSource.uri(
              Uri.parse(MusicModel.fromJson(elements).musicUrl!)));
        }
        debugPrint("Current Music Index: ${currentmusic.value}");
        loading.value = false;
        return true;
      }
    } catch (e) {
      debugPrint("Error in playAudio: $e");
    }
  }

// برای پروگرس بار
  Rx<Duration> progressValue = Duration(seconds: 0).obs;
  Rx<Duration> bufferedValue = Duration(seconds: 0).obs;
  Timer? timer;
  startProgress() {
    const tick =
        Duration(seconds: 1); //این کد هر یک ثانیه به پروگرس بار اضافه میکند
    int duration = player.duration!.inSeconds; // دریافت زمان پروگرس بار
    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
        timer = null;
        player.stop();
      }
    }

    timer = Timer.periodic(
      tick,
      (timer) {
        duration--;
        progressValue.value =
            player.position; // اختصاص مقدار پروگرس بار به متغیر تعریف شده
        player.bufferedPosition; // اختصاص مقدار پروگرس بار به متغیر تعریف شده
        if (duration <= 0) {
          timer.cancel();
          progressValue.value = Duration(seconds: 0);
          bufferedValue.value = Duration(seconds: 0);
        }
      },
    );
  }
}
