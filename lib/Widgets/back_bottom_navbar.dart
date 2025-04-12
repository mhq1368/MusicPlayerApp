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
              Colors.white.withValues(alpha: 0), // کاملاً شفاف در بالا
              Colors.white.withValues(alpha: 30), // نیمه‌شفاف وسط
              Colors.white.withValues(alpha: 100), // تقریباً سفید پایین
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
