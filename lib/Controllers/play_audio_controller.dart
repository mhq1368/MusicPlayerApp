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
  var player = AudioPlayer();
  late var playList;
  RxInt currentmusic = (0).obs;
  var response;

  @override
  void onInit() async {
    super.onInit();
    try {
      player.processingStateStream.listen((state) {
        if (state == ProcessingState.completed) {
          player.seek(Duration.zero); // بازگشت به اول آهنگ
          player.play(); // دوباره پخش کن
        }
      });
      playList =
          ConcatenatingAudioSource(children: [], useLazyPreparation: true);
      player.currentIndexStream.listen((index) {
        if (index != null) {
          currentmusic.value = index;
        }
      });
      await playAudio(singerid, musicid);
      await player.setAudioSource(playList,
          initialIndex: 0, initialPosition: Duration.zero);
      waitForDuration();
    } catch (e) {}
  }

  playAudio(singerId, musicid) async {
    // try {
    isplaying.value = true;
    loading.value = true;
    await player.stop();
    await player.seek(Duration.zero);
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

      loading.value = false;
      isplaying.value = false;
      return true;
    }
    // } catch (e) {
    //   debugPrint("Error in playAudio: $e");
    // }
  }

// برای پروگرس بار
  Rx<Duration> progressValue = Duration(seconds: 0).obs;
  Rx<Duration> bufferedValue = Duration(seconds: 0).obs;
  Timer? timer;

  startProgress() {
    try {
      // isplaying.value = true;
      const tickk = Duration(seconds: 1);
      debugPrint("Duration :  ${player.duration}");
      // int duration = player.duration!.inSeconds;
      int duration = player.duration!.inSeconds - player.position.inSeconds;

      if (timer != null) {
        if (timer!.isActive) {
          timer!.cancel();
          timer = null;
        }
      }

      timer = Timer.periodic(tickk, (timer) {
        duration--;
        progressValue.value = player.position;
        bufferedValue.value = player.bufferedPosition;
        if (duration <= 0) {
          timer.cancel();
          progressValue.value = Duration(seconds: 0);
          bufferedValue.value = Duration(seconds: 0);
          isplaying.value = false;
        } else {
          timer.isActive;
          progressValue.value = player.position;
          bufferedValue.value = player.bufferedPosition;
        }
      });
    } catch (e) {}
  }

  Future<void> waitForDuration() async {
    int maxRetries = 10; // حداکثر تعداد تلاش‌ها
    int attempts = 0; // شمارنده تلاش‌ها

    while (player.duration == null && attempts < maxRetries) {
      debugPrint("Waiting for duration... Attempt: $attempts");
      await Future.delayed(
          Duration(milliseconds: 500)); // صبر به مدت 500 میلی‌ثانیه
      attempts++;
    }

    if (player.duration != null) {
      startProgress();
    } else {
      debugPrint("Error: Duration is still null after multiple attempts!");
    }
  }
}
