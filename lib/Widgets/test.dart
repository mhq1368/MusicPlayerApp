// SingleChildScrollView(
//                 child: SizedBox(
//                   height: size.height,
//                   width: double.infinity,
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(top: 25),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(25),
//                               topRight: Radius.circular(25)),
//                           child: Obx(
//                             () {
//                               final list = playAudioController.audiolist;
//                               final index =
//                                   playAudioController.currentmusic.value;

//                               if (list.isEmpty || index >= list.length) {
//                                 return CachedNetworkImage(
//                                   width: size.width / 1.2,
//                                   height: size.height / 4,
//                                   fit: BoxFit.cover,
//                                   imageUrl: "",
//                                   placeholder: (context, url) =>
//                                       Center(child: mainLoading(size.height)),
//                                   errorWidget: (context, url, error) => Center(
//                                       child: mainLoading(size.height / 3)),
//                                 );
//                               }

//                               return CachedNetworkImage(
//                                 width: size.width / 1.2,
//                                 height: size.height / 4,
//                                 fit: BoxFit.cover,
//                                 imageUrl: list[index].musicCover ?? "",
//                                 placeholder: (context, url) =>
//                                     Center(child: mainLoading(size.height)),
//                                 errorWidget: (context, url, error) =>
//                                     Center(child: mainLoading(size.height / 3)),
//                               );
//                             },
//                           ),
//                         ),
//                       ),

//                       Container(
//                         height: 65,
//                         width: size.width / 1.2,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(25),
//                                 bottomRight: Radius.circular(25)),
//                             color: Color(0xffF1D9AB)),
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 25),
//                           child: Row(
//                             children: [
//                               SvgPicture.asset(
//                                 Assets.icons.microphone,
//                                 height: 20,
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Obx(
//                                 () {
//                                   final list = playAudioController.audiolist;
//                                   final index =
//                                       playAudioController.currentmusic.value;

//                                   if (list.isEmpty || index >= list.length) {
//                                     return Text("در حال بارگذاری ...",
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .labelMedium);
//                                   }

//                                   return Text(
//                                     list[index].musicName ??
//                                         "نام آهنگ نامشخص است",
//                                     style:
//                                         Theme.of(context).textTheme.labelMedium,
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       //لیست آهنگ های خواننده
//                       SingleChildScrollView(
//                         child: SizedBox(
//                           height: size.height / 3,
//                           width: double.infinity,
//                           child: Obx(
//                             () {
//                               final list = playAudioController.audiolist;
//                               return ListView.builder(
//                                 itemCount: list.length,
//                                 itemBuilder: (context, index) {
//                                   final isCurrent = index ==
//                                       playAudioController.currentmusic.value;

