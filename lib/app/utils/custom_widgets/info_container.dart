import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_fontweights.dart';

class InfoContainer extends StatelessWidget {
  final String time;
  final String infoTitle;
  final Color? tileColor;
  final VoidCallback onPress;
  const InfoContainer({
    Key? key,
    required this.time,
    required this.infoTitle,
    required this.tileColor,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = context.theme.colorScheme;
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        height: 80.0,
        width: (screenSize.width / 3) - 20.0,
        decoration: BoxDecoration(
          color: tileColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time,
              style: TextStyle(
                fontSize: AppFontSizes.appFontSizeh10,
                color: tileColor == AppColors.appColorSeparator ? theme.primary : theme.primary,
              ),
            ),
            Text(
              infoTitle,
              style: TextStyle(
                fontSize: AppFontSizes.appFontSizeh11,
                color: tileColor == AppColors.appColorSeparator ? theme.primary : theme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
