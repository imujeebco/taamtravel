import 'package:flutter/material.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_outline_button.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      backgroundColor: AppColors.appColorAccent,
      appBar: CustomAppBar(title: "Filters"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              FilterHeadings(title: "Stops", text: "From"),
              buildFilterButton(title: "Non Stop"),
              buildFilterButton(title: "1 Stop"),
              0.01.ph,
              FilterHeadings(title: "Airlines", text: "From"),
              0.02.ph,
              buildFilterButton(title: "Salaam Air"),
              buildFilterButton(title: "Aerojet Aviation"),
              buildFilterButton(title: "Afro Atlas"),
              buildFilterButton(title: "Blue Air Express"),
              0.01.ph,
              FilterHeadings(title: "Airlines", text: "From"),
              0.02.ph,
              buildFilterButton(title: "Carry-on bag included"),
              buildFilterButton(title: "No cancel fee"),
              buildFilterButton(title: "No cancel fee"),
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
class FilterHeadings extends StatelessWidget {
  String title;
  String text;
  FilterHeadings({
    required this.title,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(
            text: title,
            fontSize: 16,
            weight: FontWeight.w600,
          ),
          CommonText(
            text: text,
            fontSize: 16,
            weight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}

// ignore:  must_be_immutable, camel_case_types
class buildFilterButton extends StatelessWidget {
  String title;
  String? trailing;
  buildFilterButton({
    required this.title,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      enabled: false,
      onTap: () {},
      leading: Checkbox(
        activeColor: AppColors.appColorPrimary,
        value: true,
        onChanged: (bool? value) {},
      ),
      title: CommonText(
        text: title,
        fontSize: 14,
        weight: FontWeight.w400,
      ),
      subtitle: const Divider(),
      trailing: CommonText(
        text: trailing ?? "\$125",
        fontSize: 16,
        weight: FontWeight.w600,
      ),
    );
  }
}
