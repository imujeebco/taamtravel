// // ignore_for_file: unused_local_variable, avoid_print

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:jiffy/jiffy.dart';

// import '../custom_widgets/common_text.dart';
// import '../custom_widgets/custom_drop_formfield.dart';
// import '../custom_widgets/logo_loader.dart';
// import '../custom_widgets/nuemorph_container.dart';

// class DateTimeFunctions {
//   // get twelve months date from current date to next 12 months e.g. March 2022 to march 2023
//   static DateTime getTwelveMonthsDateTime(DateTime date) {
//     var month = date.month;
//     var year = date.year;
//     var loopCount = 1;
//     var countThisYear = 0;
//     var countPreviousYear = 0;
//     while (loopCount <= 12) {
//       if (month > 0) {
//         countThisYear += 1;
//         month -= 1;
//         loopCount += 1;
//       } else {
//         countPreviousYear += 1;
//         month -= 1;
//         loopCount += 1;
//       }
//     }
//     if (countPreviousYear != 0) {
//       return DateTime.parse('${date.year - 1}-${getMonthNumber(12 - countPreviousYear)}-01T00:00:00');
//     } else {
//       return DateTime.parse('${date.year}-${getMonthNumber(12 - countThisYear)}-01T00:00:00');
//     }
//   }

//   // Get Month Number (add zero if single digit) -------------------------------
//   static String getMonthNumber(int month) {
//     if (month < 10) {
//       return '0$month';
//     } else {
//       return '$month';
//     }
//   }

//   // Get No Of Months -------------------------------
//   static int getDaysInMonth(DateTime date) {
//     var firstDayThisMonth = DateTime(date.year, date.month, date.day);
//     var firstDayNextMonth = DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, firstDayThisMonth.day);
//     return firstDayNextMonth.difference(firstDayThisMonth).inDays;
//   }

//   // Get Day Number (add zero if single digit) -------------------------------
//   static String getDayNumber(int day) {
//     if (day < 10) {
//       return '0$day';
//     } else {
//       return '$day';
//     }
//   }

// // Formates Date -------------------------------
//   static dateFormat(String date) {
//     // ignore: unnecessary_null_comparison
//     if (date == null || date == '') {
//       return date;
//     } else {
//       String formattedDate = Jiffy.parse(date).format(pattern: 'dd-MM-yyyy');

//       return formattedDate;
//     }
//   }

// // Formates Time -------------------------------
//   static String formatTimeOfDay(String date) {
//     final now = DateTime.parse(date);
//     final dt = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
//     final format = DateFormat.jm(); //"6:00 AM"
//     return format.format(dt);
//   }

// // counts duration  e.g. 02 days 12 hours 23 minutes. -------------------------------
//   static dayHourMinuteFormat(dynamic inputMinutes) {
//     int minutes = inputMinutes.inMinutes;
//     int days = minutes ~/ (24 * 60);
//     int hours = (minutes % (24 * 60)) ~/ 60;
//     int remainingMinutes = minutes % 60;

//     String timeInString = '';

//     if (days > 0) {
//       timeInString += '$days days ';
//     }
//     if (hours > 0) {
//       timeInString += '$hours hours ';
//     }
//     if (remainingMinutes > 0) {
//       timeInString += '$remainingMinutes minutes';
//     }

//     return timeInString;
//   }

// // Finds difference in between two dates e.g. 1Y 11M 12D -------------------------------
//   static String dateTimeDifference(DateTime? from, DateTime? to) {
//     if (from != null && to != null) {
//       DateTime fromTime = DateTime(from.year, from.month, from.day);
//       DateTime toTime = DateTime(to.year, to.month, to.day);
//       int days = (toTime.difference(fromTime).inHours ~/ 24);

//       bool isNegative = days < 0;
//       days = days.abs();
//       String difference = '';

//       int years = (days ~/ 365);
//       days %= 365;
//       int months = (days ~/ 30);
//       days %= 30;

//       if (years > 0) {
//         difference += '${years}Y ';
//       }
//       if (months > 0) {
//         difference += '${months}M ';
//       }
//       if (days > 0) {
//         difference += '${days}D ';
//       }

//       return isNegative ? '-$difference' : difference;
//     }
//     return '';
//   }
// }

// // Date Time Picker Class
// class Pickers {
//   // Custom Date Picker -------------------------------
//   Future<DateTime?> getDatePicker({
//     required DateTime initialDate,
//     required DateTime firstDate,
//     required DateTime lastDate,
//     required BuildContext context,
//     String? helptext,
//   }) async {
//     return await showDatePicker(
//       builder: (context, child) {
//         return Theme(
//           data: context.theme.copyWith(
//             colorScheme: context.theme.colorScheme.copyWith(
//               primary: context.theme.colorScheme.surface,
//               onPrimary: context.theme.colorScheme.onSurface,
//               onSurface: context.theme.colorScheme.onPrimary,
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 backgroundColor: context.theme.colorScheme.onSurface,
//                 foregroundColor: context.theme.colorScheme.surface,
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//       context: Get.context!,
//       initialDate: initialDate,
//       firstDate: firstDate,
//       lastDate: lastDate,
//       helpText: helptext,
//     );
//   }

