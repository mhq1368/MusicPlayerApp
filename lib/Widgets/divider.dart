import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
    required this.appWidth,
  });

  final double appWidth;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: const Color.fromARGB(99, 226, 226, 226),
      thickness: 1,
      indent: appWidth / 25,
      endIndent: appWidth / 25,
    );
  }
}
