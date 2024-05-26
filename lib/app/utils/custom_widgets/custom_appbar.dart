// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:travel_app/app/configs/app_fontweights.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const CustomAppBar({this.title, super.key});
  final String? title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      elevation: 0.0,
      title: CommonText(text: title ?? '', weight: AppFontWeights.appTextFontWeightMedium, fontSize: 20.0),
    );
  }
}
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
//   CustomAppBar({
//     super.key,
//     this.leading,
//     this.title,
//     this.action,
//     this.isAction = true,
//     this.isTitleWidget = false,
//     this.titleWidget,
//   });

//   Widget? leading, action, titleWidget;
//   String? title;
//   bool isAction = true, isTitleWidget = false;

//   @override
//   Widget build(BuildContext context) {
//     var theme = context.theme.colorScheme;
//     return AppBar(
//       leading: NuemorphContainer(
//         marginAll: 8.0,
//         height: 40.0,
//         width: 40.0,
//         child: leading ?? Container(),
//       ),
//       title: isTitleWidget
//           ? titleWidget
//           : CommonText(
//               text: title!,
//               color: theme.onSecondary,
//               fontSize: 18,
//               weight: FontWeight.w600,
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

// class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
//   EmptyAppBar({super.key});

//   Widget? leading, action, titleWidget;
//   String? title;
//   bool isAction = true, isTitleWidget = false;

//   @override
//   Widget build(BuildContext context) {
//     var theme = context.theme.colorScheme;
//     return Container();
//   }
// }
