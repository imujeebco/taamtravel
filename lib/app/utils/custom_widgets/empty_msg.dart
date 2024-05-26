// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class EmptyMsg extends StatelessWidget {
//   EmptyMsg({super.key, required this.title, required this.msg, required this.img, this.height = 0.3});

//   String title, msg, img;
//   num? height;

//   @override
//   Widget build(BuildContext context) {
//     var theme = context.theme.colorScheme;
//     HeightWidth(context);
//     return Container(
//       alignment: Alignment.center,
//       margin: EdgeInsets.symmetric(horizontal: w * 0.15),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Lottie.asset(
//             options: LottieOptions(),
//             animate: true,
//             'assets/lottie/$img.json',
//             frameRate: FrameRate.composition,
//             height: h * height!,
//             fit: BoxFit.fill,
//             alignment: Alignment.center,
//             addRepaintBoundary: false,
//           ),
//           0.02.ph,
//           CommonText(
//             text: title,
//             fontSize: 30.0,
//             weight: FontWeight.bold,
//             color: theme.onSecondary,
//           ),
//           0.02.ph,
//           CommonText(
//             text: msg,
//             textAlign: TextAlign.center,
//             fontSize: 18.0,
//             color: theme.onSecondary,
//           )
//         ],
//       ),
//     );
//   }
// }
