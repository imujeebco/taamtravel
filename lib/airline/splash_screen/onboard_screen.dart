import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/airline/auth/view/login_screen.dart';

import '../home_bottom_nav/bnb/bottom_nav_view.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 1;
            });
          },
          children: [
            buildPage(
                color: Color(0xFFd7fada),
                urlImage: 'assets/images/onboard_background.png',
                title: "Search Flight",
                colort: Colors.white,
                subtitle:
                    'Embark on your next adventure or business trip with ease using our Search Flight feature.'),
            buildPage(
                color: Color(0xFFd7fada),
                urlImage: 'assets/images/onboard_background.png',
                title: "Book Tickets",
                colort: Colors.white,
                subtitle:
                    'Start your journey here and let us take the hassle out of flight booking.'),
          ],
        ),
      ),
    );
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required Color colort,
    required String subtitle,
  }) =>
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                // color: color,
                image: DecorationImage(
                    image: AssetImage(urlImage), fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue.withOpacity(0.5),
                Colors.black.withOpacity(0.5),
              ],
            )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 250),
              CommonText(
                text: title,
                weight: FontWeight.w500,
                color: colort,
                fontSize: 22,
              ),
              const SizedBox(height: 25),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CommonText(
                    text: subtitle,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                    fontSize: 12,
                    weight: FontWeight.w400,
                  )),
              const SizedBox(height: 25),
              SmoothPageIndicator(
                controller: controller,
                count: 2,
                effect: ScrollingDotsEffect(
                  fixedCenter: true,
                  activeStrokeWidth: 1,
                  activeDotScale: 1.5,
                  maxVisibleDots: 5,
                  radius: 8,
                  spacing: 15,
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: Colors.white,
                  dotColor: Colors.white54,
                  strokeWidth: 5,
                ),
                onDotClicked: (index) => controller.animateToPage(index,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut),
              ),
              Spacer(),
              CustomButton(
                  onPress: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    // Get.to(() => LoginScreen());
                    Get.to(() => BottomNavScreen());
                    prefs.setBool('isOnboardedStatus', true);
                  },
                  text: "Get Started"),
              isLastPage
                  ? TextButton(onPressed: () {}, child: CommonText(text: ""))
                  : TextButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        // Get.to(() => LoginScreen());
                        Get.to(() => BottomNavScreen());
                        prefs.setBool('isOnboardedStatus', true);
                      },
                      child: CommonText(text: "Skip", color: Colors.white)),
              SizedBox(height: 100)
            ],
          )
        ],
      );
}
