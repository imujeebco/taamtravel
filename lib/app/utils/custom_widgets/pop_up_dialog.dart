// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_fontweights.dart';
import 'package:travel_app/app/configs/app_paddings.dart';

class PopUpDialog extends StatefulWidget {
  final String title;
  final Widget content;
  final bool isAction;
  final bool isCloseBtn;
  final bool isHeader;
  VoidCallback onPressYes;
  final bool? isCancel;
  final Function()? onClose;
  //VoidCallback? onPressNo;
  double? horizontalContentPadding;
  PopUpDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.isAction,
    required this.isCloseBtn,
    required this.isHeader,
    required this.onPressYes,
    this.isCancel = false,
    this.onClose,
    this.horizontalContentPadding,
  }) : super(key: key);

  @override
  State<PopUpDialog> createState() => _PopUpDialogState();
}

class _PopUpDialogState extends State<PopUpDialog> {
  @override
  Widget build(BuildContext context) {
    var theme = Get.theme.colorScheme;
    Size screenSize = MediaQuery.of(context).size;
    return AlertDialog(
      elevation: 16.0,
      titlePadding: const EdgeInsets.only(top: 8.0),
      insetPadding: const EdgeInsets.symmetric(horizontal: AppPaddings.appMainPaddingSmall),
      title: widget.isHeader
          ? widget.isCancel == true
              ? Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: theme.onSecondary,
                    ),
                    onPressed: () {
                      // Get.toNamed(PageNames.dashBoardScreen);
                    },
                  ),
                )
              : SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: widget.isCloseBtn
                      ? Center(
                          child: Text(
                            widget.title,
                          ),
                        )
                      : Center(
                          child: Text(
                            widget.title,
                          ),
                        ),
                )
          : Container(
              height: 20,
            ),
      content: widget.content,
      contentTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: AppFontSizes.appFontSizeh9,
        color: theme.onSecondary,
        letterSpacing: 0.5,
      ),
      contentPadding: EdgeInsets.symmetric(
          vertical: AppPaddings.appMainPaddingMedium,
          horizontal: widget.horizontalContentPadding != null ? widget.horizontalContentPadding! : AppPaddings.appMainPaddingSmall),
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: AppFontSizes.appFontSizeh9,
        fontWeight: AppFontWeights.appTextFontWeightBold,
        color: theme.onPrimary,
        letterSpacing: 0.5,
      ),
      actions: widget.isAction
          ? [
              TextButton(
                onPressed: () {
                  widget.onPressYes();
                },
                child: const Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"),
              ),
            ]
          : [],
    );
  }
}
