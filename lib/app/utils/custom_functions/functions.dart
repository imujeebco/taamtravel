// ignore_for_file: prefer_if_null_operators, use_build_context_synchronously, unused_local_variable, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../custom_widgets/pop_up_dialog.dart';

// few cutom functions
class Functions {
  // Open Map Function
  static Future<void> openGoogleMap(BuildContext context, String url) async {
    String googleUrl = url;
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(
        googleUrl,
        mode: LaunchMode.externalApplication,
      );
    } else {
      Functions.ShowPopUpDialog(
        context,
        'Error In Location',
        Icon(
          Icons.error_outline_sharp,
          color: Get.theme.colorScheme.onPrimary,
          size: 80,
        ),
        () => {},
        false,
        isHeader: true,
        isCloseBtn: true,
      );
    }
  }

  // Scale Factor Calculator
  static double getScaleFactor(Size size) {
    if (size.width > 400 && size.width <= 450) {
      return 1.0;
    } else if (size.width > 350 && size.width <= 400) {
      return 0.90;
    } else if (size.width > 300 && size.width <= 350) {
      return 0.80;
    } else if (size.width > 250 && size.width <= 300) {
      return 0.70;
    } else if (size.width > 200 && size.width <= 250) {
      return 0.60;
    } else {
      return 0.50;
    }
  }

  // Phone Dialer
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  // Scrolling to a Expansion Key Tile
  static void scrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext, duration: const Duration(milliseconds: 200));
      });
    }
  }

  // Get Keys Present in a Map in List
  static List<dynamic> getKeysInList(data) {
    var keysPresent = [];
    for (int i = 0; i < data.length; i++) {
      data[i].keys.forEach((key) {
        keysPresent.add(key);
      });
    }
    return keysPresent;
  }

  // Get Grouped By Map
  static dynamic getGroupedByMap(data, String keyToGroup) {
    List result = data
        .fold({}, (previousValue, element) {
          Map val = previousValue as Map;
          String date = element[keyToGroup];
          if (!val.containsKey(date)) {
            val[date] = [];
          }
          val[date]?.add(element);
          return val;
        })
        .entries
        .map((e) => {e.key: e.value})
        .toList();

    return result;
  }

// Custom Pop up Dialog
  static ShowPopUpDialog(BuildContext context, String title, Widget content, VoidCallback onPressYes, bool isAction,
      {required bool isCloseBtn, required bool isHeader, VoidCallback? onPressBack, bool? isCancel}) {
    showDialog(
        context: context,
        builder: (_) => PopUpDialog(
              title: title,
              content: content,
              onPressYes: onPressYes,
              isAction: isAction,
              isCancel: isCancel,
              isCloseBtn: isCloseBtn,
              isHeader: isHeader,
            ),
        barrierDismissible: true);
  }

