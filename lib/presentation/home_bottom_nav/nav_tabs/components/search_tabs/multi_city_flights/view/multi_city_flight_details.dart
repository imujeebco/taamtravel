// ignore_for_file: unnecessary_question_mark

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/presentation/auth/view/login_screen.dart';
import 'package:travel_app/presentation/home_bottom_nav/controller/flight_fare_rule_controller.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/passenger_details.dart';

import '../../../../../../../app/data/data_controller.dart';
import '../../../../../../../app/utils/custom_functions/app_alerts.dart';

// ignore: must_be_immutable
class MultiCityFlightDetailScreen extends StatefulWidget {
  String searchID;
  String flightID;
  String cabinClass;
  String traveller;
  int? adultCount;
  int? childCount;
  int? infantCount;
  //
  String departFromDate1;
  String departFromTime1;
  String departFromCode1;
  String departFlight;
  String arriveToDate1;
  String arriveToTime1;
  String arriveToCode1;
  //
  String arriveFlight;
  String departFromDate2;
  String departFromTime2;
  String departFromCode2;
  String arriveToDate2;
  String arriveToTime2;
  String arriveToCode2;
  //
  int? child1age;
  int? child2age;
  int? child3age;
  int? child4age;
  //
  int? infant1age;
  int? infant2age;
  int? infant3age;
  int? infant4age;
  //

  MultiCityFlightDetailScreen({
    super.key,
    required this.searchID,
    required this.flightID,
    required this.cabinClass,
    required this.traveller,
    required this.adultCount,
    required this.childCount,
    required this.infantCount,
    //
    required this.departFlight,
    required this.departFromDate1,
    required this.departFromTime1,
    required this.departFromCode1,
    required this.arriveToDate1,
    required this.arriveToTime1,
    required this.arriveToCode1,
    //
    required this.arriveFlight,
    required this.departFromDate2,
    required this.departFromTime2,
    required this.departFromCode2,
    required this.arriveToDate2,
    required this.arriveToTime2,
    required this.arriveToCode2,
    //
    required this.child1age,
    required this.child2age,
    required this.child3age,
    required this.child4age,
    //
    required this.infant1age,
    required this.infant2age,
    required this.infant3age,
    required this.infant4age,
    //
  });

  @override
  State<MultiCityFlightDetailScreen> createState() =>
      _MultiCityFlightDetailScreenState();
}

class _MultiCityFlightDetailScreenState
    extends State<MultiCityFlightDetailScreen> {
  final DataController dataController = Get.put(DataController());
  final FlightFareRuleController flightFareRuleController =
      Get.put(FlightFareRuleController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dataController.loadMyData();
      flightFareRuleController.fetchFareRule(widget.searchID, widget.flightID);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Flight Details',
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ---------------------------
            // Text(widget.flightID.toString()),
            // Text(widget.searchID.toString()),
            Obx(() {
              if (flightFareRuleController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (flightFareRuleController
                    .flightFareRuleControllerModel.value.flights!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning_rounded,
                          size: 88,
                          color: Colors.grey,
                        ),
                        Text("No Data Found",
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 24,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  );
                } else {
                  var data1 = flightFareRuleController
                      .flightFareRuleControllerModel.value.flights;
                  return Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: data1!.length,
                          itemBuilder: (context, index) {
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FlightPackageWidget(
                                    name: 'Saver',
                                    traveller: widget.traveller,
                                    cabinClass: widget.cabinClass,
                                    charges: data1[index]!.totalAmount,
                                    tax: data1[index]!.taxesAmount,
                                    searchID: widget.searchID,
                                    flightID: widget.flightID,
                                    departFlight: widget.departFlight,
                                    arriveFlight: widget.arriveFlight,
                                    departFromDate1: widget.departFromDate1,
                                    departFromTime1: widget.departFromTime1,
                                    departFromCode1: widget.departFromCode1,
                                    departFromDate2: widget.departFromDate2,
                                    departFromTime2: widget.departFromTime2,
                                    departFromCode2: widget.departFromCode2,
                                    arriveToDate1: widget.arriveToDate1,
                                    arriveToTime1: widget.arriveToTime1,
                                    arriveToCode1: widget.arriveToCode1,
                                    arriveToDate2: widget.arriveToDate2,
                                    arriveToCode2: widget.arriveToCode2,
                                    arriveToTime2: widget.arriveToTime2,
                                    adultCount: widget.adultCount,
                                    childCount: widget.childCount,
                                    infantCount: widget.infantCount,
                                    //
                                    child1age: widget.child1age,
                                    child2age: widget.child2age,
                                    child3age: widget.child3age,
                                    child4age: widget.child4age,
                                    //
                                    infant1age: widget.infant1age,
                                    infant2age: widget.infant2age,
                                    infant3age: widget.infant3age,
                                    infant4age: widget.infant4age,
                                    //
                                  ),
                                ]);
                          }));
                }
              }
            }),
            // FlightPackageWidget(name: 'Saver',),
          ],
        ),
      ),
    );
  }
}

