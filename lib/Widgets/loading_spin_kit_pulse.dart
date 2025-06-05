import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

SpinKitPulse mainLoadingPulse(double appHeight) {
  return SpinKitPulse(
    color: const Color.fromARGB(255, 255, 255, 255), // رنگ دکمه‌هات
    size: appHeight / 12,
  );
}
