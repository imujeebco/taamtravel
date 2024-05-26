// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_fontweights.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';

class MyToast {
  static snackToast(String message, int code) {
    var img = code == 0
        ? 'error_lottie'
        : code == 1
            ? 'success_lottie'
            : 'info_lottie';

    var color = code == 0
        ? AppColors.errorColorDark
        : code == 1
            ? AppColors.successColorDark
            : Get.theme.colorScheme.outline;
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        backgroundColor: color.withOpacity(0.7),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        behavior: SnackBarBehavior.floating,
        content: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Lottie.asset(
              //   options: LottieOptions(),
              //   animate: true,
              //   'assets/lottie/$img.json', // no_order
              //   frameRate: FrameRate.composition,
              //   height: 40,
              //   fit: BoxFit.fill,
              //   alignment: Alignment.center,
              //   addRepaintBoundary: false,
              // ),
              // const SizedBox(width: 8.0),
              CommonText(
                text: message,
                color: Colors.white,
                weight: AppFontWeights.appTextFontWeightMedium,
              ).fittedBox(280, BoxFit.scaleDown),
            ],
          ),
        )));
  }
}
