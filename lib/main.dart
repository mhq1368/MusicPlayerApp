import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:music_player_app/Controllers/theme_controller.dart';
import 'package:music_player_app/Views/all_music_list_views.dart';
import 'package:music_player_app/Views/home_screen_views.dart';
import 'package:music_player_app/Views/musics_list_by_singer_id.dart';
import 'package:music_player_app/Views/play_now_music.dart';
import 'package:music_player_app/Views/singers_list_views.dart';
import 'package:music_player_app/Views/sms_verified_code_send_view.dart';
import 'package:music_player_app/Views/sms_verify_code_view.dart';

void main() async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: const Color(0xFF1A2B47).withAlpha(100),
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: const Color(0xff1A2B47),
    systemNavigationBarContrastEnforced: true,
    statusBarBrightness: Brightness.dark,
    systemStatusBarContrastEnforced: true,
  ));

  Get.put(ThemeController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('fa'),
      theme: lightTheme,
      getPages: [
        GetPage(name: AppRoutes.homePage, page: () => HomePage()),
        GetPage(
            name: AppRoutes.allMusicsListPage, page: () => AllMusicsListPage()),
        GetPage(
            name: AppRoutes.musicsListPageBySinger,
            page: () => MusicsListBySingerId()),
        GetPage(name: AppRoutes.playNow, page: () => const PlayNowMusic()),
        GetPage(name: AppRoutes.smsVerify, page: () => SmsVerifyPage()),
        GetPage(
            name: AppRoutes.smsVerified, page: () => SmsVerifiedCodeSendView()),
        GetPage(name: AppRoutes.singersListPage, page: () => SingersListPage()),
      ],
      initialRoute: AppRoutes.homePage,
    );
  }
}

class AppRoutes {
  AppRoutes._();
  static const homePage = '/HomePage';
  static const allMusicsListPage = '/AllMusicList';
  static const musicsListPageBySinger = '/MusicBySinger';
  static const playNow = '/PlayNowMusic';
  static const smsVerify = '/SMSVerify';
  static const smsVerified = '/SMSVerified';
  static const singersListPage = '/SingersListPage';
}
