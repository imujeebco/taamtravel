import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_outline_button.dart';

class SortScreen extends StatefulWidget {
  const SortScreen({super.key});

  @override
  State<SortScreen> createState() => _SortScreenState();
}

class _SortScreenState extends State<SortScreen> {
  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      backgroundColor: AppColors.appColorAccent,
      appBar: CustomAppBar(title: "Sort by"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Buildbutton(
                  buttonText: "Recommended",
                  onPress: () {
                    Get.back();
                  }),
              Buildbutton(buttonText: "Price (Low to High)", onPress: () {}),
              Buildbutton(buttonText: "Price (High to Low)", onPress: () {}),
              Buildbutton(buttonText: "Duration (Shortest)", onPress: () {}),
              Buildbutton(buttonText: "Duration (Longest)", onPress: () {}),
              Buildbutton(buttonText: "Departure (Earliest)", onPress: () {}),
              Buildbutton(buttonText: "Departure (Latest)", onPress: () {}),
              Buildbutton(buttonText: "Arrival (Earliest)", onPress: () {}),
              Buildbutton(buttonText: "Arrival (Latest)", onPress: () {}),
              0.03.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomOutlineButton(
                      width: 150, text: "Clear", onPress: () {}),
                  CustomButton(width: 150, text: "Apply", onPress: () {}),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Buildbutton extends StatelessWidget {
  String buttonText;
  final Function() onPress;
  Buildbutton({
    required this.buttonText,
    required this.onPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onPress,
      title: CommonText(
        text: buttonText,
        weight: FontWeight.w400,
        fontSize: 16,
      ),
      subtitle: const Divider(),
    );
  }
}
