// // ignore_for_file: must_be_immutable, unused_local_variable

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ts_app_development/app/utils/custom_widgets/nuemorph_container.dart';

// class CustomSliverAppBar extends StatelessWidget implements PreferredSizeWidget {
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
//   CustomSliverAppBar({
//     super.key,
//     this.leading,
//     this.title,
//     this.action,
//     this.isAction = true,
//     this.isLeading = true,
//     this.isTitleWidget = false,
//     this.titleWidget,
//     this.bottom,
//     this.flexiblespace,
//   });

//   Widget? leading, action, titleWidget, flexiblespace;
//   String? title;
//   bool isAction = true, isLeading = true, isTitleWidget = false;
//   PreferredSizeWidget? bottom;

//   @override
//   Widget build(BuildContext context) {
//     var theme = context.theme.colorScheme;
//     return SliverAppBar(
//       pinned: true,
//       bottom: bottom,
//       leading: isLeading
//           ? NuemorphContainer(
//               marginAll: 8.0,
//               height: 40.0,
//               width: 40.0,
//               child: leading ?? Container(),
//             )
//           : Container(),
//       title: isTitleWidget
//           ? titleWidget
//           : Text(
//               title!,
//             ),
//       actions: [
//         isAction
//             ? NuemorphContainer(
//                 marginAll: 8.0,
//                 height: 40.0,
//                 width: 40.0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     action ?? Container(),
//                   ],
//                 ),
//               )
//             : Container(),
//       ],
//     );
//   }
// }
