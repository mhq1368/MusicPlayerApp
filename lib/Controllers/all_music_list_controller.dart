import 'package:get/get.dart';
import 'package:music_player_app/Constant/url_const.dart';
import 'package:music_player_app/Models/musics_model.dart';
import 'package:music_player_app/Services/dio_connection.dart';

class AllMusicListController extends GetxController {
  RxBool isloading = false.obs;
  RxList<MusicModel> allmusiclist = RxList();
  RxList<MusicModel> lasttenmusiclist = RxList();
  @override
  void onInit() {
    super.onInit();
    getAllMusicsList();
    getLastTenMusic();
  }

  getAllMusicsList() async {
    isloading.value = true;
    var response = await DioServices().getMethod(UrlConst.apiallmusics);

    if (response.statusCode == 200) {
      var musics = response.data['musics'];
      allmusiclist.value = (musics as List)
          .map((e) => MusicModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    isloading.value = false;
  }

  getLastTenMusic() async {
    isloading.value = true;
    var response = await DioServices().getMethod(UrlConst.apilasttenmusic);

    if (response.statusCode == 200) {
      var musics = response.data['lastTenMusics'];
      lasttenmusiclist.value = (musics as List)
          .map((e) => MusicModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    isloading.value = false;
  }
}
