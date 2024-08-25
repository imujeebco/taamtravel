// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';

import '../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../model/booking_request.dart';
import 'Hotel_tabs/search_hotel_model.dart';
import 'hotel_details.dart';
import '../../app/utils/custom_widgets/custom_outline_button.dart';

import '../controller/search_hotel_controller.dart';
import 'mapview_screen.dart';
import 'multiple_hotel_details.dart';

// ignore: must_be_immutable
class MultipleSearchHotelScreen extends StatefulWidget {
  Map dataMap;
  final List<BookingRequest> multiAccom;

  // List<SearchHotelModel?> responseList = <SearchHotelModel?>[].obs;
  List<SearchHotelModel?> selectedresponseList = <SearchHotelModel?>[].obs;

  MultipleSearchHotelScreen({super.key, required this.dataMap, required this.multiAccom});

  @override
  State<MultipleSearchHotelScreen> createState() => _MultipleSearchHotelScreenState();
}

class _MultipleSearchHotelScreenState extends State<MultipleSearchHotelScreen> with TickerProviderStateMixin {
  final SearchHotelController searchHotelController =
  Get.put(SearchHotelController());
  String? filterName = "";
  List<String> airlineNames = [];
  int? _selectedOutbound;
  int? _selectedInbound;
  String? selection;
  late TabController tabController;
  BookingRequest bRequest = BookingRequest();
  DatePickerController _dpcontroller = DatePickerController();
  late AnimationController controller;
  double _progress = 0.0;
  // int? selectedCardIndex;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.multiAccom.length, vsync: this);

    controller = AnimationController(vsync: this);

    // String jsonString = jsonEncode(widget.dataMap);

    bRequest = widget.multiAccom[0];

