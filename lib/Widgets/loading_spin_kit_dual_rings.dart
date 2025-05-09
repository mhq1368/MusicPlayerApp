import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

SpinKitWave mainLoading(double appHeight) {
  return SpinKitWave(
    color: Colors.white,
    size: appHeight / 14,
    type: SpinKitWaveType.center,
  );
}
