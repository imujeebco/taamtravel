import 'package:flutter/material.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_fontweights.dart';

class AppTextStyles {
  static TextStyle splashSubtitleTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.appColorWhite.withOpacity(0.6),
    fontSize: 20.0,
    letterSpacing: 1.8,
  );
  static const TextStyle splashTextStyle = TextStyle(
    fontWeight: AppFontWeights.appTextFontWeightMedium,
    color: AppColors.appColorWhite,
    fontSize: 30.0,
    letterSpacing: 1.8,
  );

  static TextStyle orderDetailsValueStyle = const TextStyle(
    fontSize: AppFontSizes.appFontSizeh11,
    fontWeight: AppFontWeights.appTextFontWeightLight,
    // color: Get.theme.colorScheme.onSecondary,
  );

  static const TextStyle orderDetailsKeyStyle = TextStyle(
    color: AppColors.appColorLightBlue,
    fontSize: AppFontSizes.appFontSizeh11,
    fontWeight: AppFontWeights.appTextFontWeightLight,
  );
}
