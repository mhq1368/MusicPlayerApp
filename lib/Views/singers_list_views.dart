import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Widgets/back_bottom_navbar.dart';
import 'package:music_player_app/Widgets/bottom_navbar.dart';
import 'package:music_player_app/main.dart';

import '../gen/assets.gen.dart';

class SingersListPage extends StatelessWidget {
  SingersListPage({super.key});
  final List<Map<String, String>> singers = [
    {
      'name': 'آریانا گرانده',
      'image':
          'https://www.dlfile.qassabi.ir/api/MusicPlayerApp/singerimg/Mahdi_Rasouli1.jpg',
    },
    {
      'name': 'اد شیرن',
      'image':
          'https://www.dlfile.qassabi.ir/api/MusicPlayerApp/singerimg/Mahdi_Rasouli1.jpg',
    },
    {
      'name': 'دوآ لیپا',
      'image':
          'https://www.dlfile.qassabi.ir/api/MusicPlayerApp/singerimg/Mahdi_Rasouli1.jpg',
    },
    {
      'name': 'د ویکند',
      'image':
          'https://www.dlfile.qassabi.ir/api/MusicPlayerApp/singerimg/Mahdi_Rasouli1.jpg',
    },
    {
      'name': 'بیلی آیلیش',
      'image':
          'https://www.dlfile.qassabi.ir/api/MusicPlayerApp/singerimg/Mahdi_Rasouli1.jpg',
    },
    {
      'name': 'دریک',
      'image':
          'https://www.dlfile.qassabi.ir/api/MusicPlayerApp/singerimg/Mahdi_Rasouli1.jpg',
    },
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "لیست خوانندگان",
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
                InkWell(
                    onTap: () {
                      Get.offAllNamed(
                          AppRoutes.homePage); // به صفحه اصلی برمی‌گردد
                    },
                    child: SvgPicture.asset(
                      Assets.icons.arrowSmallLeft,
                      // ignore: deprecated_member_use
                      color: Colors.white,
                      height: 32,
                    )),
              ],
            ),
          )),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 70), // 👈 این خط مهمه
            shrinkWrap: true,
            itemCount: singers.length,
            itemBuilder: (context, index) {
              final singer = singers[index];
              return Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF273A5D),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white24,
                            width: 1.2,
                          ),
                          gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(90, 105, 135, 183),
                                Color(0xaa40577D),
                                Color(0xff1A2B47),
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(CupertinoIcons.music_note,
                                  color: Colors.white, size: 22),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${singer['name']}"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("تعداد نواها : 25"),
                                ],
                              ),
                              Expanded(child: SizedBox()),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.network(
                                  singer['image']!,
                                  height: 65,
                                  width: 65,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              );
            },
          ),
        ),
        BackbottomNavbar(size: size),
        BottomNavbar(size: size),
      ]),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:music_player_app/Widgets/back_bottom_navbar.dart';
// import 'package:music_player_app/Widgets/bottom_navbar.dart';

// class SingersListPage extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: const Text(
//           'لیست خوانندگان',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Stack(children: [
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: SizedBox(
//             width: double.infinity,
//             height: size.height,
//             child:
//           ),
//         ),
//         BackbottomNavbar(size: size),
//         BottomNavbar(size: size),
//       ]),
//     );
//   }
// }
