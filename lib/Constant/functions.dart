import 'package:flutter/material.dart';

//گردی گوشه های کادرها براساس عرض دیوایس
double deviceBasedRadius(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < 390) return 16;
  if (width < 450) return 24;
  return 32;
}
