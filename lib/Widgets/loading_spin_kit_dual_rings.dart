import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

SpinKitWave mainLoadingKitWave(double appHeight) {
  return SpinKitWave(
    color: Color.fromARGB(255, 185, 155, 103), // رنگ دکمه‌هات
    size: appHeight / 14,
    type: SpinKitWaveType.center,
  );
}
