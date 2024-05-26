// ignore_for_file: unnecessary_question_mark

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/data/data_controller.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/presentation/home_bottom_nav/nav_tabs/components/search_tabs/multi_city_flights/controller/multi_city_fare_rule_controller.dart';

import '../../../../../../../app/utils/custom_widgets/custom_outline_button.dart';
import '../../../../../model/flight_quote_model.dart';
import 'multi_city_passenger_details_screen.dart';

// ignore: must_be_immutable
class MultiCItyFareDetailsScreen extends StatefulWidget {
  dynamic cityList;
  dynamic flightsMap;
  /*
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
  */
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

  MultiCItyFareDetailsScreen({
    super.key,
    /*
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
    */
    required this.cityList,
    this.flightsMap,
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
  State<MultiCItyFareDetailsScreen> createState() =>
      _MultiCItyFareDetailsScreenState();
}

class _MultiCItyFareDetailsScreenState
    extends State<MultiCItyFareDetailsScreen> {
  final DataController dataController = Get.put(DataController());
  final MultiCityFlightFareRuleController flightFareRuleController =
      Get.put(MultiCityFlightFareRuleController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dataController.loadMyData();
      flightFareRuleController.fetchFareRule(widget.flightsMap);
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
      body: Stack(
        children: [
          Padding(
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
                        .multiCityFlightFareRuleModel.value.flights!.isEmpty) {
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
                          .multiCityFlightFareRuleModel.value.flights;
                      return Expanded(
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: data1?.length,
                              itemBuilder: (context, index) {
                                var item = data1![index];
                                // Map<String, dynamic> item =
                                //     data1![index] as Map<String, dynamic>;
                                return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FlightPackageWidget(
                                        name: 'Saver',
                                        total: item?.totalAmount,
                                        tax: item?.taxesAmount,
                                        ticket: item?.ticketAmount,
                                        /*
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
                                    */

                                        child1age: widget.child1age ?? 1,
                                        child2age: widget.child2age ?? 1,
                                        child3age: widget.child3age ?? 1,
                                        child4age: widget.child4age ?? 1,
                                        //
                                        infant1age: widget.infant1age ?? 1,
                                        infant2age: widget.infant2age ?? 1,
                                        infant3age: widget.infant3age ?? 1,
                                        infant4age: widget.infant4age ?? 1,
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
          Positioned(
            bottom: 1,
            child: Container(
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomOutlineButton(
                        color: Colors.white,
                        width: 150,
                        text: "Cancel",
                        onPress: () {
                          Get.back();
                        }),
                    SizedBox(width: 15),
                    CustomButton(
                      width: 150,
                      text: "Next",
                      onPress: () {
                        var flightFareDetailsList = [];
                        flightFareRuleController
                            .multiCityFlightFareRuleModel.value.flights!
                            .forEach((elem) {
                          flightFareDetailsList.add({
                            'ticketAmount': elem?.ticketAmount,
                            'taxAmount': elem?.taxesAmount,
                            'totalAmount': elem?.totalAmount,
                          });
                        });
                        Get.to(() => MultiCityPassengerDetailsScreen(
                              cityList: widget.cityList,
                              flightsMap: widget.flightsMap,
                              flightFareDetailsList: flightFareDetailsList,
                              /*
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
                              */
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
                            ));
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

///////////////////////////// FlightPackageWidget /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
// ignore: must_be_immutable
class FlightPackageWidget extends StatefulWidget {
  String name;
  dynamic ticket = 0;
  dynamic tax = 0;
  dynamic total = 0;
  // Map<String, dynamic> item;
  /*
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
  */
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
    this.ticket,
    this.tax,
    this.total,
    // required this.item,
    /*
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
    */
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
    // int total = widget.item?.ticketAmount + widget.item?.taxesAmount;

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
                  text: '${widget.name} ',
                  // \$${total.toStringAsFixed(2) ?? 1}',
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
                  text: '\$${widget.ticket.toStringAsFixed(2) ?? 1}',
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
                  text: '\$${widget.tax.toStringAsFixed(2) ?? 1}',
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
                  text: '\$${widget.total.toStringAsFixed(2) ?? '-'}',
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
          ],
        ),
      ),
    );
  }
}