//                                   return GestureDetector(
//                                     onTap: () {
//                                       playAudioController.isplaying.value =
//                                           false;
//                                       playAudioController.player.stop();
//                                       Get.offAll(() => PlayNowMusic(),
//                                           arguments: {
//                                             'music': list[index],
//                                             'singerid': list[index].singerId
//                                           });
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           10, 20, 10, 0),
//                                       child: Container(
//                                         height: 60,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(25),
//                                           gradient: LinearGradient(
//                                             colors: [
//                                               Color(0xff6987B7),
//                                               Color(0xaa40577D),
//                                               Color(0xff1A2B47),
//                                             ],
//                                             begin: Alignment.topRight,
//                                             end: Alignment.bottomLeft,
//                                           ),
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 15),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 list[index].musicName ?? "",
//                                                 style: isCurrent
//                                                     ? Theme.of(context)
//                                                         .textTheme
//                                                         .displaySmall
//                                                     : Theme.of(context)
//                                                         .textTheme
//                                                         .displayLarge,
//                                               ),
//                                               Text(
//                                                 list[index].musictime ?? "",
//                                                 style: isCurrent
//                                                     ? Theme.of(context)
//                                                         .textTheme
//                                                         .displaySmall
//                                                     : Theme.of(context)
//                                                         .textTheme
//                                                         .displayLarge,
//                                               ),
//                                               IconButton(
//                                                 onPressed: () {
//                                                   playAudioController
//                                                       .isplaying.value = false;
//                                                   playAudioController.player
//                                                       .stop();
//                                                   Get.offAll(
//                                                       () => PlayNowMusic(),
//                                                       arguments: {
//                                                         'music': list[index],
//                                                         'singerid':
//                                                             list[index].singerId
//                                                       });
//                                                 },
//                                                 icon: Icon(CupertinoIcons
//                                                     .play_circle_fill),
//                                                 style: ButtonStyle(
//                                                   iconColor:
//                                                       WidgetStatePropertyAll(
//                                                     isCurrent
//                                                         ? Colors.white
//                                                         : Color(0x90ffffff),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               // بخش کنترل پخش موزیک
//               Positioned(
//                 bottom: 10,
//                 left: 15,
//                 right: 15,
//                 top: size.height / 1.45,
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 5, bottom: 0),
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: 120,
//                     child: Column(
//                       children: [
//                         //ProgressBar  برای پخش موزیک
//                         Obx(
//                           () => ProgressBar(
//                             barHeight: 10,
//                             bufferedBarColor:
//                                 Color.fromARGB(255, 237, 216, 178),
//                             timeLabelTextStyle:
//                                 Theme.of(context).textTheme.labelSmall,
//                             thumbColor: Color(0xffF2E1C1),
//                             progressBarColor:
//                                 Color.fromARGB(255, 237, 216, 178),
//                             baseBarColor: Color(0xfff5f5f5),
//                             progress: playAudioController.progressValue.value,
//                             total: playAudioController.player.duration ??
//                                 Duration(seconds: 0),
//                             buffered: playAudioController.bufferedValue.value,
//                             onSeek: (position) {
//                               playAudioController.player.seek(position);
//                               playAudioController.player.playing
//                                   ? playAudioController.startProgress()
//                                   : playAudioController.timer!.cancel();
//                             },
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             SvgPicture.asset(
//                               Assets.icons.bookmarkSvg,
//                               height: 25,
//                               // ignore: deprecated_member_use
//                               color: Color(0xffF2E1C1),
//                             ),
//                             //رفتن به موزیک بعدی
//                             GestureDetector(
//                               onTap: () async {
//                                 playAudioController.player.seekToNext();
//                                 playAudioController.currentmusic.value =
//                                     playAudioController.player.currentIndex!;
//                               },
//                               child: SvgPicture.asset(
//                                 Assets.icons.forward,
//                                 height: 32,
//                                 // ignore: deprecated_member_use
//                                 color: Color(0xffF2E1C1),
//                               ),
//                             ),
//                             // شروع کردن به پخش موزیک
//                             Obx(() => GestureDetector(
//                                 onTap: () async {
//                                   playAudioController
//                                       .player.processingStateStream
//                                       .listen((state) {
//                                     if (state == ProcessingState.completed) {
//                                       playAudioController.player.seek(
//                                           Duration.zero); // بازگشت به اول آهنگ
//                                       playAudioController.player
//                                           .play(); // دوباره پخش کن
//                                     }
//                                   });

//                                   if (playAudioController.player.playing) {
//                                     playAudioController.player.pause();
//                                     playAudioController.isplaying.value = false;
//                                   } else {
//                                     playAudioController.isplaying.value = true;
//                                     playAudioController.startProgress();
//                                     playAudioController.player.play();
//                                     playAudioController.isplaying.value =
//                                         playAudioController.player.playing;

//                                     playAudioController.currentmusic.value =
//                                         playAudioController
//                                             .player.currentIndex!;
//                                   }
//                                 },
//                                 child: Container(
//                                   width: 70,
//                                   height: 70,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Center(
//                                       child: playAudioController
//                                                   .isplaying.value ==
//                                               false
//                                           ? SvgPicture.asset(
//                                               Assets.icons
//                                                   .play, // Path to your triangle SVG
//                                               width: 30,
//                                               height: 30,
//                                               // ignore: deprecated_member_use
//                                               color: Color(
//                                                   0xff3C5782) // Set the color of the triangle
//                                               )
//                                           : Icon(
//                                               CupertinoIcons.pause_solid,
//                                               color: Color(0xff3C5782),
//                                               size: 37,
//                                             )),
//                                 ))),

//                             //برگشت به موزیک قبلی
//                             GestureDetector(
//                               onTap: () {
//                                 playAudioController.player.seekToPrevious();
//                                 playAudioController.currentmusic.value =
//                                     playAudioController.player.currentIndex!;
//                               },
//                               child: SvgPicture.asset(
//                                 Assets.icons.rewind,
//                                 height: 32,
//                                 // ignore: deprecated_member_use
//                                 color: Color(0xffF2E1C1),
//                               ),
//                             ),
//                             SvgPicture.asset(
//                               Assets.icons.shuffle,
//                               height: 25,
//                               // ignore: deprecated_member_use
//                               color: Color(0xffF2E1C1),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
