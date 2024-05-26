// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_size_config.dart';

class LogoLoader extends StatelessWidget {
  String? loadingMsg;
  LogoLoader([this.loadingMsg]);

  @override
  Widget build(BuildContext context) {
    var theme = context.theme.colorScheme;
    HeightWidth(context);
    const double size = 70;
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
                height: size,
                width: size,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/favicon.png"),
                  ),
                ))
            .animate(
              onPlay: (icontroller) => icontroller.repeat(),
            )
            .shimmer(
              duration: const Duration(milliseconds: 800),
            ),
        Text(loadingMsg ?? ''),
      ],
    ));
  }
}
