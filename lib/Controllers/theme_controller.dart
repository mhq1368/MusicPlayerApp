import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// تعریف تم‌های روشن و تاریک

//LightTheme
final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFF3C5782),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Color(0xFFf5f5f5)),
        shadowColor: const Color(0xFFFFFFFF),
        backgroundColor: Color(0xFF1A2B47),
        titleTextStyle: TextStyle(
            fontFamily: "Peyda-B",
            fontSize: 14,
            color: const Color(0xFFf5f5f5))),
    textTheme: TextTheme(
      titleSmall: TextStyle(
          color: const Color(0xFFf5f5f5), fontFamily: "Peyda-B", fontSize: 14),
      titleLarge: TextStyle(
          color: const Color(0xFFf5f5f5), fontSize: 17, fontFamily: "Peyda-Bo"),
      labelMedium: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.5),
          fontSize: 15,
          fontFamily: "Peyda-SB"),
      displaySmall: TextStyle(
          color: const Color(0xFFf5f5f5), fontSize: 13, fontFamily: "Peyda-M"),
      displayLarge: TextStyle(
          color: const Color(0xFF000000), fontSize: 13, fontFamily: "Peyda-M"),
      labelSmall: TextStyle(
          color: const Color(0xFFf5f5f5), fontSize: 15, fontFamily: "Peyda-R"),
    ),
    iconTheme: IconThemeData(color: Color(0xFFf5f5f5)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
            padding:
                WidgetStatePropertyAll(EdgeInsets.fromLTRB(35, 15, 35, 15)),
            backgroundColor: WidgetStatePropertyAll(Color(0xFFFF4081)),
            overlayColor: WidgetStatePropertyAll(Colors.amberAccent))),
    drawerTheme: DrawerThemeData(backgroundColor: Color(0xFFFFFFFF)));

//DarkTheme
final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Color.fromARGB(255, 66, 85, 80),
        onPrimary: Color.fromARGB(255, 255, 255, 255),
        secondary: Color(0xFFC1DBD4),
        onSecondary: Color(0xFFC1DBD4),
        error: Color(0xFFC1DBD4),
        onError: Color(0xFFC1DBD4),
        surface: Color(0xFFC1DBD4),
        onSurface: Color(0xFFC1DBD4)),
    drawerTheme: DrawerThemeData(
      backgroundColor: Color.fromARGB(255, 66, 85, 80),
    ),
    textTheme: TextTheme(
        titleSmall: TextStyle(
            color: Colors.amberAccent, fontFamily: "Peyda-B", fontSize: 14)),
    scaffoldBackgroundColor: Color.fromARGB(255, 66, 85, 80),
    appBarTheme: AppBarTheme(
        elevation: 3,
        backgroundColor: Color.fromARGB(255, 66, 85, 80),
        actionsIconTheme: IconThemeData(
          color: Color(0xFFC1DBD4),
        ),
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255),
        )));

// کنترلر مدیریت تم
class ThemeController extends GetxController {
  // تنظیم اولیه روی تم لایت
  final String prefskey = "isDarkMode";
  var themeMode = ThemeMode.light.obs;
  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  // تابع تغییر تم
  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (themeMode.value == ThemeMode.light) {
      themeMode.value = ThemeMode.dark;
      // تغییر تم به صورت مستقیم
      Get.changeTheme(darkTheme);
      Get.changeThemeMode(ThemeMode.dark);
      await prefs.setBool(prefskey, true);
    } else {
      themeMode.value = ThemeMode.light;
      Get.changeTheme(lightTheme);
      Get.changeThemeMode(ThemeMode.light);
      await prefs.setBool(prefskey, false);
    }
  }

  void loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isDarkMode = prefs.getBool(prefskey);

    if (isDarkMode != null && isDarkMode) {
      themeMode.value = ThemeMode.dark;
      // تغییر تم به صورت مستقیم
      Get.changeTheme(darkTheme);
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      themeMode.value = ThemeMode.light;
      Get.changeTheme(lightTheme);
      Get.changeThemeMode(ThemeMode.light);
    }
  }
}
