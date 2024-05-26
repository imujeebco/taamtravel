// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_paddings.dart';

class Slice extends StatelessWidget {
  double? height;
  double? contentHorizontalPadding;
  Color? statusColor;
  final VoidCallback onPress;
  final Widget leftAreaContent;
  final Widget rightAreaContent;
  final bool isSelected;
  Slice({
    Key? key,
    required this.onPress,
    required this.leftAreaContent,
    required this.rightAreaContent,
    required this.isSelected,
    this.height,
    this.contentHorizontalPadding,
    this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = context.theme.colorScheme;
    Size screenSize = MediaQuery.of(context).size;
    double? containerHeight = height ?? 250;
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppPaddings.appMainPaddingSmall),
        child: PhysicalModel(
          color: Colors.transparent,
          elevation: 5.0,
          child: Container(
            width: double.infinity,
            height: containerHeight,
            decoration: BoxDecoration(
              border: isSelected ? Border.all(color: theme.onPrimary, width: 1.5) : const Border(),
            ),
            child: Row(
              children: [
                // Left Container
                Container(
                  height: containerHeight,
                  width: screenSize.width * 0.20,
                  color: statusColor ?? theme.onPrimary,
                  child: leftAreaContent,
                ),
                // Right Child
                Expanded(
                  child: Container(
                    height: containerHeight,
                    padding: EdgeInsets.symmetric(
                      vertical: AppPaddings.appMainPaddingLarge,
                      horizontal: contentHorizontalPadding ?? AppPaddings.appMainPaddingLarge,
                    ),
                    decoration: BoxDecoration(
                      color: theme.primary,
                    ),
                    child: rightAreaContent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
