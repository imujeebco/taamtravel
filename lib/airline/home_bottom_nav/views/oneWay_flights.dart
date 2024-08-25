import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/airline/booking_history/view/my_bookings_screen.dart';
import 'package:travel_app/airline/home_bottom_nav/views/filter_view.dart';
import 'package:travel_app/airline/home_bottom_nav/views/flight_details.dart';
import 'package:travel_app/airline/home_bottom_nav/views/sort_view.dart';

import '../controller/oneWay_flight_quote_controller.dart';

// ignore: must_be_immutable
class OneWaySearchFlightScreen extends StatefulWidget {
  String toCity;
  String fromCity;
  String departDate;
  var arriveDate;
  String? traveller;
  String? cabinClass;
  bool? isOneWay = false;
  String tripType;
  int? adultCount;
  int? childCount;
  int? infantCount;
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

  OneWaySearchFlightScreen({
    super.key,
    required this.toCity,
    required this.fromCity,
    required this.departDate,
    required this.arriveDate,
    required this.tripType,
    required this.adultCount,
    required this.childCount,
    required this.infantCount,
    this.isOneWay,
    this.traveller,
    this.cabinClass,
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
  State<OneWaySearchFlightScreen> createState() =>
      _OneWaySearchFlightScreenState();
}

class _OneWaySearchFlightScreenState extends State<OneWaySearchFlightScreen> with TickerProviderStateMixin {
  final OneWayFlightQuoteController oneWayFlightQuoteController =
  Get.put(OneWayFlightQuoteController());
  String? filterName = "";
  String selectedSortOption = '';
  List<String> airlineNames = [];
  DatePickerController _dpcontroller = DatePickerController();
  late AnimationController controller;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);

    fetch();
  }

