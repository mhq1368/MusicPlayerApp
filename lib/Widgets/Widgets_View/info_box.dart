import 'package:flutter/material.dart';
import 'package:music_player_app/Constant/helper_size.dart';
import 'package:music_player_app/Constant/strings_const.dart';

class myInfoBox extends StatelessWidget {
  const myInfoBox({
    super.key,
    required this.responsive,
  });

  final ResponsiveHelper responsive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: responsive.scaledPadding(30),
      child: Container(
        padding: responsive.scaledPaddingLTRB(30, 10, 10, 10),
        decoration: BoxDecoration(
            border:
                BoxBorder.symmetric(vertical: BorderSide(color: Colors.white)),
            gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 1, 53, 90),
              const Color.fromARGB(255, 1, 68, 115),
            ]),
            color: const Color.fromARGB(255, 5, 72, 120),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: responsive.screenHeight / 100,
          children: [
            Icon(Icons.info_outline,
                color: Colors.white, size: responsive.scaledFontSize(20)),
            Expanded(
              child: Text(
                  softWrap: true,
                  strutStyle: StrutStyle(
                    leading: responsive.scaledFontSize(0.7),
                  ),
                  textAlign: TextAlign.justify,
                  '${StringsConst.txtInfoVeryfyCode}\n\n${StringsConst.txtconnectiondc}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontSize: responsive.scaledFontSize(13),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
