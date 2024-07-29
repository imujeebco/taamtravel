// ignore_for_file: camel_case_types

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/hotel/view/Hotel_tabs/search_hotel_model.dart';

import 'hotel_details.dart';
import '../../app/utils/custom_widgets/custom_outline_button.dart';

import '../controller/search_hotel_controller.dart';
import 'mapview_screen.dart';

// ignore: must_be_immutable
class SearchHotelScreen extends StatefulWidget {
  Map dataMap;

  SearchHotelScreen({super.key, required this.dataMap});

  @override
  State<SearchHotelScreen> createState() => _SearchHotelScreenState();
}

class _SearchHotelScreenState extends State<SearchHotelScreen> {
  final SearchHotelController searchHotelController =
      Get.put(SearchHotelController());
  String? filterName = "";
  List<String> airlineNames = [];
  int? _selectedOutbound;
  int? _selectedInbound;
  String? selection;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchHotelController.fetchHotels(widget.dataMap);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    HeightWidth(context);
    return Scaffold(
      backgroundColor: AppColors.appColorAccent,
      appBar: CustomAppBar(
        title: "Search Hotels",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            if (searchHotelController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (searchHotelController.searchHotelModel.value.hotels == null || searchHotelController.searchHotelModel.value.hotels?.length == 0) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(
                      //   Icons.warning_rounded,
                      //   size: 88,
                      //   color: Colors.grey,
                      // ),
                      Image(
                          height: 110,
                          width: 110,
                          image: AssetImage("assets/icons/no_location.png")),
                      SizedBox(height: 10),
                      Text("No Hotels available",
                          style: const TextStyle(
                              color: Colors.black26,
                              fontSize: 20,
                              fontWeight: FontWeight.w200))
                    ],
                  ),
                );
              } else {
                var data1 = searchHotelController.searchHotelModel.value.hotels;
                var searchData = searchHotelController.searchHotelModel.value;

                // Function to sort flights by total amount in ascending order
                void sortAscending() {
                  setState(() {
                    data1!
                        .sort((a, b) => a.totalAmount.compareTo(b.totalAmount));
                    selection = 'Price (Low to High)';
                  });
                }

                // Function to sort flights by total amount in descending order
                void sortDescending() {
                  setState(() {
                    data1!
                        .sort((a, b) => b.totalAmount.compareTo(a.totalAmount));
                    selection = 'Price (High to Low)';
                  });
                }

                //// Function to sort flights by total amount in descending order
                // void sortDurationLess() {
                //   setState(() {
                //     data1!.sort((a, b) =>
                //         a.outBound!.duration!.compareTo(b.outBound!.duration));
                //     selection = 'Duration (Low to High)';
                //   });
                // }

                //// Function to sort flights by total amount in descending order
                // void sortDurationHigh() {
                //   setState(() {
                //     data1!.sort((a, b) =>
                //         b.outBound!.duration!.compareTo(a.outBound!.duration!));
                //     selection = 'Duration (High to Low)';
                //   });
                // }

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
                              title: Text('Recommanded'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.arrow_upward),
                              title: Text('Price (Low to High)'),
                              onTap: () {
                                sortAscending();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.arrow_downward),
                              title: Text('Price (High to Low)'),
                              onTap: () {
                                sortDescending();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.av_timer_rounded),
                              title: Text('Duration (Low to High)'),
                              onTap: () {
                                // sortDurationLess();
                                // Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.more_time_rounded),
                              title: Text('Duration (High to Low)'),
                              onTap: () {
                                // sortDurationHigh();
                                // Navigator.pop(context);
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
                  // flightQuoteController.fetchFlightQuote(
                  //     widget.fromCity,
                  //     widget.toCity,
                  //     widget.departDate,
                  //     widget.arriveDate,
                  //     widget.tripType,
                  //     widget.cabinClass.toString(),
                  //     widget.adultCount,
                  //     widget.childCount,
                  //     widget.infantCount);
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
                                          selection = "${airlineNames[index]}";
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
                                        selection == null
                                            ? SizedBox.shrink()
                                            : buildFilterButton(
                                                text: selection.toString(),
                                                onPress: () {
                                                  setState(() {
                                                    selection = null;
                                                    _showFilterAirline("a");
                                                  });
                                                }),
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
                                              selection = 'Low to High';
                                            }),
                                        buildButton(
                                            text: 'High to Low',
                                            onPress: () {
                                              sortDescending();
                                              selection = 'High to Low';
                                            }),
                                      ],
                                    ),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     IconTextButton(
                                  //         onPress: () {
                                  //           Get.to(() => FilterScreen());
                                  //         },
                                  //         text: "Filter by",
                                  //         icon: Icons.filter_list),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Stack(
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.all(10),
                              physics: const BouncingScrollPhysics(),
                              itemCount: data1?.length,
                              // itemCount: data1![0]
                              //         .outBound!
                              //         .segments![0]
                              //         .airlineName!
                              //         .contains("$filterName")
                              //     ? data1.length
                              //     : 1,
                              itemBuilder: (context, index) {
                                // bool isFiltered = data1[index]
                                //     .outBound!
                                //     .segments![0]
                                //     .airlineName!
                                //     .contains("$filterName");
                                // for (var item in data1) {
                                //   if (item.outBound != null &&
                                //       item.outBound!.segments != null &&
                                //       item.outBound!.segments!.isNotEmpty) {
                                //     String airlineName = item
                                //         .outBound!.segments![0].airlineName
                                //         .toString();
                                //     if (!airlineNames.contains(airlineName)) {
                                //       airlineNames.add(airlineName);
                                //     }
                                //   }
                                // }
                                // print("Airline List: $airlineNames");
                                return
                                    // isFiltered
                                    //     ?
                                    Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Card(
                                      clipBehavior: Clip.antiAlias,
                                      child: InkWell(
                                        onTap: () {
                                          print("tapped");
                                          Get.to(() => HotelDetailsScreen(dataMap: widget.dataMap , hotel: data1![index],searchId: searchData.id.toString(),
                                              ));
                                        },
                                        child: Column(
                                          children: [
                                            Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                CarouselSlider(
                                                  items: data1?[index].imageUrls?.map((item) {
                                                    return Image.network(
                                                        item,
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width,
                                                        fit: BoxFit.cover);
                                                  }).toList(),
                                                  options: CarouselOptions(
                                                    viewportFraction: 1,
                                                    height: size.height *
                                                        0.3, // Customize the height of the carousel
                                                    autoPlay:
                                                        true, // Enable auto-play
                                                    enlargeCenterPage:
                                                        false, // Increase the size of the center item
                                                    enableInfiniteScroll:
                                                        true, // Enable infinite scroll
                                                    onPageChanged:
                                                        (index, reason) {
                                                      // Optional callback when the page changes
                                                      // You can use it to update any additional UI components
                                                    },
                                                  ),
                                                ),
                                                // GestureDetector(
                                                //   onTap: () {
                                                //     //onPress();
                                                //   },
                                                //   child: Padding(
                                                //     padding:
                                                //         const EdgeInsets.all(
                                                //             8.0),
                                                //     child: Icon(Icons.favorite,
                                                //         color: Colors.red),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                            ListTile(
                                              //leading: Icon(Icons.arrow_drop_down_circle),
                                              title: Text(
                                                  data1?[index].hotelName ?? '',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      if (data1?[index].category == 'S1') ...[
                                                        Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                                                      ],
                                                      if (data1?[index].category == 'S2') ...[
                                                        Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                                                        Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                                                      ],
                                                      if (data1?[index].category == 'S3') ...[
                                                        Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                                                        Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                                                        Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                                                      ],
                                                      if (data1?[index].category == 'S4') ...[
                                                        Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                                                        Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                                                        Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                                                        Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                                                      ],
                                                      if (data1?[index].category == 'S5') ...[
                                                        Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                                                        Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                                                        Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                                                        Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                                                        Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                                                      ],
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Text(
                                                    data1?[index].address ?? '',
                                                  //'Karachi - Show on map > 7.62 km from Center',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 8.0,
                                                    left: 8.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.bed_sharp),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        data1?[index].room ?? '',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.only(
                                                //     top: 8.0,
                                                //     left: 8.0,
                                                //   ),
                                                //   child: Row(
                                                //     children: [
                                                //       Icon(Icons
                                                //           .flatware_outlined),
                                                //       SizedBox(width: 5),
                                                //       Text(
                                                //         'BED AND BREAKFAST',
                                                //         style: TextStyle(
                                                //             color: Colors.black,
                                                //             fontSize: 12),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                if (data1?[index].nonRefundable == 'PARTIALLY_REFUNDABLE')
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 8.0,
                                                    left: 8.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .check_circle_outline,
                                                        color: Colors.green,
                                                      ),
                                                      Text(
                                                        ' Free cancellation',
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 8.0,
                                                      left: 8.0,
                                                    ),
                                                    child: CustomButton(
                                                      height: 40,
                                                      width: 140,
                                                      text: 'See options',
                                                      onPress: () {},
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                );
                                // : Center(
                                //     child: Column(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         Icon(
                                //           Icons.warning_rounded,
                                //           size: 88,
                                //           color: Colors.grey,
                                //         ),
                                //         Text(
                                //             "No flights available with \n $filterName",
                                //             textAlign: TextAlign.center,
                                //             style: const TextStyle(
                                //                 color: Colors.black54,
                                //                 fontSize: 24,
                                //                 fontWeight:
                                //                     FontWeight.bold))
                                //       ],
                                //     ),
                                //   );
                              },
                            ),
                            _selectedOutbound == null &&
                                    _selectedInbound == null
                                ? Container()
                                : Positioned(
                                    bottom: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CustomOutlineButton(
                                              color: Colors.white,
                                              width: 150,
                                              text: "Cancel",
                                              onPress: () {
                                                Get.back();
                                              }),
                                          SizedBox(width: 15),
                                          _selectedOutbound == null ||
                                                  _selectedInbound == null
                                              ? CustomOutlineButton(
                                                  color: Colors.grey,
                                                  width: 150,
                                                  text: "Next",
                                                  onPress: () {})
                                              : CustomButton(
                                                  width: 150,
                                                  text: "Next",
                                                  onPress: () {
                                                    // Get.to(() =>
                                                    // FlightDetailsScreen(
                                                    //   cabinClass: widget
                                                    //       .cabinClass
                                                    //       .toString(),
                                                    //   traveller: widget
                                                    //       .traveller
                                                    //       .toString(),
                                                    //   searchID: searchData
                                                    //       .id
                                                    //       .toString(),
                                                    //   flightID: searchData
                                                    //       .flights![0].id!
                                                    //       .toString(),
                                                    //   departFromDate1:
                                                    //       data1[0]
                                                    //           .outBound!
                                                    //           .departureDate
                                                    //           .toString(),
                                                    //   departFromTime1:
                                                    //       data1[0]
                                                    //           .outBound!
                                                    //           .departureTime
                                                    //           .toString(),
                                                    //   departFromCode1:
                                                    //       data1[0]
                                                    //           .outBound!
                                                    //           .segments![0]
                                                    //           .departure
                                                    //           .toString(),
                                                    //   arriveToDate1:
                                                    //       data1[0]
                                                    //           .outBound!
                                                    //           .arrivalDate
                                                    //           .toString(),
                                                    //   arriveToTime1:
                                                    //       data1[0]
                                                    //           .outBound!
                                                    //           .arrivalTime
                                                    //           .toString(),
                                                    //   arriveToCode1:
                                                    //       data1[0]
                                                    //           .outBound!
                                                    //           .segments![0]
                                                    //           .arrival
                                                    //           .toString(),
                                                    //   arriveFlight: data1[0]
                                                    //       .inBound!
                                                    //       .segments![0]
                                                    //       .flightNumber
                                                    //       .toString(),
                                                    //   departFlight: data1[0]
                                                    //       .outBound!
                                                    //       .segments![0]
                                                    //       .flightNumber
                                                    //       .toString(),
                                                    //   departFromDate2:
                                                    //       data1[0]
                                                    //           .inBound!
                                                    //           .departureDate
                                                    //           .toString(),
                                                    //   departFromTime2:
                                                    //       data1[0]
                                                    //           .inBound!
                                                    //           .departureTime
                                                    //           .toString(),
                                                    //   departFromCode2:
                                                    //       data1[0]
                                                    //           .inBound!
                                                    //           .segments![0]
                                                    //           .departure
                                                    //           .toString(),
                                                    //   arriveToDate2:
                                                    //       data1[0]
                                                    //           .inBound!
                                                    //           .arrivalDate
                                                    //           .toString(),
                                                    //   arriveToTime2:
                                                    //       data1[0]
                                                    //           .inBound!
                                                    //           .arrivalTime
                                                    //           .toString(),
                                                    //   arriveToCode2:
                                                    //       data1[0]
                                                    //           .inBound!
                                                    //           .segments![0]
                                                    //           .arrival
                                                    //           .toString(),
                                                    //   adultCount:
                                                    //       widget.adultCount,
                                                    //   childCount:
                                                    //       widget.childCount,
                                                    //   infantCount: widget
                                                    //       .infantCount,
                                                    //   //
                                                    //   child1age:
                                                    //       widget.child1age,
                                                    //   child2age:
                                                    //       widget.child2age,
                                                    //   child3age:
                                                    //       widget.child3age,
                                                    //   child4age:
                                                    //       widget.child4age,
                                                    //   //
                                                    //   infant1age:
                                                    //       widget.infant1age,
                                                    //   infant2age:
                                                    //       widget.infant2age,
                                                    //   infant3age:
                                                    //       widget.infant3age,
                                                    //   infant4age:
                                                    //       widget.infant4age,
                                                    //   //
                                                    // ));
                                                  },
                                                )
                                        ],
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      smallMapWidget(context,searchHotelController.searchHotelModel.value.hotels,widget.dataMap,searchData.id.toString()),
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
    return Row(
      children: [
        Icon(icon),
        TextButton(onPressed: onPress, child: CommonText(text: text))
      ],
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

class buildFilterButton extends StatelessWidget {
  final String text;
  final Function() onPress;
  const buildFilterButton({
    super.key,
    required this.text,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: OutlinedButton(
        onPressed: onPress,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.appColorPrimary.withOpacity(0.6),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CommonText(text: "$text", color: AppColors.white),
            Icon(Icons.cancel, color: AppColors.white),
          ],
        ),
      ),
    );
  }
}

Widget smallMapWidget(BuildContext context, List<Hotels>? hotels, Map dataMap, String Id,) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: CustomButton(
      text: 'Locations on Map',
      onPress: (){
        Get.to(() => AccommodationScreen(hotels,dataMap,Id));
      },
    ),
  );
}




class Flight {
  final String airlineName;
  final List<Segment> segments;

  Flight({required this.airlineName, required this.segments});
}

class Segment {
  final String airlineName;

  Segment({required this.airlineName});
}
