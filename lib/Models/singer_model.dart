class SingersModel {
  int? singerid;
  String? singername;
  String? singerpicurl;

  SingersModel({this.singerid, this.singername, this.singerpicurl});

  SingersModel.fromJson(Map<String, dynamic> items) {
    singerid = items['singerid'];
    singername = items['singername'];
    singerpicurl = items['singerpicurl'];
  }
}
