import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/Constant/url_const.dart';
import 'package:music_player_app/Models/musics_model.dart';
import 'package:music_player_app/Services/dio_connection.dart';

class PlayAudioController extends GetxController {
  // ignore: prefer_typing_uninitialized_variables
  late var singerid, musicid;
  PlayAudioController({this.singerid, this.musicid});
  RxList<MusicModel> audiolist = RxList();
  RxBool isplaying = false.obs;
  RxBool loading = false.obs;
  var player = AudioPlayer();
  // ignore: prefer_typing_uninitialized_variables
  late var playList;
  // ignore: prefer_typing_uninitialized_variables
  var response;
  RxInt currentmusic = (0).obs;

  @override
  void onClose() {
    player.dispose(); // پاکسازی منابع پلیر
    timer?.cancel(); // لغو تایمر پروگرس بار
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    try {
      // گوش دادن به وضعیت پخش
      player.playingStream.listen((isPlaying) {
        isplaying.value = isPlaying;
      });
      player.processingStateStream.listen((state) {
        if (state == ProcessingState.completed) {
          player.seek(Duration.zero);
          player.play();
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
      player.durationStream.listen(
        (event) {
          if (event != null) {
            startProgress();
          }
        },
      );
      player.currentIndexStream.listen((idx) {
        currentmusic.value = idx ?? 0;
      });

      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> playAudio(singerId, musicid) async {
    Future.delayed(Duration(seconds: 3));
    isplaying.value = false;
    loading.value = true;
    await player.stop();
    audiolist.clear();
    playList.clear();
    // دیتا رو بگیر
    response = await DioServices()
        .getMethod(UrlConst.apimusiclistsinger + singerId.toString());
    if (response.statusCode == 200) {
      var musics = response.data['musics'] as List;
      var targetMusic = musics.firstWhere(
        (music) => music['musicId'] == musicid,
        orElse: () => null,
      );
      if (targetMusic != null) {
        musics.remove(targetMusic);
        musics.insert(0, targetMusic);
      }

      final musicModels = musics.map((e) => MusicModel.fromJson(e)).toList();
      final audioSources = musicModels
          .map((music) => AudioSource.uri(Uri.parse(music.musicUrl!)))
          .toList();

      audiolist.assignAll(musicModels);
      playList.addAll(audioSources);

      loading.value = false;
      return;
    }
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
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> waitForDuration() async {
    const maxRetries = 15;
    for (int attempts = 0; attempts < maxRetries; attempts++) {
      if (player.duration != null) {
        startProgress();
        return;
      }
      debugPrint("Waiting for duration... Attempt: $attempts");
      await Future.delayed(Duration(milliseconds: 500));
    }
    debugPrint("Error: Duration is still null after $maxRetries attempts!");
  }

  Future<void> playAnotherMusic(int singerId, int musicId) async {
    Future.delayed(Duration(seconds: 3));
    loading.value = true;

    await player.stop();
    audiolist.clear();
    playList.clear();

    response = await DioServices()
        .getMethod(UrlConst.apimusiclistsinger + singerId.toString());

    if (response.statusCode == 200) {
      var musics = response.data['musics'] as List;
      var targetMusic = musics.firstWhere(
        (music) => music['musicId'] == musicId,
        orElse: () => null,
      );

      if (targetMusic != null) {
        musics.remove(targetMusic);
        musics.insert(0, targetMusic);
      }

      final musicModels = musics.map((e) => MusicModel.fromJson(e)).toList();
      final audioSources = musicModels
          .map((music) => AudioSource.uri(Uri.parse(music.musicUrl!)))
          .toList();

      audiolist.assignAll(musicModels);
      playList = ConcatenatingAudioSource(children: audioSources);

      // پلیر حتماً باید مجدداً مقداردهی شود
      await player.setAudioSource(playList,
          initialIndex: 0, initialPosition: Duration.zero);

      currentmusic.value = 0;
      startProgress();
    }

    loading.value = false;
  }
}
