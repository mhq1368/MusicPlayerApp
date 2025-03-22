import 'package:flutter/material.dart';

Drawer drawerApp(Size appsize, BuildContext context) {
  return Drawer(
    backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
    elevation: 3,
    shadowColor: Colors.black87,
    child: ListView(
      padding: EdgeInsets.only(top: appsize.height / 13),
      children: [],
    ),
  );
}
