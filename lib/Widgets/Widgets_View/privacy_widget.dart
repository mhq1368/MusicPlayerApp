import 'package:flutter/material.dart';
import 'package:music_player_app/Constant/helper_size.dart';
import 'package:music_player_app/Constant/strings_const.dart';
import 'package:music_player_app/Widgets/divider.dart';

class PrivacyUsers extends StatelessWidget {
  const PrivacyUsers({
    super.key,
    required this.responsive,
  });

  final ResponsiveHelper responsive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: responsive.screenHeight / 1.5,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(StringsConst.txtInfoVeryfyCodeTitr),
              _buildSpacer(),
              _buildText(
                  "${StringsConst.txtInfoVeryfyCode}\n${StringsConst.txtconnectiondc}"),
              MyDivider(appWidth: responsive.screenWidth * 1.1),
              _buildTitle(StringsConst.conditionTitr1),
              _buildSpacer(),
              _buildText(StringsConst.conditionText1),
              _buildTitle(StringsConst.conditionTitr2),
              _buildSpacer(),
              _buildText(StringsConst.conditionText2),
              _buildTitle(StringsConst.conditionTitr3),
              _buildSpacer(),
              _buildText(StringsConst.conditionText3),
              _buildTitle(StringsConst.conditionTitr4),
              _buildSpacer(),
              _buildText(StringsConst.conditionText4),
              _buildTitle(StringsConst.conditionTitr5),
              _buildSpacer(),
              _buildText(StringsConst.conditionText5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.amberAccent,
        fontFamily: 'Peyda-M',
        wordSpacing: 1.2,
      ),
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontFamily: 'Peyda-M',
        wordSpacing: 1,
        height: 1.7, // برای خوانایی بهتر
      ),
    );
  }

  Widget _buildSpacer() {
    return SizedBox(height: responsive.screenHeight / 55);
  }
}

// به دلیل عدم توانایی در استفاده از جاستیفای در روش زیر از کد فوق استفاده گردید.

// class PrivacyUsers extends StatelessWidget {
//   const PrivacyUsers({
//     super.key,
//     required this.responsive,
//   });پ

//   final ResponsiveHelper responsive;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: responsive.screenHeight / 1.5,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: RichText(
//           text: TextSpan(
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontFamily: 'Peyda-M',
//               ),
//               children: [
//                 TextSpan(
//                   text: "\n${StringsConst.txtInfoVeryfyCodeTitr}\n",
//                   style: TextStyle(
//                       wordSpacing: 3,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.amberAccent),
//                 ),
//                 WidgetSpan(
//                     child: SizedBox(
//                   height: responsive.screenHeight / 25,
//                 )),
//                 TextSpan(
//                   text:
//                       "${StringsConst.txtInfoVeryfyCode}\n${StringsConst.txtconnectiondc}\n\n",
//                   style: TextStyle(
//                       wordSpacing: 3,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white),
//                 ),
//                 WidgetSpan(
//                     child: MyDivider(appWidth: responsive.screenWidth * 1.1)),
//                 TextSpan(
//                   text: "\n\n${StringsConst.conditionTitr1}\n",
//                   style: TextStyle(
//                       wordSpacing: 3,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.amberAccent),
//                 ),
//                 WidgetSpan(
//                     child: SizedBox(
//                   height: responsive.screenHeight / 25,
//                 )),
//                 TextSpan(
//                   text: "${StringsConst.conditionText1}\n",
//                   style: TextStyle(
//                       wordSpacing: 3,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white),
//                 ),
//                 TextSpan(
//                   text: "${StringsConst.conditionTitr2}\n",
//                   style: TextStyle(
//                       wordSpacing: 3,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.amberAccent),
//                 ),
//                 WidgetSpan(
//                     child: SizedBox(
//                   height: responsive.screenHeight / 25,
//                 )),
//                 TextSpan(
//                   text: "${StringsConst.conditionText2}\n",
//                   style: TextStyle(
//                       wordSpacing: 3,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white),
//                 ),
//                 TextSpan(
//                   text: "${StringsConst.conditionTitr3}\n",
//                   style: TextStyle(
//                       wordSpacing: 3,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.amberAccent),
//                 ),
//                 WidgetSpan(
//                     child: SizedBox(
//                   height: responsive.screenHeight / 25,
//                 )),
//                 TextSpan(
//                   text: "${StringsConst.conditionText3}\n",
//                   style: TextStyle(
//                       wordSpacing: 3,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white),
//                 ),
//                 TextSpan(
//                   text: "${StringsConst.conditionTitr4}\n",
//                   style: TextStyle(
//                       wordSpacing: 3,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.amberAccent),
//                 ),
//                 WidgetSpan(
//                     child: SizedBox(
//                   height: responsive.screenHeight / 25,
//                 )),
//                 TextSpan(
//                   text: "${StringsConst.conditionText4}\n",
//                   style: TextStyle(
//                       wordSpacing: 3,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white),
//                 ),
//                 TextSpan(
//                   text: "${StringsConst.conditionTitr5}\n",
//                   style: TextStyle(
//                       wordSpacing: 3,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.amberAccent),
//                 ),
//                 WidgetSpan(
//                     child: SizedBox(
//                   height: responsive.screenHeight / 25,
//                 )),
//                 TextSpan(
//                   text: "${StringsConst.conditionText5}\n",
//                   style: TextStyle(
//                       wordSpacing: 3,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white),
//                 ),
//               ]),
//         ),
//       ),
//     );
//   }
// }
