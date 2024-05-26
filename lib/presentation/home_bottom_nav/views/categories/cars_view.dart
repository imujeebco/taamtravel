import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreensState();
}

class _CarsScreensState extends State<CarsScreen> {
  TextEditingController pickDropController = TextEditingController();
  TextEditingController pickdateController = TextEditingController();
  TextEditingController pickTimeController = TextEditingController();
  TextEditingController dropdateController = TextEditingController();
  TextEditingController dropTimeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'Cars'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            CommonText(text: 'CarsScreen'),
            // -------------------

            // Pick and drop off Field ------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.appColorPrimary,
                ),
                0.04.pw,
                SizedBox(
                  width: w * 0.8,
                  child: CustomTextField(
                      textEditingController: pickdateController, labelText: 'Pcik-up and Drop-Off', hintText: 'Dubai (DXB - Dubai intl.)'),
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
                  child: CustomTextField(textEditingController: pickdateController, labelText: 'Enter Dates', hintText: '30 Jan - 13 Feb'),
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
                  child: CustomTextField(textEditingController: dropTimeController, labelText: 'Travellers', hintText: '2 Travellers, 1 room'),
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
