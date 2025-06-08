class SingersModel {
  int? singerid;
  String? singername;
  String? singerpicurl;
  int? musiccount;

  SingersModel(
      {this.singerid, this.singername, this.singerpicurl, this.musiccount});

  SingersModel.fromJson(Map<String, dynamic> items) {
    singerid = items['singerid'];
    singername = items['singername'];
    singerpicurl = items['singerpicurl'];
    musiccount = items['musicCount'];
  }
}
