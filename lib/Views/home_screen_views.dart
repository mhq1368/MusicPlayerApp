import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Views/all_music_list_views.dart';
import 'package:music_player_app/Widgets/Widgets_View/singers_list.dart';
import 'package:music_player_app/Widgets/back_bottom_navbar.dart';
import 'package:music_player_app/Widgets/bottom_navbar.dart';
import 'package:music_player_app/Widgets/drawer_widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final GlobalKey<ScaffoldState> drawer = GlobalKey();
  final TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: drawer,
      drawer: drawerApp(size, context),
      appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      drawer.currentState!.openDrawer();
                    },
                    icon: Icon(Icons.menu)),
                Text(
                  "آوادیس",
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
                IconButton(
                    onPressed: () {
                      // Get.off(() => SmsVerifyPage());
                    },
                    icon: Icon(CupertinoIcons.profile_circled)),
              ],
            ),
          )),
      body: Stack(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                width: size.width / 1,
                // height: size.height / 4,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: _search,
                  autocorrect: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "خواننده ، نوا ، آلبوم",
                      hintStyle: Theme.of(context).textTheme.labelMedium),
                  cursorColor: Colors.black,
                ),
              ),
            ),
            Center(
                child: ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: () {},
                    child: Text(
                      "جستجو",
                      style: Theme.of(context).textTheme.displaySmall,
                    ))),
            //خوانندگان برتر
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "خوانندگان برتر",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAll(() => AllMusicsListPage());
                    },
                    child: Text(
                      "نمایش همه",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ),
            SingersListHomePage(),
          ],
        ),
        BackbottomNavbar(size: size),
        BottomNavbar(size: size),
      ]),
    );
  }
}
