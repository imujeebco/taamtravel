// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_outline_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield_required.dart';
import '../controller/flight_booking_controller.dart';

class PaymentDetailsScreen extends StatefulWidget {
  String searchID;
  String flightID;
  String paymentID;
  //
  String title;
  String firstName;
  String lastName;
  String dob;
  String nationality;
  String passNumber;
  String passExp;
  String email;
  String phone;
  String phoneCode;
  String countryCode;
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
  String traveller;
  int? adultCount;
  int? childCount;
  int? infantCount;
  String cabinClass;
  String fare;
  String tax;
  String total;
  //
  String adult2name;
  String adult2Lname;
  String adult2dob;
  String adult2pass;
  String adult2passExp;
  String adult3name;
  String adult3Lname;
  String adult3dob;
  String adult3pass;
  String adult3passExp;
  String adult4name;
  String adult4Lname;
  String adult4dob;
  String adult4pass;
  String adult4passExp;
  //
  String child1name;
  String child1Lname;
  String child1dob;
  String child1pass;
  String child1passExp;
  String child2name;
  String child2Lname;
  String child2dob;
  String child2pass;
  String child2passExp;
  String child3name;
  String child3Lname;
  String child3dob;
  String child3pass;
  String child3passExp;
  String child4name;
  String child4Lname;
  String child4dob;
  String child4pass;
  String child4passExp;
  //
  String infant1name;
  String infant1Lname;
  String infant1dob;
  String infant1pass;
  String infant1passExp;
  String infant2name;
  String infant2Lname;
  String infant2dob;
  String infant2pass;
  String infant2passExp;
  String infant3name;
  String infant3Lname;
  String infant3dob;
  String infant3pass;
  String infant3passExp;
  String infant4name;
  String infant4Lname;
  String infant4dob;
  String infant4pass;
  String infant4passExp;
//
  PaymentDetailsScreen({
    super.key,
    required this.searchID,
    required this.flightID,
    required this.paymentID,
    //
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.nationality,
    required this.passNumber,
    required this.passExp,
    required this.email,
    required this.phone,
    required this.phoneCode,
    required this.countryCode,
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
    required this.traveller,
    required this.adultCount,
    required this.childCount,
    required this.infantCount,
    required this.cabinClass,
    required this.fare,
    required this.tax,
    required this.total,
    //
    required this.adult2name,
    required this.adult2Lname,
    required this.adult2dob,
    required this.adult2pass,
    required this.adult2passExp,
    required this.adult3name,
    required this.adult3Lname,
    required this.adult3dob,
    required this.adult3pass,
    required this.adult3passExp,
    required this.adult4name,
    required this.adult4Lname,
    required this.adult4dob,
    required this.adult4pass,
    required this.adult4passExp,
    //
    required this.child1name,
    required this.child1Lname,
    required this.child1dob,
    required this.child1pass,
    required this.child1passExp,
    required this.child2name,
    required this.child2Lname,
    required this.child2dob,
    required this.child2pass,
    required this.child2passExp,
    required this.child3name,
    required this.child3Lname,
    required this.child3dob,
    required this.child3pass,
    required this.child3passExp,
    required this.child4name,
    required this.child4Lname,
    required this.child4dob,
    required this.child4pass,
    required this.child4passExp,
    //
    required this.infant1name,
    required this.infant1Lname,
    required this.infant1dob,
    required this.infant1pass,
    required this.infant1passExp,
    required this.infant2name,
    required this.infant2Lname,
    required this.infant2dob,
    required this.infant2pass,
    required this.infant2passExp,
    required this.infant3name,
    required this.infant3Lname,
    required this.infant3dob,
    required this.infant3pass,
    required this.infant3passExp,
    required this.infant4name,
    required this.infant4Lname,
    required this.infant4dob,
    required this.infant4pass,
    required this.infant4passExp,
    //
  });

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  TextEditingController cardController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  final FlightBookingController flightBookingController =
      Get.put(FlightBookingController());

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Payment Details',
      ),
      body: Obx(() {
        return flightBookingController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                              text: 'Card Details',
                              weight: FontWeight.w600,
                              fontSize: 18.0),
                          0.03.ph,
                          Custom_textfield_required(
                              keyboardType: TextInputType.number,
                              controller: cardController,
                              requiredLabel: 'Card Number',
                              hint: 'Enter Card Number'),
                          0.03.ph,
                          Custom_textfield_required(
                              controller: fullNameController,
                              requiredLabel: 'Full Name',
                              hint: 'Enter Full Name (Same as Card)'),
                          0.03.ph,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Date of Birth",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: CustomTextField(
                                      keyboardType: TextInputType.datetime,
                                      textEditingController: monthController,
                                      hintText: 'Month')),
                              Expanded(
                                  child: CustomTextField(
                                      keyboardType: TextInputType.datetime,
                                      textEditingController: yearController,
                                      hintText: 'Year')),
                            ],
                          ),
                          0.03.ph,
                        ],
                      ),
                    ),
                    // FlightSummaryWidget(),
                    // 0.01.ph,

                    // Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    //   Expanded(child: Icon(Icons.info)),
                    //   // 0.02.pw,
                    //   Expanded(
                    //       flex: 8,
                    //       child: CommonText(
                    //         text:
                    //             'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.',
                    //         textAlign: TextAlign.justify,
                    //       ))
                    // ]),
                  ],
                ),
              );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomOutlineButton(
                width: 150,
                text: "Back",
                onPress: () {
                  Get.back();
                }),
            CustomButton(
                width: 150,
                text: "Confirm",
                onPress: () {
                  flightBookingController.fetchBooking(
                    widget.searchID,
                    widget.flightID,
                    widget.paymentID,
                    widget.title,
                    widget.firstName,
                    widget.lastName,
                    widget.traveller,
                    widget.dob,
                    widget.passNumber,
                    widget.passExp,
                    widget.email,
                    widget.phone,
                    widget.phoneCode,
                    widget.countryCode,
                    widget.adultCount!,
                    widget.childCount!,
                    widget.infantCount!,
                    //
                    widget.adult2name,
                    widget.adult2Lname,
                    widget.adult2dob,
                    widget.adult2pass,
                    widget.adult2passExp,
                    widget.adult3name,
                    widget.adult3Lname,
                    widget.adult3dob,
                    widget.adult3pass,
                    widget.adult3passExp,
                    widget.adult4name,
                    widget.adult4Lname,
                    widget.adult4dob,
                    widget.adult4pass,
                    widget.adult4passExp,
                    //
                    widget.child1name,
                    widget.child1Lname,
                    widget.child1dob,
                    widget.child1pass,
                    widget.child1passExp,
                    widget.child2name,
                    widget.child2Lname,
                    widget.child2dob,
                    widget.child2pass,
                    widget.child2passExp,
                    widget.child3name,
                    widget.child3Lname,
                    widget.child3dob,
                    widget.child3pass,
                    widget.child3passExp,
                    widget.child4name,
                    widget.child4Lname,
                    widget.child4dob,
                    widget.child4pass,
                    widget.child4passExp,
                    //
                    widget.infant1name,
                    widget.infant1Lname,
                    widget.infant1dob,
                    widget.infant1pass,
                    widget.infant1passExp,
                    widget.infant2name,
                    widget.infant2Lname,
                    widget.infant2dob,
                    widget.infant2pass,
                    widget.infant2passExp,
                    widget.infant3name,
                    widget.infant3Lname,
                    widget.infant3dob,
                    widget.infant3pass,
                    widget.infant3passExp,
                    widget.infant4name,
                    widget.infant4Lname,
                    widget.infant4dob,
                    widget.infant4pass,
                    widget.infant4passExp,
                    //
                  );
                })
          ],
        ),
      ),
    );
  }
}
