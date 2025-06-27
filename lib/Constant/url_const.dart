class UrlConst {
  // static String baseapi = "http://192.168.0.105:5133/api/";
  // static const String apiurl = 'http://10.0.2.2:5129/api/Podcast'; //لوکال هاست و نمایش روی وب
  static String baseapi = "https://musicplayer.apxify.ir/";

  // static String baseapi = "http://192.168.188.100:5133/";
  // static String baseapi = "http://192.168.144.201:5133/";

  static String baseapiweb = "api/";
  static String baseapimusicAndbaseapi = baseapi + baseapiweb;

  static String apiurl = '${baseapimusicAndbaseapi}Singers';

  static String apilasttenmusic =
      "${baseapimusicAndbaseapi}Musics/GetLastTenRecords";
  static String apimusiclistsinger = "${baseapimusicAndbaseapi}Musics/";
  static String sendCodeToUser = "${baseapimusicAndbaseapi}SmsVerify/send";
  static String verifideSendedCode =
      "${baseapimusicAndbaseapi}SmsVerify/verify";
  static String apiallmusics = "${baseapimusicAndbaseapi}Musics/GetAllMusics";
  static String apimusicofsinger =
      "${baseapimusicAndbaseapi}Singers/CountMusicsOfSinger/";
  static String apimusicListByID =
      "${baseapimusicAndbaseapi}Musics/GetMusicListByID/";
  static String apiGetUserInfoByPhoneAndUserid =
      "${baseapimusicAndbaseapi}SmsVerify/getuser/";
  static String apiuserinfoshow =
      "${baseapimusicAndbaseapi}InformationUsers/GetUserInfoByToken/";
  static String apiuserinfoedit =
      "${baseapimusicAndbaseapi}InformationUsers/update-info";

  static String apisearch = "${baseapimusicAndbaseapi}SearchControllers?query=";

  static const dlhost = 'https://www.dlfile.qassabi.ir';
}
