// import 'dart:async';

// import 'package:edeybe/index.dart';
// import 'package:edeybe/screens/home_screen/index.dart';
// import 'package:flutter/material.dart';
// import 'package:percent_indicator/percent_indicator.dart';

// class TransLoading extends StatefulWidget {
//   @override
//   _TransLoadingState createState() => _TransLoadingState();
// }

// class _TransLoadingState extends State<TransLoading>
//     with SingleTickerProviderStateMixin {
//   String paymentStatus = "Transaction is in process";
//   bool showLoad = true;
//   bool circleShow = true;
//   bool showButton = false;

//   double percent = 0.0;

//   AnimationController controller;

//   Animation animation;

//   double beginAnim = 0.0;
//   double endAnim = 1.0;

//   @override
//   void initState() {
//     super.initState();
//     controller =
//         AnimationController(duration: const Duration(seconds: 10), vsync: this);
//     animation = Tween(begin: beginAnim, end: endAnim).animate(controller)
//       ..addListener(() {
//         setState(() {
//           // Change here any Animation object value.
//         });
//       });
//     startProgress();
//   }

//   @override
//   void dispose() {
//     controller.stop();
//     super.dispose();
//   }

//   startProgress() {
//     controller.forward();
//   }

//   stopProgress() {
//     controller.stop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Get.theme.primaryColor,
//       body: Center(
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             // crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                   padding: EdgeInsets.all(20.0),
//                   child: Stack(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top:4.0),
//                         child: LinearProgressIndicator(
//                           value: animation.value,
//                           minHeight: 20,
//                         ),
//                       ),
//                       Align(
//                           alignment: Alignment.center,
//                           child: Center(child: Text("data")))
//                     ],
//                   )),

//               Text(
//                 "$paymentStatus",
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15.0),
//                 child: Visibility(
//                   visible: showLoad,
//                   child: Padding(
//                     padding: EdgeInsets.all(10.0),
//                     child: LinearPercentIndicator(
//                       width: MediaQuery.of(context).size.width - 50,
//                       animation: true,
//                       animationDuration: 10000,
//                       lineHeight: 25.0,
//                       percent: percent / 100,
//                       onAnimationEnd: () {
//                         setState(() {
//                           paymentStatus = "Transaction has been processed";
//                         });
//                         // Timer(Duration(seconds: 2), () {
//                         //   Get.off(HomeIndex(
//                         //     indexPage: 0,
//                         //   ));
//                         // });
//                       },
//                       center: Text(
//                         "$percent%",
//                         style: TextStyle(fontSize: 12),
//                       ),
//                       linearStrokeCap: LinearStrokeCap.roundAll,
//                       progressColor: Get.theme.primaryColorLight,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//               // Visibility(
//               //   visible: showButton,
//               //   child: Padding(
//               //     padding: EdgeInsets.only(left: 8.0.w, top: 8.0.w),
//               //     child: ButtonTheme(
//               //       minWidth: 120.w,
//               //       height: 40.w,
//               //       child: TextButton(
//               //         style: TextButton.styleFrom(
//               //           shape: RoundedRectangleBorder(
//               //               side: BorderSide(color: Colors.white, width: 1.0.w),
//               //               borderRadius: BorderRadius.circular(8.w)),
//               //           backgroundColor: Get.theme.primaryColor,
//               //           onSurface: Get.theme.primaryColor.withOpacity(0.5.w),
//               //         ),
//               //         child: Text(
//               //           "Go Home",
//               //           maxLines: 1,
//               //           style: TextStyle(color: Colors.white),
//               //           overflow: TextOverflow.ellipsis,
//               //         ),
//               //         onPressed: () {
//               // Get.to(HomeIndex(
//               //   indexPage: 0,
//               // ));
//               //           // Get.off(WriteReviewScreen());
//               //         },
//               //       ),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//       // bottomNavigationBar: Container(
//       //   height: 60,
//       //   child: Center(
//       //       child: circleShow
//       //           ? CircularProgressIndicator()
//       //           : Container(
//       //               height: 0,
//       //             )),
//       // ),
//     );
//   }
// }