  void _startProgress() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _progress += 0.2;
        if (_progress < 1.0) {
          _startProgress();
        }
      });
    });
  }


  void fetch(){
    _progress = 0.0;
    _startProgress();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      oneWayFlightQuoteController.fetchOneWayFlightQuote(
          widget.fromCity,
          widget.toCity,
          widget.departDate,
          widget.arriveDate,
          widget.tripType,
          widget.cabinClass.toString(),
          widget.adultCount,
          widget.childCount,
          widget.infantCount);
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
      backgroundColor: AppColors.appColorAccent,
      appBar: CustomAppBar(
        title: "One Way Flights",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            if (oneWayFlightQuoteController.isLoading.value) {
              void sortAscending() {
                selectedSortOption = '';
                setState(() {
                  // data1!.sort((a, b) =>
                  //     a.totalAmount!.compareTo(b.totalAmount as num));
                });
              }

              // Function to sort flights by total amount in descending order
              void sortDescending() {
                setState(() {
                  // data1!.sort((a, b) =>
                  //     b.totalAmount!.compareTo(a.totalAmount as num));
                });
              }

              // Function to sort flights by total amount in descending order
              void sortDurationLess() {
                setState(() {
                  // data1!.sort((a, b) => a.outBound!.duration!
                  //     .compareTo(b.outBound!.duration as num));
                });
              }

              // Function to sort flights by total amount in descending order
              void sortDurationHigh() {
                setState(() {
                  // data1!.sort((a, b) =>
                  //     b.outBound!.duration!.compareTo(a.outBound!.duration!));
                });
              }

              Future.delayed(Duration(seconds: 1), () {
                _dpcontroller.animateToSelection();
              });

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
                            title: Text('Recommended',
                              style: TextStyle(color: (selectedSortOption == 'Recommended') ? Colors.cyan : Colors.black ),),
                            onTap: () {
                              selectedSortOption = 'Recommended';
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_upward),
                            title: Text('Price (Low to High)',
                              style: TextStyle(color: (selectedSortOption == 'Price (Low to High)') ? Colors.cyan : Colors.black ),),
                            onTap: () {
                              sortAscending();
                              selectedSortOption = 'Price (Low to High)';
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_downward),
                            title: Text('Price (High to Low)',
                              style: TextStyle(color: (selectedSortOption == 'Price (High to Low)') ? Colors.cyan : Colors.black ),),
                            onTap: () {
                              selectedSortOption = 'Price (High to Low)';
                              sortDescending();
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.av_timer_rounded),
                            title: Text('Duration (Low to High)',
                              style: TextStyle(color: (selectedSortOption == 'Duration (Low to High)') ? Colors.cyan : Colors.black ),),
                            onTap: () {
                              selectedSortOption = 'Duration (Low to High)';
                              sortDurationLess();
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.more_time_rounded),
                            title: Text('Duration (High to Low)',
                              style: TextStyle(color: (selectedSortOption == 'Duration (High to Low)') ? Colors.cyan : Colors.black ),),
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

              void _showFilterAirline(name) {
                setState(() {
                  filterName = name;
                });
                oneWayFlightQuoteController.fetchOneWayFlightQuote(
                    widget.fromCity,
                    widget.toCity,
                    widget.departDate,
                    widget.arriveDate,
                    widget.tripType,
                    widget.cabinClass.toString(),
                    widget.adultCount,
                    widget.childCount,
                    widget.infantCount);
              }

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
                                        _showFilterAirline(
                                            "${airlineNames[index]}");
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

              return Expanded(
                  child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Container(
                                height: 50.0,
                                // Adjust the height as needed
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          IconTextButton(
                                              onPress: () {
                                                // Get.to(() => SortScreen());
                                                _showSortOptions();
                                              },
                                              text: "Sort by",
                                              icon: Icons.sort),
                                          IconTextButton(
                                              onPress: () {
                                                _showFilterOptions();
                                              },
                                              text: "Filter by",
                                              icon: Icons.filter_alt_outlined),
                                          buildButton(
                                              text: 'Recommanded',
                                              onPress: () {
                                                _showFilterAirline("a");
                                              }),
                                          buildButton(
                                              text: 'Low to High',
                                              onPress: () {
                                                sortAscending();
                                              }),
                                          buildButton(
                                              text: 'High to Low',
                                              onPress: () {
                                                sortDescending();
                                              }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 35,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: DatePicker(
                                  DateTime.now(),
                                  controller: _dpcontroller,
                                  height: 30,
                                  width: 68,
                                  initialSelectedDate: DateTime.parse(widget.departDate),
                                  selectionColor: Colors.black,
                                  selectedTextColor: Colors.white,
                                  dayTextStyle: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                                  monthTextStyle: TextStyle(fontSize: 8, fontWeight: FontWeight.w600),
                                  dateTextStyle: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                                  onDateChange: (date) {
                                    setState(() {
                                      // //_selectedValue = date;
                                      // widget.departDate = date
                                      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                                      String dateString = dateFormat.format(date);
                                      widget.departDate = dateString;
                                      fetch();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        LinearProgressIndicator(
                          value: _progress, // Only if determinate
                          backgroundColor: Colors.grey[300],
                          color: AppColors.appColorPrimary,
                          minHeight: 5.0,
                        ),
                        SizedBox(height: 8)]));
              // return Center(
              //   child: CircularProgressIndicator(),
              // );
            } else {
              if (oneWayFlightQuoteController
                  .oneWayflightQuoteModel.value.flights!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning_rounded,
                        size: 88,
                        color: Colors.grey,
                      ),
                      Text("No flights available",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 24,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                );
              } else {
                var data1 = oneWayFlightQuoteController
                    .oneWayflightQuoteModel.value.flights;
                var searchData =
                    oneWayFlightQuoteController.oneWayflightQuoteModel.value;
                // Function to sort flights by total amount in ascending order
                void sortAscending() {
                  selectedSortOption = '';
                  setState(() {
                    data1!.sort((a, b) =>
                        a.totalAmount!.compareTo(b.totalAmount as num));
                  });
                }

                // Function to sort flights by total amount in descending order
                void sortDescending() {
                  setState(() {
                    data1!.sort((a, b) =>
                        b.totalAmount!.compareTo(a.totalAmount as num));
                  });
                }

                // Function to sort flights by total amount in descending order
                void sortDurationLess() {
                  setState(() {
                    data1!.sort((a, b) => a.outBound!.duration!
                        .compareTo(b.outBound!.duration as num));
                  });
                }

                // Function to sort flights by total amount in descending order
                void sortDurationHigh() {
                  setState(() {
                    data1!.sort((a, b) =>
                        b.outBound!.duration!.compareTo(a.outBound!.duration!));
                  });
                }

                Future.delayed(Duration(seconds: 1), () {
                  _dpcontroller.animateToSelection();
                });

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
                              title: Text('Recommended',
                                style: TextStyle(color: (selectedSortOption == 'Recommended') ? Colors.cyan : Colors.black ),),
                              onTap: () {
                                selectedSortOption = 'Recommended';
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.arrow_upward),
                              title: Text('Price (Low to High)',
                                style: TextStyle(color: (selectedSortOption == 'Price (Low to High)') ? Colors.cyan : Colors.black ),),
                              onTap: () {
                                sortAscending();
                                selectedSortOption = 'Price (Low to High)';
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.arrow_downward),
                              title: Text('Price (High to Low)',
                                style: TextStyle(color: (selectedSortOption == 'Price (High to Low)') ? Colors.cyan : Colors.black ),),
                              onTap: () {
                                selectedSortOption = 'Price (High to Low)';
                                sortDescending();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.av_timer_rounded),
                              title: Text('Duration (Low to High)',
                                style: TextStyle(color: (selectedSortOption == 'Duration (Low to High)') ? Colors.cyan : Colors.black ),),
                              onTap: () {
                                selectedSortOption = 'Duration (Low to High)';
                                sortDurationLess();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.more_time_rounded),
                              title: Text('Duration (High to Low)',
                                style: TextStyle(color: (selectedSortOption == 'Duration (High to Low)') ? Colors.cyan : Colors.black ),),
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

                void _showFilterAirline(name) {
                  setState(() {
                    filterName = name;
                  });
                  oneWayFlightQuoteController.fetchOneWayFlightQuote(
                      widget.fromCity,
                      widget.toCity,
                      widget.departDate,
                      widget.arriveDate,
                      widget.tripType,
                      widget.cabinClass.toString(),
                      widget.adultCount,
                      widget.childCount,
                      widget.infantCount);
                }

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
                                          _showFilterAirline(
                                              "${airlineNames[index]}");
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

                return Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Container(
                              height: 50.0,
                              // Adjust the height as needed
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        IconTextButton(
                                            onPress: () {
                                              // Get.to(() => SortScreen());
                                              _showSortOptions();
                                              _dpcontroller.animateToSelection();
                                            },
                                            text: "Sort by",
                                            icon: Icons.sort),
                                        IconTextButton(
                                            onPress: () {
                                              _showFilterOptions();
                                            },
                                            text: "Filter by",
                                            icon: Icons.filter_alt_outlined),
                                        buildButton(
                                            text: 'Recommanded',
                                            onPress: () {
                                              _showFilterAirline("a");
                                            }),
                                        buildButton(
                                            text: 'Low to High',
                                            onPress: () {
                                              sortAscending();
                                            }),
                                        buildButton(
                                            text: 'High to Low',
                                            onPress: () {
                                              sortDescending();
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 35,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: DatePicker(
                                DateTime.now(),
                                controller: _dpcontroller,
                                height: 30,
                                width: 68,
                                initialSelectedDate: DateTime.parse(widget.departDate),
                                selectionColor: Colors.black,
                                selectedTextColor: Colors.white,
                                dayTextStyle: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                                monthTextStyle: TextStyle(fontSize: 8, fontWeight: FontWeight.w600),
                                dateTextStyle: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                                onDateChange: (date) {
                                  setState(() {
                                    // //_selectedValue = date;
                                    // widget.departDate = date
                                    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                                    String dateString = dateFormat.format(date);
                                    widget.departDate = dateString;
                                    fetch();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(10),
                          physics: const BouncingScrollPhysics(),
                          itemCount: data1![0]
                              .outBound!
                              .segments![0]
                              .airlineName!
                              .contains("$filterName")
                              ? data1.length
                              : 1,
                          itemBuilder: (context, index) {
                            bool isFiltered = data1[index]
                                .outBound!
                                .segments![0]
                                .airlineName!
                                .contains("$filterName");
                            for (var item in data1) {
                              if (item.outBound != null &&
                                  item.outBound!.segments != null &&
                                  item.outBound!.segments!.isNotEmpty) {
                                String airlineName = item
                                    .outBound!.segments![0].airlineName
                                    .toString();
                                if (!airlineNames.contains(airlineName)) {
                                  airlineNames.add(airlineName);
                                }
                              }
                            }
                            print("Airline List: $airlineNames");
                            return isFiltered
                                ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DottedBorder(
                                    dashPattern: [10, 8],
                                    strokeWidth: 1,
                                    color: AppColors.appColorBlack,
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          15, 15, 15, 15),
                                      margin: EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          PlaneNameWidget(
                                              image:
                                              "${data1[index].outBound!.segments![0].airlineLogo ?? "https://reservations.siliconsom.com/assets/images/logos/logo_small.png"}",
                                              name: data1[index]
                                                  .outBound!
                                                  .segments![0]
                                                  .airlineName
                                                  .toString(),
                                              number: data1[index]
                                                  .outBound!
                                                  .segments![0]
                                                  .flightNumber
                                                  .toString()),
                                          0.03.ph,
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              FromToFlightWidget(
                                                date: data1[index]
                                                    .outBound!
                                                    .departureDate
                                                    .toString(),
                                                time: data1[index]
                                                    .outBound!
                                                    .departureTime
                                                    .toString(),
                                                city: data1[index]
                                                    .outBound!
                                                    .segments![0]
                                                    .departure
                                                    .toString(),
                                              ),
                                              Column(
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .plane,
                                                    color: AppColors
                                                        .appColorPrimary,
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
                                                date: data1[index]
                                                    .outBound!
                                                    .arrivalDate
                                                    .toString(),
                                                time: data1[index]
                                                    .outBound!
                                                    .arrivalTime
                                                    .toString(),
                                                city: data1[index]
                                                    .outBound!
                                                    .segments![0]
                                                    .arrival
                                                    .toString(),
                                              ),
                                            ],
                                          ),
                                          // 0.02.ph,
                                          // Divider(),
                                          // PlaneNameWidget(
                                          //     image:
                                          //         "${data1[index].inBound!.segments![0].airlineLogo ?? "https://reservations.siliconsom.com/assets/images/logos/logo_small.png"}",
                                          //     name: data1[index]
                                          //         .inBound!
                                          //         .segments![0]
                                          //         .airlineName
                                          //         .toString(),
                                          //     number: data1[index]
                                          //         .inBound!
                                          //         .segments![0]
                                          //         .flightNumber
                                          //         .toString()),
                                          // 0.01.ph,
                                          // data1[index].inBound != null
                                          //     ? Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment.spaceBetween,
                                          //         children: [
                                          //           FromToFlightWidget(
                                          //             date:
                                          //                 data1[index].inBound != null
                                          //                     ? data1[index]
                                          //                         .inBound!
                                          //                         .departureDate
                                          //                         .toString()
                                          //                     : "",
                                          //             time:
                                          //                 data1[index].inBound != null
                                          //                     ? data1[index]
                                          //                         .inBound!
                                          //                         .departureTime
                                          //                         .toString()
                                          //                     : "",
                                          //             city:
                                          //                 data1[index].inBound != null
                                          //                     ? data1[index]
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
                                          //                 data1[index].inBound != null
                                          //                     ? data1[index]
                                          //                         .inBound!
                                          //                         .arrivalDate
                                          //                         .toString()
                                          //                     : "",
                                          //             time:
                                          //                 data1[index].inBound != null
                                          //                     ? data1[index]
                                          //                         .inBound!
                                          //                         .arrivalTime
                                          //                         .toString()
                                          //                     : "",
                                          //             city:
                                          //                 data1[index].inBound != null
                                          //                     ? data1[index]
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
                                                Get.to(() =>
                                                    FlightDetailsScreen(
                                                      cabinClass: widget
                                                          .cabinClass
                                                          .toString(),
                                                      traveller: widget
                                                          .traveller
                                                          .toString(),
                                                      searchID: searchData
                                                          .id
                                                          .toString(),
                                                      flightID: searchData
                                                          .flights![index]
                                                          .id!
                                                          .toString(),
                                                      departFromDate1:
                                                      data1[index]
                                                          .outBound!
                                                          .departureDate
                                                          .toString(),
                                                      departFromTime1:
                                                      data1[index]
                                                          .outBound!
                                                          .departureTime
                                                          .toString(),
                                                      departFromCode1:
                                                      data1[index]
                                                          .outBound!
                                                          .segments![
                                                      0]
                                                          .departure
                                                          .toString(),
                                                      arriveToDate1:
                                                      data1[index]
                                                          .outBound!
                                                          .arrivalDate
                                                          .toString(),
                                                      arriveToTime1:
                                                      data1[index]
                                                          .outBound!
                                                          .arrivalTime
                                                          .toString(),
                                                      arriveToCode1:
                                                      data1[index]
                                                          .outBound!
                                                          .segments![
                                                      0]
                                                          .arrival
                                                          .toString(),
                                                      arriveFlight: "",
                                                      departFlight: data1[
                                                      index]
                                                          .outBound!
                                                          .segments![0]
                                                          .flightNumber
                                                          .toString(),
                                                      departFromDate2: "",
                                                      departFromTime2: "",
                                                      departFromCode2: "",
                                                      arriveToDate2: "",
                                                      arriveToTime2: "",
                                                      arriveToCode2: "",
                                                      adultCount: widget
                                                          .adultCount,
                                                      childCount: widget
                                                          .childCount,
                                                      infantCount: widget
                                                          .infantCount,
                                                      //
                                                      child1age: widget
                                                          .child1age,
                                                      child2age: widget
                                                          .child2age,
                                                      child3age: widget
                                                          .child3age,
                                                      child4age: widget
                                                          .child4age,
                                                      //
                                                      infant1age: widget
                                                          .infant1age,
                                                      infant2age: widget
                                                          .infant2age,
                                                      infant3age: widget
                                                          .infant3age,
                                                      infant4age: widget
                                                          .infant4age,
                                                      //
                                                    ));
                                              },
                                              text:
                                              "Flights starts from \$ ${data1[index].totalAmount.toStringAsFixed(2)}"),
                                          // 0.01.ph,
                                          // Align(
                                          //   alignment: Alignment.centerRight,
                                          //   child: IconButton(
                                          //       onPressed: () {
                                          //         _showAlertDialog(context);
                                          //       },
                                          //       icon: Icon(
                                          //           Icons.shopping_bag_rounded)),
                                          // )
                                        ],
                                      ),
                                    )),
                                SizedBox(height: 20),
                              ],
                            )
                                : Center(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.warning_rounded,
                                    size: 88,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                      "No flights available with \n $filterName",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold))
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
    );
  }

  // ignore: unused_element
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
  String text;
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
        children: [
          Icon(icon),
          CommonText(text: text)
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class PlaneNameWidget extends StatelessWidget {
  String name;
  String image;
  String number;
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
        Container(
            height: 30,
            width: 30,
            child: Image(image: NetworkImage(image), fit: BoxFit.contain)),
        CommonText(
          text: name,
          fontSize: 12.0,
          weight: FontWeight.w400,
        ),
        Spacer(),
        CommonText(
          text: number,
          fontSize: 12.0,
        )
      ],
    );
  }
}

class buildButton extends StatelessWidget {
  final String text;
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
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: Text(text),
      ),
    );
  }
}