///////////////////////////// FlightPackageWidget /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
// ignore: must_be_immutable
class FlightPackageWidget extends StatefulWidget {
  dynamic? charges;
  dynamic? tax;
  String searchID;
  String flightID;
  String traveller;
  int? adultCount;
  int? childCount;
  int? infantCount;
  String cabinClass;
//
  String departFromDate1;
  String departFromTime1;
  String departFromCode1;
  String departFlight;
  String arriveToDate1;
  String arriveToTime1;
  String arriveToCode1;
  //
  String arriveFlight;
  String departFromDate2;
  String departFromTime2;
  String departFromCode2;
  String arriveToDate2;
  String arriveToTime2;
  String arriveToCode2;
  //
  int? child1age;
  int? child2age;
  int? child3age;
  int? child4age;
  //
  int? infant1age;
  int? infant2age;
  int? infant3age;
  int? infant4age;
  //

  FlightPackageWidget({
    required this.name,
    this.charges,
    this.tax,
    required this.traveller,
    required this.adultCount,
    required this.childCount,
    required this.infantCount,
    required this.cabinClass,
    required this.searchID,
    required this.flightID,
    required this.departFlight,
    required this.departFromDate1,
    required this.departFromTime1,
    required this.departFromCode1,
    required this.arriveToDate1,
    required this.arriveToTime1,
    required this.arriveToCode1,
    required this.arriveFlight,
    required this.departFromDate2,
    required this.departFromTime2,
    required this.departFromCode2,
    required this.arriveToDate2,
    required this.arriveToTime2,
    required this.arriveToCode2,
    //
    required this.child1age,
    required this.child2age,
    required this.child3age,
    required this.child4age,
    //
    required this.infant1age,
    required this.infant2age,
    required this.infant3age,
    required this.infant4age,
    //
    super.key,
  });

  final String name;

  @override
  State<FlightPackageWidget> createState() => _FlightPackageWidgetState();
}

class _FlightPackageWidgetState extends State<FlightPackageWidget> {
  final DataController dataController = Get.put(DataController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dataController.loadMyData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic? total = widget.charges + widget.tax!;

    return DottedBorder(
      dashPattern: [10, 8],
      strokeWidth: 1,
      color: AppColors.appColorPrimary,
      child: Container(
        padding: EdgeInsets.fromLTRB(10.0, 10, 10, 10),
        margin: const EdgeInsets.fromLTRB(10.0, 10, 10, 10.0),
        // height: h * 0.43,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1st ------------------------------------------
            // 0.01.ph,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: '${widget.name} \$${total.toStringAsFixed(2)}',
                  weight: FontWeight.bold,
                  fontSize: 20.0,
                  color: AppColors.appColorPrimary,
                ),
                Radio(
                  value: true,
                  groupValue: true,
                  onChanged: (_) {},
                  activeColor: AppColors.appColorPrimary,
                )
              ],
            ),

            // -----------------------------
            0.02.ph,
            CommonText(
              text: 'Checked baggage',
              fontSize: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: '25 kg',
                  fontSize: 11,
                  weight: FontWeight.w600,
                ),
                // Icon(
                //   Icons.info,
                //   size: 20,
                // ),
              ],
            ),
            0.02.ph,
// -----------------------------------------------------

            CommonText(
              text: 'Cabin baggage',
              fontSize: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: '2 x 7 kg',
                  fontSize: 11,
                  weight: FontWeight.w600,
                ),
                // Icon(
                //   Icons.info,
                //   size: 20,
                // ),
              ],
            ),
            0.02.ph,
// -----------------------------------------------------

            // CommonText(
            //   text: 'Change Fee',
            //   fontSize: 11,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     CommonText(
            //       text: 'Not Available',
            //       fontSize: 11,
            //       weight: FontWeight.w600,
            //     ),
            //     // Icon(
            //     //   Icons.info,
            //     //   size: 20,
            //     // ),
            //   ],
            // ),
            // 0.02.ph,
// -----------------------------------------------------
            // CommonText(
            //   text: 'Refund Fee',
            //   fontSize: 11,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     CommonText(
            //       text: '\$ Not Available',
            //       fontSize: 11,
            //       weight: FontWeight.w600,
            //     ),
            //     // Icon(
            //     //   Icons.info,
            //     //   size: 20,
            //     // ),
            //   ],
            // ),
            // 0.02.ph,
            //---------------------------------------
            // CommonText(
            //   text: 'Seat Selection',
            //   fontSize: 11,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     CommonText(
            //       text: 'Not Available',
            //       fontSize: 11,
            //       weight: FontWeight.w600,
            //     ),
            //     // Icon(
            //     //   Icons.info,
            //     //   size: 20,
            //     // ),
            //   ],
            // ),
            // 0.02.ph,
