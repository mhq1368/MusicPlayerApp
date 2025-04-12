import 'package:flutter/material.dart';
import 'package:music_player_app/Widgets/divider.dart';
import 'package:music_player_app/gen/assets.gen.dart';

class UserProfileViewPage extends StatefulWidget {
  const UserProfileViewPage({super.key});

  @override
  State<UserProfileViewPage> createState() => _UserProfileViewPageState();
}

class _UserProfileViewPageState extends State<UserProfileViewPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Image.asset(Assets.svg.userProfilePic1.path,
                alignment: Alignment.center,
                fit: BoxFit.fill,
                height: 95,
                width: 95),
            SizedBox(
              height: size.height / 25,
            ),
            Text("کاربر گرامی  خوش آمدید",
                style: Theme.of(context).textTheme.titleMedium),
            MyDivider(appWidth: size.width),
          ],
        ),
      ),
    );
  }
}
