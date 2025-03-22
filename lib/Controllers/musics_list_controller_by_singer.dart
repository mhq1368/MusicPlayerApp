import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Constant/url_const.dart';
import 'package:music_player_app/Models/musics_model.dart';
import 'package:music_player_app/Services/dio_connection.dart';

class MusicsListControllerBySinger extends GetxController {
  // ignore: prefer_typing_uninitialized_variables
  var singerid;
  RxInt countmusics = 0.obs;
  MusicsListControllerBySinger({this.singerid});

  RxList<MusicModel> musiclistbysinger = RxList();

  RxBool isloading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getmusiclistbysinger();
  }

  getmusiclistbysinger() async {
    musiclistbysinger.clear(); // پاک کردن لیست قبلی
    isloading.value = true;
    var response1 = await DioServices()
        .getMethod(UrlConst.apimusiclistsinger + singerid.toString());
    if (response1.statusCode == 200) {
      debugPrint("Music List By Singer: ${response1.data['musics']}");
      for (var items in response1.data['musics']) {
        musiclistbysinger.add(MusicModel.fromJson(items));
      }
      countmusics.value = musiclistbysinger.length;
    }
    isloading.value = false;
  }
}
