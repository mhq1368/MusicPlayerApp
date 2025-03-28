import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Controllers/theme_controller.dart';
import 'package:music_player_app/Views/home_screen_views.dart';

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
        darkTheme: darkTheme,
        home: HomePage());
  }
}
