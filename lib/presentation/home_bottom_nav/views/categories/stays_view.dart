import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield.dart';

class StaysScreen extends StatefulWidget {
  const StaysScreen({super.key});

  @override
  State<StaysScreen> createState() => _StaysScreensState();
}

class _StaysScreensState extends State<StaysScreen> {
  TextEditingController cityController = TextEditingController();
  TextEditingController datesController = TextEditingController();
  TextEditingController travellerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'Stays'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            CommonText(text: 'StaysScreen'),
            // -------------------

            // Destination Field ------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.search,
                  color: AppColors.appColorPrimary,
                ),
                0.04.pw,
                SizedBox(
                  width: w * 0.8,
                  child: CustomTextField(textEditingController: cityController, labelText: 'Enter destination', hintText: 'Dubai, UAE'),
                ),
              ],
            ),
            0.03.ph,

            // Dates Field ------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.calendar_month,
                  color: AppColors.appColorPrimary,
                ),
                0.04.pw,
                SizedBox(
                  width: w * 0.8,
                  child: CustomTextField(textEditingController: datesController, labelText: 'Enter Dates', hintText: '30 Jan - 13 Feb'),
                ),
              ],
            ),

            0.03.ph,

            // Traveller Field ------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  FontAwesomeIcons.solidUser,
                  color: AppColors.appColorPrimary,
                ),
                0.04.pw,
                SizedBox(
                  width: w * 0.8,
                  child: CustomTextField(textEditingController: travellerController, labelText: 'Travellers', hintText: '2 Travellers, 1 room'),
                ),
              ],
            ),

            Spacer(),
            CustomButton(
                height: 40,
                width: w,
                text: 'Search Hotels',
                onPress: () {
                  // Get.to(() => SearchFlightScreen());
                }),
          ],
        ),
      ),
    );
  }
}
