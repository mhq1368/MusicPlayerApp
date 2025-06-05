import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player_app/Constant/functions.dart';
import 'package:music_player_app/Constant/helper_size.dart';
import 'package:music_player_app/Controllers/user_info_controller.dart';
import 'package:music_player_app/Widgets/divider.dart';
import 'package:music_player_app/gen/assets.gen.dart';
import 'package:music_player_app/main.dart';

class UserProfileViewPage extends StatefulWidget {
  const UserProfileViewPage({super.key});

  @override
  State<UserProfileViewPage> createState() => _UserProfileViewPageState();
}

final UserInfoController uic = Get.put(UserInfoController());

final TextEditingController nameUser = TextEditingController();

class _UserProfileViewPageState extends State<UserProfileViewPage> {
  RxBool isEditing = false.obs;

  @override
  void initState() {
    super.initState();
    uic.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    var size = MediaQuery.of(context).size;
    final responsive = ResponsiveHelper(context);
    final token = GetStorage().read('token');
    if (token != null && token.isNotEmpty) {
      // بررسی انقضای توکن JWT و خروج در صورت انقضا
      checkJwtExpirationAndLogout(token);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          elevation: 0,
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "پروفایل کاربری",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: responsive.screenHeight / 40,
            ),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOutCubicEmphasized,
              height: isKeyboardOpen
                  ? responsive.screenHeight / 10 // وقتی کیبورد بازه کوچیک‌تر
                  : responsive.screenHeight / 6, // حالت عادی بزرگ‌تر
              child: Image.asset(
                Assets.svg.userProfilePic1.path,
                alignment: Alignment.center,
                fit: BoxFit.fill,
                height: responsive.screenHeight / 6,
              ),
            ),
            SizedBox(
              height: responsive.screenHeight / 40,
            ),
            Obx(() {
              return Column(
                spacing: 15,
                children: [
                  if (uic.fullName.value.isNotEmpty && !isEditing.value)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "نام کاربری : ",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          uic.fullName.value,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                            onPressed: () {
                              isEditing.value = true;
                            },
                            icon: Icon(Icons.edit)),
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "نام کاربری : ",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "نام شما ثبت نشده",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        IconButton(
                            onPressed: () {
                              isEditing.value = true;
                            },
                            icon: Icon(Icons.edit)),
                      ],
                    ),
                  MyDivider(appWidth: size.width),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        uic.phone.value.isNotEmpty
                            ? "شماره تلفن :   ${uic.phone.value}"
                            : "شماره تلفن",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  MyDivider(appWidth: size.width),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("وضعیت اشتراک : ",
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text(
                        uic.isSubscriber.value
                            ? "اشتراک فعال دارید"
                            : "اشتراک فعال ندارید",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: responsive.screenHeight / 40,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await GetStorage().remove('token'); // حذف توکن از حافظه
                      if (GetStorage().read('token') == null) {
                        Get.offAllNamed(AppRoutes.smsVerify);
                      }
                    },
                    // استایل دکمه خروج
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF39FF14), // رنگ سبز
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.screenWidth / 7,
                        vertical: responsive.screenHeight / 50,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("خروج"),
                  ),
                  if (isEditing.value == true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: responsive.screenWidth / 1.5,
                          padding: responsive.scaledPaddingLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            // focusNode: _focusNode,
                            controller: nameUser,
                            enabled: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "نام خود را وارد کنید",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: Colors.black45,
                                    )),
                            maxLines: 1,
                            cursorColor: Colors.black45,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.black,
                                ),
                          ),
                        ),
                        IconButton(
                            onPressed: () async {
                              await uic.updateUserInfo(
                                fullName: nameUser.text, // اگه فقط نام عوض شده
                                isSubscriber: false, // اگه لازم بود
                              );
                              isEditing.value =
                                  false; // بعد از ویرایش برمی‌گرده
                            },
                            icon: Icon(Icons.check)),
                      ],
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
