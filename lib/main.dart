import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/airline/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Taam Travel',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 800),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.appColorAccent,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.appColorPrimary),
        useMaterial3: true,
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: AppColors.appColorAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      // home: LoginScreen(),
      home: SplashScreen(),
    );
  }
}
