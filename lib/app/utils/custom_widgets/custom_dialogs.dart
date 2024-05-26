// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_fontweights.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';

class MyDialog {
  static MyAlertDialog(context, text, onYes, onNo) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Get.theme.colorScheme.secondary,
        content: Text(
          text,
          style: TextStyle(fontSize: 17, fontWeight: AppFontWeights.appTextFontWeightLight, color: Get.theme.colorScheme.onSecondary),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Get.theme.colorScheme.onSecondary),
            onPressed: onNo,
            child: Text(
              "No",
              style: TextStyle(fontWeight: AppFontWeights.appTextFontWeightMedium, color: Get.theme.colorScheme.onSecondary),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Get.theme.colorScheme.tertiary, foregroundColor: Get.theme.colorScheme.onSecondary),
            onPressed: onYes,
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  static void showDialogBox(String title, String message, Function() onOKPress) {
    Get.defaultDialog(
        title: title,
        content: Text(message, style: const TextStyle(), textAlign: TextAlign.center),
        contentPadding: const EdgeInsets.all(20.0),
        cancel: Container(),
        confirm: SizedBox(
          width: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Get.theme.colorScheme.onPrimary),
            onPressed: onOKPress,
            child: CommonText(
              text: "Ok",
              color: Get.theme.colorScheme.primary,
            ),
          ),
        ),
        radius: 10.0,
        titlePadding: const EdgeInsets.fromLTRB(0, 15, 0, 0));
  }

  static showProgressBar() {
    Get.dialog(
        Center(
          child: Container(
                  height: 100,
                  width: 100,
                  // margin: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/favicon.png"),
                    ),
                  ))
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .shimmer(
                // delay: Duration(milliseconds: 1500),
                duration: const Duration(milliseconds: 800),
              ),
        ),
        barrierDismissible: false);
  }

  static void hideProgressBar() {
    Get.back();
  }

  static Widget LoaderDialog() {
    return Stack(
      children: [
        Center(
          child: Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.only(top: Get.height * 0.2),
            child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/favicon.png"),
                      ),
                    ))
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .shimmer(
                  duration: const Duration(milliseconds: 400),
                ),
          ),
        )
      ],
    );
  }
}