// -----------------------------------------------------
            // -----------------------------------------------------
            // CommonText(
            //   text: 'Upgrade to Business',
            //   fontSize: 11,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     CommonText(
            //       text: 'Not Available',
            //       fontSize: 11,
            //       weight: FontWeight.w600,
            //     ),
            //   ],
            // ),

            // 0.04.ph,
// -----------------------------------------------------
            // -----------------------------------------------------
            Divider(),
            CommonText(
              text: 'Ticket Charges',
              fontSize: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: '\$${widget.charges.toStringAsFixed(2)}',
                  fontSize: 11,
                  weight: FontWeight.w600,
                ),
              ],
            ),

            0.02.ph,
// -----------------------------------------------------
            // -----------------------------------------------------
            CommonText(
              text: 'Total Tax',
              fontSize: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: '\$${widget.tax.toStringAsFixed(2)}',
                  fontSize: 11,
                  weight: FontWeight.w600,
                ),
              ],
            ),

            0.02.ph, Divider(),
// -----------------------------------------------------
            // -----------------------------------------------------
            CommonText(
              text: 'Gross Total',
              fontSize: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: '\$${total.toStringAsFixed(2)}',
                  fontSize: 11,
                  weight: FontWeight.w600,
                ),
                // Icon(
                //   Icons.info,
                //   size: 20,
                // ),
              ],
            ),
            0.02.ph,
            Divider(),
            0.02.ph,
// -----------------------------------------------------

            CustomButton(
                height: 35,
                width: w,
                // text: 'Avail this Flight for \$${total.toStringAsFixed(2)}',
                text: "Book",
                onPress: () {
                  // Get.to(() => PaymentMethodScreen(
                  dataController.myLoggedIn.value
                      ? Get.to(() => PassengerDetailsScreen(
                            fare: widget.charges.toStringAsFixed(2),
                            tax: widget.tax.toStringAsFixed(2),
                            total: total.toStringAsFixed(2),
                            traveller: widget.traveller,
                            cabinClass: widget.cabinClass,
                            searchID: widget.searchID,
                            flightID: widget.flightID,
                            departFlight: widget.departFlight,
                            arriveFlight: widget.arriveFlight,
                            departFromDate1: widget.departFromDate1,
                            departFromTime1: widget.departFromTime1,
                            departFromCode1: widget.departFromCode1,
                            departFromDate2: widget.departFromDate2,
                            departFromTime2: widget.departFromTime2,
                            departFromCode2: widget.departFromCode2,
                            arriveToDate1: widget.arriveToDate1,
                            arriveToTime1: widget.arriveToTime1,
                            arriveToCode1: widget.arriveToCode1,
                            arriveToDate2: widget.arriveToDate2,
                            arriveToCode2: widget.arriveToCode2,
                            arriveToTime2: widget.arriveToTime2,
                            paymentID: '',
                            adultCount: widget.adultCount,
                            childCount: widget.childCount,
                            infantCount: widget.infantCount,
                            //
                            child1age: widget.child1age,
                            child2age: widget.child2age,
                            child3age: widget.child3age,
                            child4age: widget.child4age,
                            //
                            infant1age: widget.infant1age,
                            infant2age: widget.infant2age,
                            infant3age: widget.infant3age,
                            infant4age: widget.infant4age,
                            //
                          ))
                      : Dialogs.showCustomAlertDialog(context,
                          "Please Login\n\nLogin required for flight booking",
                          () {
                          Get.offAll(() => LoginScreen());
                        }, () {
                          Get.back();
                        });
                  // Get.to(() => PassengerDetailsScreen(
                  //       fare: widget.charges.toString(),
                  //       tax: widget.tax.toString(),
                  //       total: total.toStringAsFixed(2),
                  //       traveller: widget.traveller,
                  //       cabinClass: widget.cabinClass,
                  //       searchID: widget.searchID,
                  //       flightID: widget.flightID,
                  //       departFlight: widget.departFlight,
                  //       arriveFlight: widget.arriveFlight,
                  //       departFromDate1: widget.departFromDate1,
                  //       departFromTime1: widget.departFromTime1,
                  //       departFromCode1: widget.departFromCode1,
                  //       departFromDate2: widget.departFromDate2,
                  //       departFromTime2: widget.departFromTime2,
                  //       departFromCode2: widget.departFromCode2,
                  //       arriveToDate1: widget.arriveToDate1,
                  //       arriveToTime1: widget.arriveToTime1,
                  //       arriveToCode1: widget.arriveToCode1,
                  //       arriveToDate2: widget.arriveToDate2,
                  //       arriveToCode2: widget.arriveToCode2,
                  //       arriveToTime2: widget.arriveToTime2,
                  //     ));
                }),
          ],
        ),
      ),
    );
  }
}
