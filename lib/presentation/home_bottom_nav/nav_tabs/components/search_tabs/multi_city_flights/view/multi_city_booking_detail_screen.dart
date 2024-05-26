import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/presentation/home_bottom_nav/bnb/bottom_nav_view.dart';

// ignore: must_be_immutable
class MultiCityBookingDetailsScreen extends StatefulWidget {
  List parentPNRList;
  List statusList;
  MultiCityBookingDetailsScreen(
      {super.key, required this.parentPNRList, required this.statusList});

  @override
  State<MultiCityBookingDetailsScreen> createState() =>
      _MultiCityBookingDetailsScreenState();
}

class _MultiCityBookingDetailsScreenState
    extends State<MultiCityBookingDetailsScreen> {
  var pnrString = '';
  var statusString = '';
  @override
  void initState() {
    pnrString = widget.parentPNRList.join('\n');
    statusString = widget.statusList.join('\n');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'Booking Details'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Icon(FontAwesomeIcons.circleCheck,
                    size: 180.0, color: AppColors.appColorPrimary)),
            0.02.ph,
            CommonText(
                text: 'Thank You for your \nReservation.',
                textAlign: TextAlign.center,
                weight: FontWeight.w600,
                fontSize: 20.0),
            0.04.ph,
            Column(
              children: [
                CommonText(
                    text: 'Your Reservation Statuses:',
                    textAlign: TextAlign.center,
                    weight: FontWeight.w400,
                    fontSize: 18.0),
                CommonText(
                    text: statusString ?? '',
                    textAlign: TextAlign.center,
                    weight: FontWeight.w600,
                    fontSize: 20.0,
                    color: statusString == "Confirmed"
                        ? AppColors.appColorPrimary
                        : Color.fromARGB(255, 92, 159, 95)),
              ],
            ),
            0.02.ph,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText(
                    text: 'PNR  Numbers:',
                    textAlign: TextAlign.center,
                    weight: FontWeight.w400,
                    fontSize: 18.0),
                CommonText(
                    text: pnrString ?? '',
                    textAlign: TextAlign.center,
                    weight: FontWeight.w600,
                    fontSize: 20.0,
                    color: AppColors.appColorPrimary),
              ],
            ),
            0.04.ph,
            CommonText(
                text:
                    'Thank You for choosing silicon Reservation as your host for your traveling. We look forward to welcoming you and ensuring a most enjoyable visit.',
                textAlign: TextAlign.center,
                fontSize: 16.0),
            Spacer(),
            CustomButton(
                width: w,
                height: 35,
                text: "Go to Booking",
                onPress: () {
                  Get.to(() => BottomNavScreen());
                }),
          ],
        ),
      ),
    );
  }
}
