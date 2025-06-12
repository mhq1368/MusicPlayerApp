import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player_app/Constant/url_const.dart';
import 'package:music_player_app/Models/singer_model.dart';
import 'package:music_player_app/Services/dio_connection.dart';

class SingersController extends GetxController {
  RxBool isloading = false.obs;
  RxList<SingersModel> singerlist = RxList();
  int singerid = 0;
  RxInt countmusics = 0.obs;
  @override
  void onInit() {
    super.onInit();

    showsingerslist();
  }

  final token = GetStorage().read('token');
  showsingerslist() async {
    try {
      singerlist.clear();
      isloading.value = true;
      Future.delayed(const Duration(seconds: 3));
      var response =
          await DioServices().getMethod(UrlConst.apiurl, token: token);
      if (response.data != null) {
        var singers = response.data['singers'];
        if (response.statusCode == 200) {
          singerlist.value = (singers as List)
              .map((e) => SingersModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        debugPrint(singers.toString());
        isloading.value = false;
      } else {}
    } catch (e) {
      return;
    }
  }
}
