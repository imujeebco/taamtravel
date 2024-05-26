import 'package:flutter/material.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';

// ignore: camel_case_types
class Outline_button_icon extends StatelessWidget {
  final double? height;
  final double? width;
  final String text;
  final String iconPath;
  final Function() onPress;
  const Outline_button_icon({
    required this.text,
    required this.onPress,
    required this.iconPath,
    this.height,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.0,
      width: width ?? 250.0,
      child: OutlinedButton(
        onPressed: onPress,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          side: BorderSide(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 20,
              width: 20,
              child: Image(image: AssetImage(iconPath)),
            ),
            SizedBox(width: 8.0),
            CommonText(text: text),
          ],
        ),
      ),
    );
  }
}
