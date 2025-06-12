import 'package:flutter/material.dart';
import 'package:music_player_app/Constant/functions.dart';
import 'package:music_player_app/Constant/helper_size.dart';
import 'package:music_player_app/Widgets/loading_spin_kit_dual_rings.dart';
import 'package:music_player_app/gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    testApiConnection();
    setMySystemUIStyle();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: responsive.screenHeight / 4,
            ),
            Image.asset(
              Assets.icons.logo.path,
              alignment: Alignment.center,
              height: responsive.screenHeight / 2.5,
            ),
            SizedBox(
              height: responsive.screenHeight / 35,
            ),
            mainLoadingKitWave(responsive.screenHeight / 2),
          ],
        ),
      ),
    );
  }
}
