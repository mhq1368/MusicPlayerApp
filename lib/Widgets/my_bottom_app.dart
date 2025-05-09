import 'package:flutter/material.dart';

Widget myBottomAppBar(BuildContext context, Widget text) {
  return Container(
    height: 45,
    width: 100,
    decoration: BoxDecoration(
      color: Color(0xffFF4081), // زمینه شیشه‌ای
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Color(0x80FF4081), // قاب صورتی نیمه‌شفاف
        width: 1.5,
      ),
    ),
    child: Center(
      child: text, // متن یا ویجت دلخواه شما
    ),
  );
}
