class SearchModel {
  String? type;
  int? singerId;
  int? musicId;
  String? name;
  String? picUrl;
  String? cover;
  String? url;

  SearchModel({
    this.type,
    this.singerId,
    this.musicId,
    this.name,
    this.picUrl,
    this.cover,
    this.url,
  });

  SearchModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    singerId = json['singerId'];
    musicId = json['musicId'];
    name = json['name'];
    picUrl = json['pic'];
    cover = json['cover'];
    url = json['url'];
  }
}
// "type": "Music",
//     "singerId": 2,
//     "musicId": 13,
//     "name": "خاصیت عشق",
//     "pic": null,
//     "cover": "https://www.dlfile.qassabi.ir/api/MusicPlayerApp/singerimg/Mahdi_Rasouli1.jpg",
//     "url": "https://www.dlfile.qassabi.ir/api/MusicPlayerApp/musics/MehdiRasouli/MehdiRasouli-%D8%AE%D8%A7%D8%B5%DB%8C%D8%AA%20%D8%B9%D8%B4%D9%82.mp3"
