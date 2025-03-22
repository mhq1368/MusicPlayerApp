import 'dart:ui';

import 'package:flutter_spinkit/flutter_spinkit.dart';

SpinKitFadingFour mainLoading(double appHeight) {
  return SpinKitFadingFour(
    color: const Color.fromARGB(255, 255, 255, 255),
    size: appHeight / 15,
  );
}
