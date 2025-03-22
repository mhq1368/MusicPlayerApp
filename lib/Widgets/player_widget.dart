// import 'package:audio_player_test/Controllers/audio_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PlayerWidget extends StatelessWidget {
//   const PlayerWidget({
//     super.key,
//     required this.size,
//     required this.controller,
//   });

//   final Size size;
//   final MusicControllerT controller;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(color: Colors.transparent),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             margin: EdgeInsets.all(20),
//             height: size.height * .2,
//             decoration: BoxDecoration(color: Colors.black26),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                     onPressed: () {}, icon: Icon(CupertinoIcons.shuffle)),
//                 IconButton(
//                     onPressed: () {}, icon: Icon(CupertinoIcons.shuffle)),
//               ],
//             ),
//           ),
//           Container(
//             decoration:
//                 BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
//             width: size.width / 2,
//             height: size.height * 0.3,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     controller.player.seekToNext();
//                     controller.currentpodcast.value =
//                         controller.player.currentIndex!;
//                   },
//                   child: Icon(
//                     Icons.skip_next,
//                     color: Colors.white,
//                     size: 35,
//                   ),
//                 ),
//                 GestureDetector(
//                     onTap: () async {
//                       if (controller.isPlaying.value == false) {
//                         controller.isPlaying.value = true;
//                         controller.player.play();
//                         controller.currentpodcast.value =
//                             controller.player.currentIndex!;
//                       } else if (controller.isPlaying.value == true) {
//                         controller.isPlaying.value = false;
//                         controller.player.pause();
//                       }
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         IconButton(
//                             onPressed: () {},
//                             icon: Icon(CupertinoIcons.speaker_1_fill)),
//                         Obx(
//                           () => Icon(
//                             controller.isPlaying.value == false
//                                 ? CupertinoIcons.play_arrow_solid
//                                 : CupertinoIcons.pause_solid,
//                             color: Colors.white,
//                             size: 45,
//                           ),
//                         ),
//                         IconButton(
//                             onPressed: () {},
//                             icon: Icon(CupertinoIcons.heart_fill)),
//                       ],
//                     )),
//                 GestureDetector(
//                   onTap: () {
//                     controller.player.seekToPrevious();
//                     controller.currentpodcast.value =
//                         controller.player.currentIndex!;
//                   },
//                   child: Icon(
//                     Icons.skip_previous,
//                     color: Colors.white,
//                     size: 35,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(20),
//             height: size.height * 0.2,
//             decoration: BoxDecoration(color: Colors.black26),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                     onPressed: () {}, icon: Icon(CupertinoIcons.shuffle)),
//                 IconButton(
//                     onPressed: () {}, icon: Icon(CupertinoIcons.repeat_1)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
