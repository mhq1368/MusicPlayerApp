import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Controllers/theme_controller.dart';
import 'package:music_player_app/Views/home_screen_views.dart';

void main() {
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
