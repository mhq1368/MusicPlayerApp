import 'package:flutter/material.dart';

Widget myBottomAppBar(BuildContext context, Widget text) {
  return Container(
    height: 45,
    width: 100,
    decoration: BoxDecoration(
      color: Color(0xff39ff14),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Color(0x8039ff20), // قاب صورتی نیمه‌شفاف
        width: 1.5,
      ),
    ),
    child: Center(
      child: text, // متن یا ویجت دلخواه شما
    ),
  );
}