    fetch();

  }

  void fetch(){
    _progress = 0.0;
    _startProgress();
    searchHotelController.responseList.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget.multiAccom.forEach((elem) async {
        setState(() {});
        searchHotelController.responseList.add(await searchHotelController.MultifetchHotels(elem,elem.city));
        if (widget.multiAccom.length == searchHotelController.responseList.length){
          searchHotelController.isLoading.value = false;
          _progress = 101.0;
        }
        setState(() {});
      });
    });
  }

  void _startProgress() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _progress += 0.1;
        if (_progress < 100.0) {
          _startProgress();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onNextButtonPressed() {
    List<Hotels> selectedHotels = [];
    widget.selectedresponseList = [];

    for (var destination in searchHotelController.responseList) {
      if (destination != null && destination.hotels != null) {
        for (var hotel in destination.hotels!) {
          if (hotel.selected == true) {
            selectedHotels.add(hotel);
            var desti = destination.clone();
            desti.hotels?.clear();
            desti.hotels?.add(hotel);
            widget.selectedresponseList.add(desti);
          }
        }
      }
    }

    if (selectedHotels.length == widget.multiAccom.length) {
      // Proceed to the next screen or perform the desired action
      print("All accommodations selected, proceeding to the next step.");

      Get.to(() => MultipleHotelDetailsScreen(dataMap: widget.dataMap, hotelsList: widget.selectedresponseList,multiAccom: widget.multiAccom));
    } else {
      Get.showSnackbar(GetBar(
        message: "Please select accommodations for all destinations.",
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    HeightWidth(context);
    return DefaultTabController(
      length: widget.multiAccom.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Multiple Accommodations"),
          bottom: TabBar(
            controller: tabController,
            isScrollable: true,
            tabs: widget.multiAccom.map((tab) => Tab(text: tab.city)).toList(),
          ),
        ),
        body: Obx(() {
          if (searchHotelController.isLoading.value) {
            return TabBarView(
              controller: tabController,
              children: widget.multiAccom.map((tab) {
                var destination = searchHotelController.responseList.firstWhere((d) => d?.destination == tab.city, orElse: () => null);

                // if (destination == null || destination.hotels == null) {
                //   return Center(
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Image(height: 110, width: 110, image: AssetImage("assets/icons/no_location.png")),
                //         SizedBox(height: 10),
                //         Text("No Hotels available", style: const TextStyle(color: Colors.black26, fontSize: 20, fontWeight: FontWeight.w200)),
                //       ],
                //     ),
                //   );
                // }

                Future.delayed(Duration(seconds: 1), () {
                  _dpcontroller.animateToSelection();
                });

                // var hotels = destination.hotels;
                return Column(
                  children: [
                    SizedBox(height: 8),
                    Container(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('CheckIn'),
                          Expanded(
                            child: DatePicker(
                              DateTime.now(),
                              controller: _dpcontroller,
                              height: 30,
                              width: 68,
                              initialSelectedDate: DateTime.parse(tab.checkIn!),
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
                                  tab.checkIn = dateString;

                                  // var req = tab.toJson();
                                  // widget.dataMap = req;
                                  // String jsonString = jsonEncode(widget.dataMap);
                                  //
                                  // bRequest = BookingRequest.fromJson(json.decode(jsonString));
                                  fetch();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('CheckOut'),
                          Expanded(
                            child: DatePicker(
                              DateTime.now(),
                              controller: _dpcontroller,
                              height: 30,
                              width: 68,
                              initialSelectedDate: DateTime.parse(tab.checkOut!),
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
                                  tab.checkOut = dateString;
                                  // var req = bRequest.toJson();
                                  // widget.dataMap = req;
                                  // String jsonString = jsonEncode(widget.dataMap);
                                  //
                                  // bRequest = BookingRequest.fromJson(json.decode(jsonString));
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
                    SizedBox(height: 8),
                  ],
                );
              }).toList(),
            );
          } else {
            return TabBarView(
              controller: tabController,
              children: widget.multiAccom.map((tab) {
                var destination = searchHotelController.responseList.firstWhere((d) => d?.destination == tab.city, orElse: () => null);

                if (destination == null || destination.hotels == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(height: 110, width: 110, image: AssetImage("assets/icons/no_location.png")),
                        SizedBox(height: 10),
                        Text("No Hotels available", style: const TextStyle(color: Colors.black26, fontSize: 20, fontWeight: FontWeight.w200)),
                      ],
                    ),
                  );
                }

                Future.delayed(Duration(seconds: 2), () {
                  _dpcontroller.animateToSelection();
                });

                var hotels = destination.hotels;
                return Column(
                  children: [
                    SizedBox(height: 8),
                    Container(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('CheckIn'),
                          Expanded(
                            child: DatePicker(
                              DateTime.now(),
                              controller: _dpcontroller,
                              height: 30,
                              width: 68,
                              initialSelectedDate: DateTime.parse(bRequest.checkIn!),
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
                                  bRequest.checkIn = dateString;

                                  var req = bRequest.toJson();
                                  widget.dataMap = req;
                                  String jsonString = jsonEncode(widget.dataMap);

                                  bRequest = BookingRequest.fromJson(json.decode(jsonString));
                                  fetch();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('CheckOut'),
                          Expanded(
                            child: DatePicker(
                              DateTime.now(),
                              controller: _dpcontroller,
                              height: 30,
                              width: 68,
                              initialSelectedDate: DateTime.parse(bRequest.checkOut!),
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
                                  bRequest.checkOut = dateString;
                                  var req = bRequest.toJson();
                                  widget.dataMap = req;
                                  String jsonString = jsonEncode(widget.dataMap);

                                  bRequest = BookingRequest.fromJson(json.decode(jsonString));
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
                        itemCount: hotels?.length,
                        itemBuilder: (context, index) {
                          var hotel = hotels?[index];
                          return Card(
                            color: hotel?.selected ?? false ? Colors.green.shade100 : Colors.white,
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  hotels?.forEach((element) {
                                    element.selected = false;
                                  });
                                  hotel?.selected = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      CarouselSlider(
                                        items: hotel?.imageUrls?.map((item) {
                                          return Image.network(item, width: size.width, fit: BoxFit.cover);
                                        }).toList(),
                                        options: CarouselOptions(
                                          viewportFraction: 1,
                                          height: size.height * 0.3,
                                          autoPlay: true,
                                          enlargeCenterPage: false,
                                          enableInfiniteScroll: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListTile(
                                    title: Text(hotel?.hotelName ?? '', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: List.generate(hotel?.category?.length ?? 0, (index) {
                                            return Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1));
                                          }),
                                        ),
                                        SizedBox(height: 5),
                                        Text(hotel?.address ?? '', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(Icons.bed_sharp),
                                            SizedBox(width: 5),
                                            Text(hotel?.room ?? '', style: TextStyle(color: Colors.black, fontSize: 12)),
                                          ],
                                        ),
                                        if (hotel?.nonRefundable == 'PARTIALLY_REFUNDABLE')
                                          Row(
                                            children: [
                                              Icon(Icons.check_circle_outline, color: Colors.green),
                                              Text(' Free cancellation', style: TextStyle(color: Colors.green, fontSize: 12)),
                                            ],
                                          ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        text: 'Next',
                        onPress: _onNextButtonPressed,
                      ),
                    ),
                  ],
                );
              }).toList(),
            );
          }
        }),
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

// Widget smallMapWidget(BuildContext context) {
//   return GestureDetector(
//     onTap: () {
//       // Handle onTap action here
//
//       print('Map widget tapped!');
//       Get.to(() => AccommodationScreen());
//     },
//     child: Container(
//       height: 50,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.green),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: ElevatedButton(
//           onPressed: () {
//             // Handle button press here
//             print('Map View button pressed!');
//             Get.to(() => AccommodationScreen());
//             // Navigate to map view or perform desired action
//           },
//           child: Text('Map View'),
//         ),
//       ),
//     ),
//   );
// }