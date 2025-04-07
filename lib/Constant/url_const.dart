class UrlConst {
  static String baseapi = "http://192.168.188.100:5133/api/";
  // static String baseapi = "http://apimusicplayer.mahfannavar.ir/api/";
  // static const String apiurl = 'http://10.0.2.2:5129/api/Podcast'; //لوکال هاست و نمایش روی وب
  static String apiurl =
      '${baseapi}Singers'; //لوکال هاست و نمایش در دیوایس واقعی

  static String apilasttenmusic = "${baseapi}Musics/GetLastTenRecords";
  static String apimusiclistsinger = "${baseapi}Musics/";
  static String sendCodeToUser = "${baseapi}SmsVerify/send";
  static String verifideSendedCode = "${baseapi}SmsVerify/verify";
  static String apiallmusics = "${baseapi}Musics/GetAllMusics";
  static String apimusicofsinger = "${baseapi}Singers/CountMusicsOfSinger/";
  static String apimusicListByID = "${baseapi}Musics/GetMusicListByID/";
  static const bapi = 'http://192.168.0.105:5133/api/';

  static const dlhost = 'https://www.dlfile.qassabi.ir';
}
