import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Constant/url_const.dart';
import 'package:music_player_app/Models/musics_model.dart';
import 'package:music_player_app/Services/dio_connection.dart';

class MusicByIdControllerPlayNow extends GetxController {
  // ignore: prefer_typing_uninitialized_variables
  var musicId;
  MusicByIdControllerPlayNow({this.musicId});
  RxList<MusicModel> musiclistid = RxList();
  RxBool isloading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getmusiclistid();
  }

  getmusiclistid() async {
    musiclistid.clear(); // پاک کردن لیست قبلی

    isloading.value = true;
    var response1 = await DioServices()
        .getMethod(UrlConst.apimusiclistsinger + musicId.toString());
    if (response1.statusCode == 200) {
      debugPrint("Music List By ID: ${response1.data['musics']}");
      for (var items in response1.data['musics']) {
        musiclistid.add(MusicModel.fromJson(items));
      }
    }
    isloading.value = false;
  }
}
