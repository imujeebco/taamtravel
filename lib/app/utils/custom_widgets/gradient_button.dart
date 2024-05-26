// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_box_shadow.dart';
import 'package:travel_app/app/configs/app_size_config.dart';

class GradeBtn extends StatelessWidget {
  GradeBtn(
      {super.key,
      required this.marginAll,
      this.name,
      required this.onpressed,
      required this.firstClr,
      required this.lastClr,
      required this.heightB,
      required this.widthB,
      required this.circularBorder,
      this.isShadow = true,
      this.isChild = false,
      this.child});

  final double marginAll, heightB, widthB, circularBorder;
  final String? name;
  final Function() onpressed;
  final Color firstClr, lastClr;
  bool isShadow = true, isChild = false;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    var theme = context.theme.colorScheme;
    HeightWidth(context);

    return Container(
      margin: EdgeInsets.all(marginAll),
      height: h * heightB,
      width: w * widthB,
      decoration: BoxDecoration(
        boxShadow: isShadow ? [AppBoxShadow.tinyBtnBoxShadow] : [],
        borderRadius: BorderRadius.circular(circularBorder),
        gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
          firstClr,
          lastClr,
        ]),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(circularBorder)),
          enableFeedback: false,
          textStyle: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700, color: Colors.white),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: onpressed,
        child: !isChild
            ? FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  name!,
                  style: const TextStyle(color: Colors.white),
                ))
            : child,
      ),
    );
  }
}
