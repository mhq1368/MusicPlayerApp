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
        height: size.height / 6,
        width: size.width / 1.2,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0x00ffffff),
                Color(0x00ffffff),
                Color(0xddf5f5f5)
              ], // لیست رنگ‌ها
              begin: Alignment.topCenter, // نقطه‌ی شروع گرادینت
              end: Alignment.bottomCenter, // نقطه‌ی پایان گرادینت
            ),
            borderRadius: BorderRadius.circular(0),
            color: Color(0xffffffff)),
      ),
    );
  }
}
