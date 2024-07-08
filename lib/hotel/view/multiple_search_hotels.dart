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

import '../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../model/booking_request.dart';
import 'Hotel_tabs/search_hotel_model.dart';
import 'hotel_details.dart';
import '../../app/utils/custom_widgets/custom_outline_button.dart';

import '../controller/search_hotel_controller.dart';
import 'mapview_screen.dart';

// ignore: must_be_immutable
class MultipleSearchHotelScreen extends StatefulWidget {
  Map dataMap;
  final List<BookingRequest> multiAccom;

  List<SearchHotelModel?> responseList = <SearchHotelModel?>[].obs;

  MultipleSearchHotelScreen({super.key, required this.dataMap, required this.multiAccom});

  @override
  State<MultipleSearchHotelScreen> createState() => _MultipleSearchHotelScreenState();
}

class _MultipleSearchHotelScreenState extends State<MultipleSearchHotelScreen> {
  final SearchHotelController searchHotelController =
  Get.put(SearchHotelController());
  String? filterName = "a";
  List<String> airlineNames = [];
  int? _selectedOutbound;
  int? _selectedInbound;
  String? selection;

  // int? selectedCardIndex;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget.multiAccom.forEach((elem) async {
        setState(() {

        });
        searchHotelController.responseList.add(await searchHotelController.MultifetchHotels(elem));
        setState(() {

        });
      });
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
    return DefaultTabController(
      length: widget.multiAccom.length, // Number of tabs
      child: Scaffold(
        backgroundColor: AppColors.appColorAccent,
        appBar: CustomAppBar(
          title: "Multiple Accommodations",
          tabB: TabBar(
            isScrollable: true,
            tabs: widget.multiAccom.map((tab) => Tab(text: tab.destination)).toList(),
          ),
        ),
        body: searchHotelController.isLoading.value ? Center(
          child: CircularProgressIndicator(),
        ) :
        TabBarView(
          children: searchHotelController.responseList.map((destination) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Add PageView before Expanded
                  Obx(() {
                    if (searchHotelController.isLoading.value) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (destination?.hotels == null) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                        var data1 = destination?.hotels;
                        //var searchData = destination != null;//searchHotelController.searchHotelModel.value;

                        return Expanded(
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.all(10),
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: data1?.length,
                                  itemBuilder: (context, index) {
                                    return
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Card(
                                            color: data1?[index].selected ?? false
                                                ? Colors.green.shade100
                                                : Colors.white,
                                            clipBehavior: Clip.antiAlias,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  data1?.forEach((element) {
                                                    element.selected = false;
                                                  });
                                                  data1?[index].selected = true;
                                                });
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
                                                      //     const EdgeInsets.all(
                                                      //         8.0),
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
                                                      child: Text(data1?[index].address ?? '',
                                                        // 'Karachi - Show on map > 7.62 km from Center',
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
                                                      // SizedBox(height: 10),
                                                      // Align(
                                                      //   alignment:
                                                      //   Alignment.centerLeft,
                                                      //   child: Padding(
                                                      //     padding:
                                                      //     const EdgeInsets.only(
                                                      //       top: 8.0,
                                                      //       left: 8.0,
                                                      //     ),
                                                      //     child: CustomButton(
                                                      //       height: 40,
                                                      //       width: 140,
                                                      //       text: 'See options',
                                                      //       onPress: () {
                                                      //         print("tapped");
                                                      //         Get.to(() => HotelDetailsScreen(dataMap: widget.dataMap , hotel: data1![index],searchId: destination!.id.toString(),
                                                      //         ));
                                                      //       },
                                                      //     ),
                                                      //   ),
                                                      // ),
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
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment:Alignment.center,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(
                                    top: 8.0,
                                    left: 8.0,
                                  ),
                                  child: CustomButton(
                                    height: 40,
                                    width: 140,
                                    text: 'Next',
                                    onPress: () {
                                      print("tapped");
                                      // Find hotels where selected is true
                                      List<Hotels>? selectedHotels = data1?.where((hotel) => hotel.selected == true).toList();
                                      if(selectedHotels?.length == widget.multiAccom.length){

                                      }else{
                                        Get.showSnackbar(gradientSnackbar(
                                            "Failure",
                                            "Please select Accommodations",
                                            AppColors.red,
                                            Icons.warning_rounded));
                                      }
                                      // Get.to(() => HotelDetailsScreen(dataMap: widget.dataMap , hotel: data1![index],searchId: destination!.id.toString(),
                                      // ));
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              //smallMapWidget(context),
                            ],
                          ),
                        );
                      }
                    }
                  }),
                ],
              ),
          )).toList(),
        ),
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

Widget smallMapWidget(BuildContext context) {
  return GestureDetector(
    onTap: () {
      // Handle onTap action here

      print('Map widget tapped!');
      Get.to(() => AccommodationsPage());
    },
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ElevatedButton(
          onPressed: () {
            // Handle button press here
            print('Map View button pressed!');
            Get.to(() => AccommodationsPage());
            // Navigate to map view or perform desired action
          },
          child: Text('Map View'),
        ),
      ),
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