import "dart:async";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:travel_app/app/configs/app_colors.dart";
import "package:travel_app/presentation/splash_screen/onboard_screen.dart";

import "../../app/data/data_controller.dart";
import "../auth/view/login_screen.dart";
import "../home_bottom_nav/bnb/bottom_nav_view.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final DataController dataController = Get.put(DataController());
  bool? isOnboarded;

  Future<void> checkLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isOnboarded = prefs.getBool('isOnboardedStatus') ?? false;
    });
    print("SplashPage Onboard Status: $isOnboarded");
  }

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
  }

  @override
  void initState() {
    super.initState();
    checkLoggedInStatus();
    loadGetxData();
    Timer(Duration(seconds: 3), () {
      if (isOnboarded == true) {
        print("Going to App");
        Get.to(() => BottomNavScreen());
        // if (dataController.myLoggedIn.value == true) {
        //   print("Going to App");
        //   Get.to(() => BottomNavScreen());
        // } else {
        //   print("Going to Login");
        //   Get.to(() => LoginScreen());
        // }
      } else {
        print("Staying on OnBoard");
        Get.to(() => OnBoardingScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColorSplashBG,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 150,
                width: 150,
                // decoration: BoxDecoration(
                //     shape: BoxShape.circle, color: Colors.white),
                child: Image(
                    image: AssetImage("assets/icons/logo.png"),
                    fit: BoxFit.contain)),
          ],
        ),
      ),
    );
  }
}
