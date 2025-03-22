import 'package:music_player_app/Models/singer_model.dart';

class MusicModel {
  int? musicId;
  int? singerId;
  String? musicName;
  String? musicCover;
  String? musictime;
  String? musicUrl;
  SingersModel? singer;

  MusicModel({
    this.musicId,
    this.musicCover,
    this.musicName,
    this.musicUrl,
    this.musictime,
    this.singerId,
    this.singer,
  });

  MusicModel.fromJson(Map<String, dynamic> items) {
    musicId = items['musicId'];
    singerId = items['singerid'];
    musicName = items['musicName'];
    musicCover = items['musiccover'];
    musicUrl = items['musicurl'];
    musictime = items['musicTime'];
    if (items.containsKey('singer') && items['singer'] != null) {
      singer = SingersModel.fromJson(items['singer']);
    }
  }
}
