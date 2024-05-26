import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/presentation/home_bottom_nav/nav_tabs/components/search_tabs/return_tab.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/search_flights.dart';

import 'multi_city_flights/view/multi_city_flights_search.dart';

// ignore: must_be_immutable
class MultiTabView extends StatefulWidget {
  String? toCity;
  String? fromCity;
  String? cabinClass;
  MultiTabView({super.key, this.toCity, this.fromCity, this.cabinClass});

  @override
  State<MultiTabView> createState() => _MultiTabViewState();
}

class _MultiTabViewState extends State<MultiTabView> {
  var travellerList = [
    'Adult',
    'Child',
  ];
  var cabinList = [
    'Economy',
    'Business',
    'Premium',
    'First Class',
  ];

  var selectedTraveller = 'Adult';
  var selectedCabin = 'Economy';

  String? arriveDate = "Select Date";
  String? departDate = "Select Date";
  String? tripType = "RoundTrip";

  // ignore: unused_element
  Future<void> _selectArriveDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    // ignore: unrelated_type_equality_checks
    if (picked != null && picked != arriveDate) {
      setState(() {
        arriveDate = _formatDate(picked).toString();
      });
    }
  }

  Future<void> _selectDepartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    // ignore: unrelated_type_equality_checks
    if (picked != null && picked != departDate) {
      setState(() {
        departDate = _formatDate(picked).toString();
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('E, d MMM y').format(date);
  }

  // void navigate() {
  //   Get.to(() => MulticityFlightScreen());
  // }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => MulticityFlightScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Container(
      // height: h * 0.3,
      // width: w,
      margin: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // flight time widgets --------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlightTimeWidget(
                type: 'DEPARTURE',
                date: 'Fri, 28 Nov 2024',
              ),
              FlightTimeWidget(
                type: 'RETURN',
                date: 'Tue, 15 Dec 2024',
              ),
            ],
          ),

          // Traveller ------------------------------------
          0.04.ph,
          CommonText(text: 'TRAVELLER', fontSize: 12.0),

          SizedBox(
            width: w,
            child: DropdownButton(
                isDense: true,
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down),
                value: selectedTraveller,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                items: travellerList.map((String item) {
                  return DropdownMenuItem(
                      value: item, child: CommonText(text: item));
                }).toList(),
                onChanged: (String? val) {
                  setState(() => selectedTraveller = val!);
                }),
          ),

          // Cabin Class  ---------------------------------
          0.04.ph,
          CommonText(text: 'CABIN CLASS', fontSize: 12.0),

          SizedBox(
            width: w,
            child: DropdownButton(
                isDense: true,
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down),
                value: selectedCabin,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                items: cabinList.map((String item) {
                  return DropdownMenuItem(
                      value: item, child: CommonText(text: item));
                }).toList(),
                onChanged: (String? val) {
                  setState(() => selectedCabin = val!);
                }),
          ),

          // Search Flight Button -----------------------------------

          Spacer(),
          CustomButton(
              height: 40,
              width: w,
              text: 'Search Flight',
              onPress: () {
                Get.to(() => SearchFlightScreen(
                      toCity: widget.toCity.toString(),
                      fromCity: widget.fromCity.toString(),
                      arriveDate: arriveDate.toString(),
                      departDate: departDate.toString(),
                      tripType: tripType.toString(),
                      adultCount: 1,
                      childCount: 0,
                      infantCount: 0,
                      //
                      child1age: 1,
                      child2age: 1,
                      child3age: 1,
                      child4age: 1,
                      //
                      infant1age: 1,
                      infant2age: 1,
                      infant3age: 1,
                      infant4age: 1,
                      //
                    ));
              }),

          // OneWayTabView()
        ],
      ),
    );
  }
}
