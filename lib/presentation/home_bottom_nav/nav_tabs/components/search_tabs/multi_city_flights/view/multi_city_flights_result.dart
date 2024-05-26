// ignore_for_file: invalid_use_of_protected_member, unused_element, unrelated_type_equality_checks

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_fontweights.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/presentation/booking_history/view/my_bookings_screen.dart';
import 'package:travel_app/presentation/home_bottom_nav/nav_tabs/components/search_tabs/multi_city_flights/view/multi_city_fare_details.dart';

import '../../../../../../../app/utils/custom_widgets/custom_outline_button.dart';
import '../controller/multi_city_flights_qoute_controller.dart';

// ignore: must_be_immutable
class MulticitySearchFlightScreen extends StatefulWidget {
  final cityList;
  // String toCity;
  // String fromCity;
  // String departDate;
  // var arriveDate;
  String? traveller;
  // String? cabinClass;
  bool? isOneWay = false;
  // String tripType;
  // int? adultCount;
  // int? childCount;
  // int? infantCount;
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

  MulticitySearchFlightScreen({
    super.key,
    required this.cityList,
    // required this.toCity,
    // required this.fromCity,
    // required this.departDate,
    // required this.arriveDate,
    // required this.tripType,
    // required this.adultCount,
    // required this.childCount,
    // required this.infantCount,
    this.isOneWay,
    this.traveller,
    // this.cabinClass,
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
  State<MulticitySearchFlightScreen> createState() => _MulticitySearchFlightScreenState();
}

class _MulticitySearchFlightScreenState extends State<MulticitySearchFlightScreen> {
  final MulticityFlightQuoteController multiCityFlightQuoteController = Get.put(MulticityFlightQuoteController());
  String? filterName = "a";
  String selectedSortOption = '';
  List<String> airlineNames = [];
  bool? hasFlight = true;
  List<Map<String, dynamic>> selectedFlights = [];
  List<int?> selectedRadioList = [];
  int? selectedFlight1;
  int? selectedFlight2;
  int? selectedFlight3;
  int? selectedFlight4;
  int? selectedFlight5;
  int? selectedFlight6;
  // List<Map<String, dynamic>> selectedRadioList = [];
// NOT USED -----------------------------
/*
  void setRadioButtons(List<MultiCityFlightModel?>? list) {
    try {
      selectedRadioList = []; //List<int?>.filled(list!, null, growable: true);
      list!.forEachIndexed((ind, elem) {
        selectedRadioList.add({'Obj': ind, 'flights': []});
        // elem!.flights!.forEach((el) {
        //   selectedRadioList[ind]['flights'].add(null);
        // });
        selectedRadioList[ind]['flights'] = List<int?>.filled(elem!.flights!.length, null, growable: true);
      });
    } catch (e) {
      print(e);
    }
  }
*/
  void setRadioButtons(int list) {
    selectedRadioList = List<int?>.filled(list, null, growable: true);
    setState(() {});
  }

// Reset Selected Flight List
  // resetSelectedFlights() {
  //   selectedFlights = List.filled(multiCityFlightQuoteController.responseList.value.length, {'SearchId': null, 'FlightId': null});
  //   setState(() {});
  // }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await prepareData();
    Timer(Duration(seconds: 3), () {
      setRadioButtons(multiCityFlightQuoteController.responseList.value.length);
    });

    print(multiCityFlightQuoteController.responseList.value);
    print(selectedFlights);
  }

  prepareData() async {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    var eachReponse;
    widget.cityList.forEach((elem) async {
      eachReponse = await multiCityFlightQuoteController.multicityFlightQuote(elem);
      multiCityFlightQuoteController.responseList.value.add(eachReponse);
    });
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      backgroundColor: AppColors.appColorAccent,
      appBar: CustomAppBar(
        title: "Multi City Flights",
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                if (multiCityFlightQuoteController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (multiCityFlightQuoteController.responseList.value.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.warning_rounded,
                            size: 88,
                            color: Colors.grey,
                          ),
                          Text("No flights available", style: const TextStyle(color: Colors.black54, fontSize: 24, fontWeight: FontWeight.bold))
                        ],
                      ),
                    );
                  } else {
                    var respList = multiCityFlightQuoteController.responseList.value;
                    // var data1 = multiCityFlightQuoteController.oneWayflightQuoteModel.value.flights;
                    // var searchData = multiCityFlightQuoteController.oneWayflightQuoteModel.value;
                    // setRadioButtons(respList.length);
                    // Function to sort flights by total amount in ascending order
                    // void sortAscending() {
                    //   selectedSortOption = '';
                    //   setState(() {
                    //     data1!.sort((a, b) => a.totalAmount!.compareTo(b.totalAmount as num));
                    //   });
                    // }

                    // Function to sort flights by total amount in des
                    //cending order
                    // void sortDescending() {
                    //   setState(() {
                    //     data1!.sort((a, b) => b.totalAmount!.compareTo(a.totalAmount as num));
                    //   });
                    // }

                    // Function to sort flights by total amount in descending order
                    // void sortDurationLess() {
                    //   setState(() {
                    //     data1!.sort((a, b) => a.outBound?.duration!.compareTo(b.outBound?.duration as num));
                    //   });
                    // }

                    // Function to sort flights by total amount in descending order
                    // void sortDurationHigh() {
                    //   setState(() {
                    //     data1!.sort((a, b) => b.outBound?.duration!.compareTo(a.outBound?.duration!));
                    //   });
                    // }
/*
                    void _showSortOptions() {
                      showModalBottomSheet(
                        context: context,
                        enableDrag: true,
                        isScrollControlled: true,
                        showDragHandle: true,
                        useSafeArea: true,
                        builder: (BuildContext context) {
                          return Container(
                            child: Wrap(
                              children: <Widget>[
                                ListTile(
                                  enabled: false,
                                  leading: Icon(Icons.sort),
                                  title: Text('Sort by'),
                                  onTap: () {},
                                ),
                                Divider(),
                                ListTile(
                                  leading: Icon(Icons.stars),
                                  title: Text(
                                    'Recommended',
                                    style: TextStyle(color: (selectedSortOption == 'Recommended') ? Colors.cyan : Colors.black),
                                  ),
                                  onTap: () {
                                    selectedSortOption = 'Recommended';
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.arrow_upward),
                                  title: Text(
                                    'Price (Low to High)',
                                    style: TextStyle(color: (selectedSortOption == 'Price (Low to High)') ? Colors.cyan : Colors.black),
                                  ),
                                  onTap: () {
                                    sortAscending();
                                    selectedSortOption = 'Price (Low to High)';
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.arrow_downward),
                                  title: Text(
                                    'Price (High to Low)',
                                    style: TextStyle(color: (selectedSortOption == 'Price (High to Low)') ? Colors.cyan : Colors.black),
                                  ),
                                  onTap: () {
                                    selectedSortOption = 'Price (High to Low)';
                                    sortDescending();
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.av_timer_rounded),
                                  title: Text(
                                    'Duration (Low to High)',
                                    style: TextStyle(color: (selectedSortOption == 'Duration (Low to High)') ? Colors.cyan : Colors.black),
                                  ),
                                  onTap: () {
                                    selectedSortOption = 'Duration (Low to High)';
                                    sortDurationLess();
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.more_time_rounded),
                                  title: Text(
                                    'Duration (High to Low)',
                                    style: TextStyle(color: (selectedSortOption == 'Duration (High to Low)') ? Colors.cyan : Colors.black),
                                  ),
                                  onTap: () {
                                    selectedSortOption = 'Duration (High to Low)';
                                    sortDurationHigh();
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }

                    */
                    void _showFilterAirline(name) {
                      setState(() {
                        filterName = name;
                      });
                      // oneWayFlightQuoteController.multicityFlightQuote(widget.fromCity, widget.toCity, widget.departDate, widget.arriveDate,
                      // widget.tripType,
                      //     widget.cabinClass.toString(), widget.adultCount, widget.childCount, widget.infantCount);
                    }

/*
                    void _showFilterOptions() {
                      showModalBottomSheet(
                        context: context,
                        enableDrag: true,
                        isScrollControlled: true,
                        showDragHandle: true,
                        useSafeArea: true,
                        builder: (BuildContext context) {
                          return Container(
                            child: Wrap(
                              children: <Widget>[
                                ListTile(
                                  enabled: false,
                                  leading: Icon(Icons.sort),
                                  title: Text('Filter by'),
                                  onTap: () {},
                                ),
                                Divider(),
                                ListTile(
                                  enabled: false,
                                  leading: Icon(Icons.airplane_ticket),
                                  title: Text('Airlines:'),
                                  trailing: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        _showFilterAirline("a");
                                      },
                                      child: CommonText(text: "Reset")),
                                  onTap: () {},
                                ),
                                Container(
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount: airlineNames.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(airlineNames[index]),
                                            onTap: () {
                                              Navigator.pop(context);
                                              _showFilterAirline("${airlineNames[index]}");
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                )
                                // ListTile(
                                //   // leading: Icon(Icons.stars),
                                //   title: Text('Silicon Reservation System'),
                                //   onTap: () {
                                //     Navigator.pop(context);
                                //     _showFilterAirline(
                                //         "Silicon Reservation System");
                                //   },
                                // ),
                              ],
                            ),
                          );
                        },
                      );
                    }

                   */
                    return Expanded(
                      child: Column(
                        children: [
                          // Row(
                          //   children: [
                          //     Flexible(
                          //       child: Container(
                          //         height: 50.0,
                          //         // Adjust the height as needed
                          //         child: ListView(
                          //           scrollDirection: Axis.horizontal,
                          //           children: [
                          //             /*
                          //             Padding(
                          //               padding: const EdgeInsets.only(left: 10),
                          //               child: Row(
                          //                 children: [
                          //                   IconTextButton(
                          //                       onPress: () {
                          //                         // Get.to(() => SortScreen());
                          //                         _showSortOptions();
                          //                       },
                          //                       text: "Sort by",
                          //                       icon: Icons.sort),
                          //                   IconTextButton(
                          //                       onPress: () {
                          //                         _showFilterOptions();
                          //                       },
                          //                       text: "Filter by",
                          //                       icon: Icons.filter_alt_outlined),
                          //                   buildButton(
                          //                       text: 'Recommended',
                          //                       onPress: () {
                          //                         _showFilterAirline("a");
                          //                       }),
                          //                   buildButton(
                          //                       text: 'Low to High',
                          //                       onPress: () {
                          //                         sortAscending();
                          //                       }),
                          //                   buildButton(
                          //                       text: 'High to Low',
                          //                       onPress: () {
                          //                         sortDescending();
                          //                       }),
                          //                 ],
                          //               ),
                          //             ),
                          //             */
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(height: 10),
                          // CommonText(text: selectedRadioList.toString()),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: respList.length,
                              itemBuilder: (context, grpInd) {
                                var grp = respList[grpInd];

                                return grp!.flights!.isNotEmpty
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              CommonText(
                                                  text: "${grp.departureCity.toString()} to ${grp.arrivalCity}",
                                                  fontSize: 18,
                                                  weight: AppFontWeights.appTextFontWeightMedium),
                                              CommonText(
                                                  text: "${grp.departureDate?.substring(0, 10)}", fontSize: 14, weight: AppFontWeights.appTextFontWeightMedium),
                                            ],
                                          ),
                                          0.01.ph,
                                          ListView.builder(
                                            key: ValueKey(grpInd),
                                            padding: EdgeInsets.all(10),
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: grp.flights?.length,
                                            itemBuilder: (context, index) {
                                              var eachFlight = grp.flights?[index];
                                              // int? _selectedFlight;

                                              // bool isFiltered = data1[grpInd].outBound?.segments![0].airlineName!.contains("$filterName");
                                              // for (var item in data1) {
                                              //   if (item.outBound != null && item.outBound?.segments != null && item.outBound?.segments!.isNotEmpty) {
                                              //     String airlineName = item.outBound?.segments![0].airlineName.toString();
                                              //     if (!airlineNames.contains(airlineName)) {
                                              //       airlineNames.add(airlineName);
                                              //     }
                                              //   }
                                              // }
                                              // print("Airline List: $airlineNames");
                                              // return isFiltered
                                              //     ?
                                              return Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  DottedBorder(
                                                      dashPattern: [10, 8],
                                                      strokeWidth: 1,
                                                      color: AppColors.appColorBlack,
                                                      child: Container(
                                                        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                                        margin: EdgeInsets.all(10.0),
                                                        child: Column(
                                                          children: [
                                                            PlaneNameWidget(
                                                                image:
                                                                    "${eachFlight?.outBound?.segments?[0].airlineLogo ?? "https://reservations.siliconsom.com/assets/images/logos/logo_small.png"}",
                                                                name: eachFlight?.outBound?.segments?[0].airlineName ?? '---',
                                                                number: eachFlight?.outBound?.segments?[0].flightNumber!.toString()),
                                                            0.01.ph,
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Radio(
                                                                  visualDensity: VisualDensity.compact,
                                                                  // toggleable: true,
                                                                  value: index,
                                                                  groupValue: grpInd == 0
                                                                      ? selectedFlight1
                                                                      : grpInd == 1
                                                                          ? selectedFlight2
                                                                          : grpInd == 2
                                                                              ? selectedFlight3
                                                                              : grpInd == 3
                                                                                  ? selectedFlight4
                                                                                  : selectedFlight5,

                                                                  // groupValue: eachFlight!.id == selectedFlights[grpInd]['FlightId'] ? index : 99,
                                                                  onChanged: (value) {
                                                                    setState(() {
                                                                      grpInd == 0
                                                                          ? selectedFlight1 = value
                                                                          : grpInd == 1
                                                                              ? selectedFlight2 = value
                                                                              : grpInd == 2
                                                                                  ? selectedFlight3 = value
                                                                                  : grpInd == 3
                                                                                      ? selectedFlight4 = value
                                                                                      : selectedFlight5 = value;
                                                                      // selectedFlights[grpInd] = {'SearchId': grp.id, 'FlightId': eachFlight!.id};
                                                                      selectedRadioList[grpInd] = value;

                                                                      print(selectedRadioList);
                                                                    });
                                                                  },
                                                                ),
                                                                FromToFlightWidget(
                                                                  date: eachFlight?.outBound?.departureDate ?? "---",
                                                                  time: eachFlight?.outBound?.departureTime ?? "---",
                                                                  city: eachFlight?.outBound?.segments?[0].departure ?? "---",
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Icon(
                                                                      FontAwesomeIcons.plane,
                                                                      color: AppColors.appColorPrimary,
                                                                      size: 20.0,
                                                                    ),
                                                                    0.01.ph,
                                                                    CommonText(
                                                                      text: 'Outbound',
                                                                      fontSize: 12.0,
                                                                    )
                                                                  ],
                                                                ),
                                                                FromToFlightWidget(
                                                                  date: eachFlight?.outBound?.arrivalDate ?? "---",
                                                                  time: eachFlight?.outBound?.arrivalTime ?? "---",
                                                                  city: eachFlight?.outBound?.segments?[0].arrival ?? "---",
                                                                ),
                                                              ],
                                                            ),
                                                            // 0.02.ph,
                                                            // Divider(),
                                                            // PlaneNameWidget(
                                                            //     image:
                                                            //         "${eachFlight?.inBound!.segments![0].airlineLogo ?? "https://reservations.siliconsom.com/assets/images/logos/logo_small.png"}",
                                                            //     name: eachFlight
                                                            //         .inBound!
                                                            //         .segments![0]
                                                            //         .airlineName
                                                            //         .toString(),
                                                            //     number: eachFlight
                                                            //         .inBound!
                                                            //         .segments![0]
                                                            //         .flightNumber
                                                            //         .toString()),
                                                            // 0.01.ph,
                                                            // eachFlight.inBound != null
                                                            //     ? Row(
                                                            //         mainAxisAlignment:
                                                            //             MainAxisAlignment.spaceBetween,
                                                            //         children: [
                                                            //           FromToFlightWidget(
                                                            //             date:
                                                            //                 eachFlight.inBound != null
                                                            //                     ? eachFlight
                                                            //                         .inBound!
                                                            //                         .departureDate
                                                            //                         .toString()
                                                            //                     : "",
                                                            //             time:
                                                            //                 eachFlight.inBound != null
                                                            //                     ? eachFlight
                                                            //                         .inBound!
                                                            //                         .departureTime
                                                            //                         .toString()
                                                            //                     : "",
                                                            //             city:
                                                            //                 eachFlight.inBound != null
                                                            //                     ? eachFlight
                                                            //                         .inBound!
                                                            //                         .segments![0]
                                                            //                         .departure
                                                            //                         .toString()
                                                            //                     : "",
                                                            //           ),
                                                            //           Column(
                                                            //             children: [
                                                            //               RotatedBox(
                                                            //                 quarterTurns: 2,
                                                            //                 child: Icon(
                                                            //                   FontAwesomeIcons.plane,
                                                            //                   color: AppColors
                                                            //                       .appColorPrimary,
                                                            //                   size: 20.0,
                                                            //                 ),
                                                            //               ),
                                                            //               0.01.ph,
                                                            //               CommonText(
                                                            //                 text: 'IN-BOUND',
                                                            //                 fontSize: 12.0,
                                                            //               )
                                                            //             ],
                                                            //           ),
                                                            //           FromToFlightWidget(
                                                            //             date:
                                                            //                 eachFlight.inBound != null
                                                            //                     ? eachFlight
                                                            //                         .inBound!
                                                            //                         .arrivalDate
                                                            //                         .toString()
                                                            //                     : "",
                                                            //             time:
                                                            //                 eachFlight.inBound != null
                                                            //                     ? eachFlight
                                                            //                         .inBound!
                                                            //                         .arrivalTime
                                                            //                         .toString()
                                                            //                     : "",
                                                            //             city:
                                                            //                 eachFlight.inBound != null
                                                            //                     ? eachFlight
                                                            //                         .inBound!
                                                            //                         .segments![0]
                                                            //                         .arrival
                                                            //                         .toString()
                                                            //                     : "",
                                                            //           ),
                                                            //         ],
                                                            //       )
                                                            //     : Container(),
                                                            0.03.ph,
                                                            CustomButton(
                                                                onPress: () {
/*
                                                                  Get.to(() => FlightDetailsScreen(
                                                                        cityList: widget.cityList,
                                                                        /*
                                                                        cabinClass: widget.cityList[0]['CabinClass'] ?? "---", //widget.cabinClass.toString(),
                                                                        traveller: widget.traveller ?? "---",
                                                                        searchID: searchData.id ?? "---",
                                                                        flightID: searchData.flights?[index].id! ?? "---",
                                                                        departFromDate1: eachFlight?.outBound?.departureDate ?? "---",
                                                                        departFromTime1: eachFlight?.outBound?.departureTime ?? "---",
                                                                        departFromCode1: eachFlight?.outBound?.segments![0].departure ?? "---",
                                                                        arriveToDate1: eachFlight?.outBound?.arrivalDate ?? "---",
                                                                        arriveToTime1: eachFlight?.outBound?.arrivalTime ?? "---",
                                                                        arriveToCode1: eachFlight?.outBound?.segments![0].arrival ?? "---",
                                                                        arriveFlight: "",
                                                                        departFlight: eachFlight?.outBound?.segments![0].flightNumber ?? "---",
                                                                        departFromDate2: "",
                                                                        departFromTime2: "",
                                                                        departFromCode2: "",
                                                                        arriveToDate2: "",
                                                                        arriveToTime2: "",
                                                                        arriveToCode2: "",
                                                                        adultCount: widget.cityList[0]['Adults'], // widget.adultCount,
                                                                        childCount: widget.cityList[0]['Children'], //widget.childCount,
                                                                        infantCount: widget.cityList[0]['Infants'], //widget.infantCount,
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
                                                                      */
                                                                },
                                                                text: "Flights starts from \$ ${eachFlight?.totalAmount.toStringAsFixed(2)}"),
                                                          ],
                                                        ),
                                                      )),
                                                  SizedBox(height: 20),
                                                ],
                                              );
                                              // : Center(
                                              //     child: Column(
                                              //       mainAxisAlignment: MainAxisAlignment.center,
                                              //       children: [
                                              //         Icon(
                                              //           Icons.warning_rounded,
                                              //           size: 88,
                                              //           color: Colors.grey,
                                              //         ),
                                              //         Text("No flights available with \n $filterName",
                                              //             textAlign: TextAlign.center,
                                              //             style: const TextStyle(color: Colors.black54, fontSize: 24, fontWeight: FontWeight.bold))
                                              //       ],
                                              //     ),
                                              //   );
                                            },
                                          ),
                                        ],
                                      )
                                    : Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.warning_rounded,
                                              size: 88,
                                              color: Colors.grey,
                                            ),
                                            Text("No flights available",
                                                style: const TextStyle(color: Colors.black54, fontSize: 24, fontWeight: FontWeight.bold))
                                          ],
                                        ),
                                      );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
              }),
            ],
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
                    !selectedRadioList.contains(null)
                        ? CustomButton(
                            width: 150,
                            text: "Next",
                            onPress: () {
                              var fareRulesList = [];
                              var flightsSelectionMap = {};
                              multiCityFlightQuoteController.responseList.value.forEachIndexed((ind, elem) {
                                fareRulesList.add({'searchId': elem!.id, 'flightId': elem.flights![selectedRadioList[ind]!].id});
                                widget.cityList[ind].addAll({
                                  "departureTime": elem.flights![selectedRadioList[ind]!].outBound?.departureTime,
                                  "arrivalTime": elem.flights![selectedRadioList[ind]!].outBound?.arrivalTime,
                                  "flightNumber": elem.flights![selectedRadioList[ind]!].outBound?.segments?[0].flightNumber,
                                });
                              });
                              flightsSelectionMap['flightSelection'] = fareRulesList;
                              print('*********************************************');
                              print(flightsSelectionMap);

                              Get.to(MultiCItyFareDetailsScreen(
                                cityList: widget.cityList,
                                flightsMap: flightsSelectionMap,

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
                        : CustomOutlineButton(color: Colors.grey, width: 150, text: "Next", onPress: () {})
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // ignore: unused_element7
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          title: Text('Baggage Info'),
          // content: Text('This is the content of the alert dialog.'),
          actions: <Widget>[
            // FlightPackageWidget(name: 'Saver'),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Function to be executed when the "OK" button is pressed
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// ignore: must_be_immutable
class IconTextButton extends StatelessWidget {
  String? text;
  IconData icon;
  final Function() onPress;
  IconTextButton({
    required this.text,
    required this.icon,
    required this.onPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Row(
        children: [Icon(icon), CommonText(text: text ?? '')],
      ),
    );
  }
}

// ignore: must_be_immutable
class PlaneNameWidget extends StatelessWidget {
  String? name;
  String? image;
  String? number;
  PlaneNameWidget({
    required this.name,
    required this.image,
    required this.number,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(height: 30, width: 30, child: Image(image: NetworkImage(image ?? ''), fit: BoxFit.contain)),
        CommonText(
          text: name ?? '',
          fontSize: 12.0,
          weight: FontWeight.w400,
        ),
        Spacer(),
        CommonText(
          text: number ?? '',
          fontSize: 12.0,
        )
      ],
    );
  }
}

class buildButton extends StatelessWidget {
  final String? text;
  final Function() onPress;
  const buildButton({
    super.key,
    required this.text,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        onPressed: onPress,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: Text(text ?? ''),
      ),
    );
  }
}