// // Custom Time Picker -------------------------------
//   static Future<TimeOfDay?> getTimePicker({
//     required BuildContext context,
//     required TimeOfDay initialTime,
//     String? helptext,
//   }) async {
//     var theme = context.theme.colorScheme;
//     return await showTimePicker(
//         context: Get.context!,
//         initialTime: initialTime,
//         initialEntryMode: TimePickerEntryMode.dial,
//         helpText: helptext,
//         builder: (context, child) {
//           return MediaQuery(
//             data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
//             child: Theme(
//               data: context.theme.copyWith(
//                 colorScheme: theme.copyWith(
//                   onSurface: theme.onPrimary,
//                   onPrimary: theme.onPrimary,
//                   primary: theme.tertiary,
//                   surfaceVariant: theme.secondaryContainer,
//                 ),
//                 // textButtonTheme: TextButtonThemeData(
//                 //   style: TextButton.styleFrom(
//                 //     foregroundColor: context.theme.colorScheme.surface,
//                 //   ),
//                 // ),
//               ),
//               child: child!,
//             ),
//           );
//         });
//   }

// // Custom Date Range Picker -------------------------------
//   static Future<DateTimeRange?> getDateRangePicker({
//     DateTimeRange? initialDateRange,
//     required DateTime currentDate,
//     required DateTime firstDate,
//     required DateTime lastDate,
//     required BuildContext context,
//     String? helptext,
//   }) async {
//     return await showDateRangePicker(
//         initialDateRange: initialDateRange,
//         currentDate: currentDate,
//         firstDate: firstDate,
//         lastDate: lastDate,
//         context: Get.context!,
//         helpText: helptext,
//         builder: (context, child) {
//           return Theme(
//             data: context.theme.copyWith(
//               colorScheme: ColorScheme.light(
//                 onPrimary: context.theme.colorScheme.onPrimary, //const Color(0xFF0044b3),
//                 primary: context.theme.colorScheme.secondary, //const Color(0xFF5595ff),
//                 onSurface: context.theme.colorScheme.onPrimary, //const Color(0xFF0044b3),
//                 secondaryContainer:
//                     context.theme.colorScheme.surface, // Get.isDarkMode ? const Color(0x5A000000) : const Color(0xFFE2F0FD), // appColorMain
//               ),
//               textButtonTheme: TextButtonThemeData(
//                 style: TextButton.styleFrom(
//                   foregroundColor: context.theme.colorScheme.surface,
//                 ),
//               ),
//             ),
//             child: child!,
//           );
//         });
//   }
// // Date Stamps and dateType with custom Date Picker if no Stamps founds -------------------------------

//   static Future<Map> dateStamps(
//     BuildContext context, {
//     bool isDateType = false,
//     bool isFilterDatesLoading = false,
//     var dateFiltersList,
//     dynamic dateTypeList,
//     String? dateTypeName,
//     String? dateTypeId,
//     dynamic selectedDateRange,
//     DateTime? start,
//     DateTime? end,
//   }) async {
//     if (dateFiltersList.isNotEmpty) {
//       try {
//         await Get.dialog(Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 50.0),
//           child: Dialog(
//             elevation: 0.0,
//             backgroundColor: Colors.transparent,
//             child: isFilterDatesLoading == true
//                 ? LogoLoader()
//                 : dateFiltersList.isEmpty
//                     ? const Center(
//                         child: Text('No data'),
//                       )
//                     : Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Date Type -----------------------------
//                           !isDateType
//                               ? const SizedBox.shrink()
//                               : Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Date Type',
//                                       style: TextStyle(
//                                           color: Get.theme.colorScheme.primary, fontSize: 12.0, fontWeight: AppFontWeights.appTextFontWeightMedium),
//                                     ),
//                                     Container(
//                                       height: 35,
//                                       margin: const EdgeInsets.symmetric(vertical: 8.0),
//                                       child: CustomDropDownFormField(
//                                         value: dateTypeId ?? 'DataEntryDate',
//                                         text: '',
//                                         hintText: '',
//                                         items: dateTypeList.map<DropdownMenuItem<String>>((form) {
//                                           return DropdownMenuItem<String>(
//                                             onTap: () {
//                                               dateTypeId = form["Id"].toString();
//                                               dateTypeName = form['Name'].toString();
//                                               // update();
//                                               // print(dateTypeId);
//                                               // print(dateTypeName);
//                                             },
//                                             value: form['Id'],
//                                             child: Text(
//                                               form['Name'],
//                                               style: TextStyle(color: Get.theme.colorScheme.onSecondary),
//                                             ),
//                                           );
//                                         }).toList(),
//                                         onChanged: (value) {
//                                           dateTypeId = value.toString();
//                                           // update();
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                           const SizedBox(height: 12),
//                           Text(
//                             'Date Stamps',
//                             style:
//                                 TextStyle(color: Get.theme.colorScheme.primary, fontSize: 12.0, fontWeight: AppFontWeights.appTextFontWeightMedium),
//                           ),

