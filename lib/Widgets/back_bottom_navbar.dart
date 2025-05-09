import 'package:flutter/material.dart';

class BackbottomNavbar extends StatelessWidget {
  const BackbottomNavbar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: size.height / 9,
        width: size.width / 1.2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0x00ffffff), // کاملاً شفاف در بالا
              Color(0x30ffffff), // کاملاً شفاف در بالا
              Color(0x99ffffff), // تقریباً سفید پایین
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    );
  }
}
