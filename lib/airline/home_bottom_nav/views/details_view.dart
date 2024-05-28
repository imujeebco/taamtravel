import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/airline/home_bottom_nav/bnb/bottom_nav_view.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({required this.title, super.key});
  final String title;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Picture Container ------------------------------------
            Container(
              height: h * 0.35,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/aa.png',
                      ),
                      fit: BoxFit.cover)),
            ),
            // title ------------------------------------
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: CommonText(
                text: '${widget.title} Lounge',
                fontSize: 18.0,
                weight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CommonText(
                text:
                    'Secure your seat in the skies with our Economy Class Ticket booking. Tailored for travelers looking for both value and comfort, our Economy Class offers an array of amenities to ensure a pleasant journey. From ergonomic seating designed for relaxation to a selection of in-flight entertainment and meal options, every aspect of your flight is crafted with your satisfaction in mind. Enjoy the convenience of easy booking and attractive fares, all while experiencing the quality service that makes your trip memorable. Book your next adventure or business voyage in Economy Class and discover a world of affordable luxury.',
                fontSize: 12.0,
                textAlign: TextAlign.justify,
                lineHeight: 1.5,
              ),
            ),
            // CommonText(text: 'DETAILS SCREEN'),

            // Spacer(),

            // Button ----------------------------

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: CustomButton(
                  height: 40,
                  width: w,
                  text: 'Search Flight',
                  onPress: () {
                    Get.to(() => BottomNavScreen(
                          cabinClass: widget.title,
                          fromDetails: true,
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