//                           // DATE STAMPS -----------------------------
//                           ListView.builder(
//                             padding: EdgeInsets.zero,
//                             shrinkWrap: true,
//                             itemCount: dateFiltersList.length + 1,
//                             itemBuilder: (context, i) {
//                               return i == dateFiltersList.length
//                                   // FOR CUSTOM  ====================
//                                   ? InkWell(
//                                       onTap: () async {
//                                         // Get.back();
//                                         var myMap = await customDateRangePicker(context, selectedDateRange, start, end);

//                                         start = myMap['start'];
//                                         end = myMap['end'];
//                                         selectedDateRange = myMap['selectedDateRange'];

//                                         Get.back();
//                                       },
//                                       child: NuemorphContainer(
//                                           isShadow: false,
//                                           margin: const EdgeInsets.symmetric(vertical: 4.0),
//                                           height: 30,
//                                           isGradient: false,
//                                           child: const Center(
//                                               child: CommonText(
//                                             text: 'Custom',
//                                             fontSize: 16.0,
//                                             weight: AppFontWeights.appTextFontWeightExtraLight,
//                                           ))),
//                                     )
//                                   // FOR LIST  ====================
//                                   : InkWell(
//                                       onTap: () {
//                                         start = DateTime.parse(Jiffy.parse(dateFiltersList[i]['FromDate'].toString()).format(pattern: 'yyyy-MM-dd'));
//                                         end = DateTime.parse(
//                                             Jiffy.parse(dateFiltersList[i]['ToDate'].toString()).format(pattern: 'yyyy-MM-dd 23:59:59'));
//                                         // update();

//                                         selectedDateRange = DateTimeRange(start: start!, end: end!);
//                                         print('MY DATES  ============ $start ** $end');

//                                         Get.back();
//                                       },
//                                       child: NuemorphContainer(
//                                           isShadow: false,
//                                           margin: const EdgeInsets.symmetric(vertical: 4.0),
//                                           height: 30,
//                                           isGradient: false,
//                                           child: Center(
//                                               child: CommonText(
//                                             text: dateFiltersList[i]['Period'],
//                                             fontSize: 16.0,
//                                             weight: AppFontWeights.appTextFontWeightExtraLight,
//                                           ))),
//                                     );
//                             },
//                           ),
//                         ],
//                       ),
//           ),
//         ));

//         return isDateType
//             ? {
//                 'dateTypeId': dateTypeId,
//                 'dateTypeName': dateTypeName,
//                 'start': start,
//                 'end': end,
//                 'selectedDateRange': selectedDateRange,
//               }
//             : {
//                 'start': start,
//                 'end': end,
//                 'selectedDateRange': selectedDateRange,
//               };
//       } catch (e) {
//         Get.back();
//         print(e);
//         return isDateType
//             ? {
//                 'dateTypeId': dateTypeId,
//                 'dateTypeName': dateTypeName,
//                 'start': start,
//                 'end': end,
//                 'selectedDateRange': selectedDateRange,
//               }
//             : {
//                 'start': start,
//                 'end': end,
//                 'selectedDateRange': selectedDateRange,
//               };
//       }
//     } else {
//       var myMap = await customDateRangePicker(context, selectedDateRange, start, end);
//       return isDateType
//           ? {
//               'dateTypeId': dateTypeId,
//               'dateTypeName': dateTypeName,
//               'start': myMap['start'],
//               'end': myMap['end'],
//               'selectedDateRange': myMap['selectedDateRange'],
//             }
//           : {
//               'start': myMap['start'],
//               'end': myMap['end'],
//               'selectedDateRange': myMap['selectedDateRange'],
//             };
//     }
//   }

// // Custom Date Range Picker return values as Map -------------------------------
//   static Future<Map> customDateRangePicker(BuildContext context, selectedDateRange, start, end) async {
//     DateTimeRange? selectedRange = await getDateRangePicker(
//         initialDateRange: selectedDateRange,
//         currentDate: DateTime.now(),
//         firstDate: DateTime(1990, 1),
//         lastDate: DateTime(2090, 12),
//         context: context,
//         helptext: 'Select Range');

//     if (selectedRange != null) {
//       start = DateTime.parse(Jiffy.parse(selectedRange.start.toString()).format(pattern: 'yyyy-MM-dd'));
//       end = DateTime.parse(Jiffy.parse(selectedRange.end.toString()).format(pattern: 'yyyy-MM-dd 23:59:59'));
//       selectedDateRange = DateTimeRange(start: selectedRange.start, end: selectedRange.end);
//     }
//     return {
//       'start': start,
//       'end': end,
//       'selectedDateRange': selectedDateRange,
//     };
//   }
// }
