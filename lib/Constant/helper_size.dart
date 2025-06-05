import 'package:flutter/material.dart';

class ResponsiveHelper {
  static const double _baseWidth = 393; // آیفون 12 / پوکو X3
  static const double _baseHeight = 851; // آیفون 12 / پوکو X3

  final BuildContext context;

  late final double _screenWidth;
  late final double _screenHeight;
  late final double _scaleWidthFactor;
  late final double _scaleHeightFactor;

  ResponsiveHelper(this.context) {
    final size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;

    _scaleWidthFactor = _screenWidth / _baseWidth;
    _scaleHeightFactor = _screenHeight / _baseHeight;
  }

  // عرض و ارتفاع صفحه
  double get screenWidth => _screenWidth;
  double get screenHeight => _screenHeight;

  // مقیاس عرض و ارتفاع
  double get scaleWidth => _scaleWidthFactor;
  double get scaleHeight => _scaleHeightFactor;

  // مقیاس کلی (میانگین عرض و ارتفاع → مناسب فونت)
  double get scale => (_scaleWidthFactor + _scaleHeightFactor) / 2;

  // فونت تطبیقی (پیشنهاد → استفاده از scale)
  double scaledFontSize(double baseFontSize) => baseFontSize * scale;

  // Radius تطبیقی (پیشنهاد → استفاده از scale)
  double scaledRadius(double baseRadius) => baseRadius * scale;

  // سایز ویجت‌ها (پیشنهاد → استفاده از scaleWidth و scaleHeight)
  Size scaledBoxSize(double baseWidth, double baseHeight) =>
      Size(baseWidth * scaleWidth, baseHeight * scaleHeight);

  // Padding تطبیقی (پیشنهاد → استفاده از scale)
  EdgeInsets scaledPadding(double basePadding) =>
      EdgeInsets.all(basePadding * scale);

  // Padding اختصاصی
  EdgeInsets scaledPaddingLTRB(
          double left, double top, double right, double bottom) =>
      EdgeInsets.fromLTRB(
        left * scaleWidth,
        top * scaleHeight,
        right * scaleWidth,
        bottom * scaleHeight,
      );
}
