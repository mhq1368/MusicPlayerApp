import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Controllers/theme_controller.dart';
import 'package:music_player_app/Views/all_music_list_views.dart';
import 'package:music_player_app/Views/home_screen_views.dart';
import 'package:music_player_app/Views/musics_list_by_singer_id.dart';
import 'package:music_player_app/Views/play_now_music.dart';
import 'package:music_player_app/Views/sms_verified_code_send_view.dart';
import 'package:music_player_app/Views/sms_verify_code_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor:
          Color(0xFF1A2B47).withAlpha(100), // تغییر رنگ نوار پایین
      systemNavigationBarIconBrightness: Brightness.light, // تنظیم رنگ آیکون‌ها
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Color(0xff1A2B47),
      systemNavigationBarContrastEnforced: true,
      statusBarBrightness: Brightness.dark,
      systemStatusBarContrastEnforced: true));

  Get.put(ThemeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale('fa'),
      theme: lightTheme,
      getPages: [
        GetPage(name: AppRoutes.homePage, page: () => HomePage()),
        GetPage(
            name: AppRoutes.allMusicsListPage, page: () => AllMusicsListPage()),
        GetPage(
            name: AppRoutes.musicsListPageBySinger,
            page: () => MusicsListBySingerId()),
        GetPage(name: AppRoutes.playNow, page: () => PlayNowMusic()),
        GetPage(name: AppRoutes.smsVerify, page: () => SmsVerifyPage()),
        GetPage(
            name: AppRoutes.smsVerified, page: () => SmsVerifiedCodeSendView()),
      ],
      home: HomePage(),
    );
  }
}

class AppRoutes {
  static const homePage = '/HomePage';
  static const allMusicsListPage = '/AllMusicList';
  static const musicsListPageBySinger = '/MusicBySinger';
  static const playNow = '/PlayNowMusic';
  static const smsVerify = '/SMSVerify';
  static const smsVerified = '/SMSVerified';
}
