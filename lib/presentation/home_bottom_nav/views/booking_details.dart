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
class BookingDetailsScreen extends StatefulWidget {
  String parentPNR;
  String status;
  BookingDetailsScreen(
      {super.key, required this.parentPNR, required this.status});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
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
            CommonText(
                text: 'Your Reservation Status: \n${widget.status}',
                textAlign: TextAlign.center,
                weight: FontWeight.w600,
                fontSize: 20.0),
            0.02.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText(
                    text: 'PNR  Number ',
                    textAlign: TextAlign.center,
                    weight: FontWeight.w600,
                    fontSize: 20.0),
                CommonText(
                    text: widget.parentPNR,
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