//convert minutes to hour and minutes   e.g. inputMinutes = 322 => 5H, 22M;

  static List doubleMinuteToHourMinute(int inputMinutes) {
    int hour = 0;
    int minute = 0;

    double time = inputMinutes / 60;
    String str = time.toString();
    if (str.contains('.')) {
      var arrTime = str.split('.');
      hour = int.parse(arrTime[0]);
      minute = (double.parse('0.${arrTime[1]}') * 60).round();
    } else {
      hour = (inputMinutes / 60).round();
    }

    return [hour, minute];
  }

  static String NullAlternateValue(dynamic obj) {
    return obj == null ? '' : obj;
  }

  // Sets the Same Brightness as our default theme while new theme Generation ------------
  static Color adjustColorBrightness(String? hexColor, double targetBrightness) {
    Color color = checkColorCode(hexColor);

    try {
      HSLColor hsl = HSLColor.fromColor(color);
      int maxIterations = 100; // Maximum iterations to avoid infinite loop
      double currentBrightness = color.computeLuminance();

      for (int i = 0; i < maxIterations; i++) {
        double lightnessDelta = targetBrightness - currentBrightness;
        hsl = hsl.withLightness((hsl.lightness + lightnessDelta).clamp(0.0, 1.0));
        currentBrightness = hsl.toColor().computeLuminance();

        if ((currentBrightness - targetBrightness).abs() < 0.01) {
          break; // Break the loop if the brightness is close enough to target
        }
      }

      return hsl.toColor();
    } catch (e) {
      print(e);
      return color;
    }
  }

  // static Color adjustColorBrightness(String? hexColor, double targetBrightness) {
  //   Color color = checkColorCode(hexColor);
  //   try {
  //     HSLColor hsl = HSLColor.fromColor(color);
  //     double delta = 0.01; // Increment for adjusting lightness
  //     double currentBrightness = color.computeLuminance();

  //     while ((currentBrightness - targetBrightness).abs() > delta) {
  //       if (currentBrightness < targetBrightness) {
  //         hsl = hsl.withLightness((hsl.lightness + delta).clamp(0.0, 1.0));
  //       } else {
  //         hsl = hsl.withLightness((hsl.lightness - delta).clamp(0.0, 1.0));
  //       }
  //       currentBrightness = hsl.toColor().computeLuminance();
  //       // break;
  //     }

  //     var newColor = hsl.toColor();
  //     return newColor;
  //   } catch (e) {
  //     print(e);
  //     return color;
  //   }

  //   // print('NEW COLOR : $newColor');
  //   // print('NEW LUMINANCE : ${newColor.computeLuminance()}');
  // }

  //  It checks the validity of color codes & can make Lighter and darker shades
  static checkColorCode(String? hexColor, {double amount = 0.0}) {
    try {
      // if (hexColor != null) {
      hexColor = hexColor!.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF$hexColor";
      }

      Color color = Color(int.parse(hexColor, radix: 16));

      // Lighten or darken the color if amount is provided
      if (amount != 0) {
        final double luminance = color.computeLuminance();

        if (amount > 0) {
          // Lighten the color
          color = HSLColor.fromColor(color)
              .withLightness(
                (luminance + 0.05 * amount).clamp(0.0, 1.0),
              )
              .toColor();
        } else {
          // Darken the color
          color = HSLColor.fromColor(color)
              .withLightness(
                (luminance + 0.05 * amount).clamp(0.0, 1.0),
              )
              .toColor();
        }
      }

      return color;
      // } else {
      //   if (amount > 0) {
      //     // Lighten the default color
      //     return HSLColor.fromColor(Color(int.parse('FF00b3f0', radix: 16))).withLightness((0.5 + 0.05 * amount).clamp(0.0, 1.0)).toColor();
      //   } else {
      //     // Darken the default color
      //     return HSLColor.fromColor(Color(int.parse('FF00b3f0', radix: 16))).withLightness((0.5 + 0.05 * amount).clamp(0.0, 1.0)).toColor();
      //   }
      // }
    } catch (e) {
      print(e);
      if (amount > 0) {
        // Lighten the default color
        return HSLColor.fromColor(Color(int.parse('FF00b3f0', radix: 16))).withLightness((0.5 + 0.05 * amount).clamp(0.0, 1.0)).toColor();
      } else {
        // Darken the default color
        return HSLColor.fromColor(Color(int.parse('FF00b3f0', radix: 16))).withLightness((0.5 + 0.05 * amount).clamp(0.0, 1.0)).toColor();
      }
    }
  }

// URL Launcher
  static Future<void> launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      print('LAUNCHING URL !!!!');
      launchUrl(Uri.parse(url));
    } else {
      print('!!!! NOT LAUNCHING URL !!!!');

      throw 'Could not launch $url';
    }
  }

// A dynamic null checker function which can give ur given output and results ifNull found!.

  static dynamic nullSwitch(dynamic input, {dynamic output, dynamic ifNull = ''}) {
    try {
      print(input.runtimeType.toString());
      if (input != null) {
        if (input is int || input is double) {
          print(output ?? input);
          return output ?? input;
        } else {
          if (input.isEmpty) {
            print("L/M NULL :  $ifNull");
            return ifNull;
          } else {
            print(output ?? input);
            return output ?? input;
          }
        }
      } else {
        print("ANY NULL :  $ifNull");
        return ifNull;
      }
    } catch (e) {
      print('ERROR : $e');
      return ifNull;
    }
  }
}
