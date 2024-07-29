// ignore_for_file: unnecessary_question_mark

import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_summary/rating_summary.dart';
import 'package:readmore/readmore.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/airline/auth/view/login_screen.dart';
import 'package:travel_app/airline/home_bottom_nav/controller/flight_fare_rule_controller.dart';
import 'package:travel_app/airline/home_bottom_nav/views/passenger_details.dart';
import 'package:travel_app/hotel/view/room_details.dart';
import 'package:travel_app/hotel/controller/search_hotel_controller.dart';
import 'package:travel_app/hotel/view/Hotel_tabs/search_room_model.dart';

import '../../app/data/data_controller.dart';
import '../../app/utils/custom_functions/app_alerts.dart';
import '../model/booking_request.dart';
import 'Hotel_tabs/search_hotel_model.dart';
import 'multi_room_details.dart';

// ignore: must_be_immutable
class MultipleHotelDetailsScreen extends StatefulWidget {

  Map dataMap;
  // Hotels hotel;
  // String searchId;
  final List<BookingRequest> multiAccom;

  List<SearchHotelModel?> hotelsList = <SearchHotelModel?>[].obs;
  List<SearchRoomModel?> selectedRoomsList = <SearchRoomModel?>[].obs;


  MultipleHotelDetailsScreen({super.key, required this.dataMap,required this.multiAccom,required this.hotelsList});

  @override
  State<MultipleHotelDetailsScreen> createState() => _MultipleHotelDetailsScreenState();
}

class _MultipleHotelDetailsScreenState extends State<MultipleHotelDetailsScreen> {
  final DataController dataController = Get.put(DataController());
  final SearchHotelController searchHotelController =
      Get.put(SearchHotelController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dataController.loadMyData();
      widget.hotelsList.forEach((elem) async {
        setState(() {});
        var destination = widget.multiAccom.firstWhere((d) => d.city == elem?.destination);
        searchHotelController.roomResponseList.add(await searchHotelController.fetchMultiRooms(destination, elem?.id.toString()  ?? '', elem?.hotels?[0].id.toString()  ?? ''));
        setState(() {});
      });

    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onNextButtonPressed() {
    // widget.selectedRoomsList = [];
    //
    // for (var rooms in searchHotelController.roomResponseList) {
    //   rooms?.rooms?.forEach((e) {
    //     if(e.selected ?? false){
    //       print(e);
    //       var ro = rooms.clone();
    //       ro.rooms?.add(e);
    //       widget.selectedRoomsList.add(ro);
    //     }
    //   });
    // }

    if (widget.selectedRoomsList.length == widget.multiAccom.length) {
      // Proceed to the next screen or perform the desired action
      print("All accommodations selected, proceeding to the next step.");

      Get.to(() => MultiRoomDetailsScreen(

        dataMap: widget.dataMap,
        hotel: widget.hotelsList,
        searchId: widget.selectedRoomsList[0]!.searchId.toString(),
        room: widget.selectedRoomsList,
        multiAccom: widget.multiAccom,
      ));

      // Get.to(() => MultipleHotelDetailsScreen(dataMap: widget.dataMap, hotelsList: widget.selectedresponseList,multiAccom: widget.multiAccom));
    } else {
      Get.showSnackbar(GetBar(
        message: "Please select rooms for all destinations.",
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return DefaultTabController(
      length: widget.hotelsList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hotel Details'),
          bottom: TabBar(
            //controller: tabController,
            isScrollable: true,
            tabs: widget.hotelsList.map((tab) => Tab(text: tab?.destination)).toList(),
          ),
        ),
        body: searchHotelController.isLoading.value ? Center(
          child: CircularProgressIndicator(),
        ) : Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Obx(() {
                // if (searchHotelController.isLoading.value) {
                //   return Center(
                //     child: CircularProgressIndicator(),
                //   );
                // } else {
                  if (searchHotelController.roomResponseList.length == 0) {
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
                    var data1 = widget.hotelsList;

                    return Expanded(
                      child: TabBarView(
                        //controller: tabController,
                        children: widget.hotelsList.asMap().entries.map((entry) {
                          int i = entry.key;
                          var e = entry.value;

                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  HotelPackageWidget(widget:widget ,dataMap: widget.dataMap, hotel: e!.hotels![0],
                                    rooms: searchHotelController.roomResponseList[i]?.rooms, roomsList: searchHotelController.roomResponseList, destination: e.destination ?? '',),
                                ],
                              );
                            },
                          );
                        }).toList(),
                      ),
                    );
                  }
                //}
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  text: 'Next',
                  onPress: (){
                    _onNextButtonPressed();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///////////////////////////// HotelPackageWidget /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
// ignore: must_be_immutable
class HotelPackageWidget extends StatefulWidget {
  Map dataMap;
  Hotels hotel;
  String destination;
  // String searchId;
  List<Rooms>? rooms;
  List<SearchRoomModel?> roomsList;
  MultipleHotelDetailsScreen widget;

  HotelPackageWidget({
    required this.dataMap,
    required this.hotel,
    required this.destination,
    required this.rooms,
    required this.roomsList,
    required this.widget,

    super.key,
  });

  // final String name;

  @override
  State<HotelPackageWidget> createState() => _HotelPackageWidgetState();
}

class _HotelPackageWidgetState extends State<HotelPackageWidget> {
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
    // dynamic? total = widget.charges + widget.tax!;
    Size size = MediaQuery.of(context).size;

    Hotels hotel = widget.hotel;

    List<String> servicesList = [
      "Luggage room",
      "Wi-fi",
      "Airport Shuttle",
      "Restaurant",
      "Bicycle rentals",
      "BBQ Facilities"
    ];
    List<IconData> servicesIcon = [
      Icons.room_service_outlined,
      Icons.wifi,
      Icons.airport_shuttle_outlined,
      Icons.restaurant,
      Icons.pedal_bike_outlined,
      Icons.outdoor_grill_outlined
    ];

    bool _isExpanded = false;

    // String jsonString = jsonEncode(widget.dataMap);
    // var bookingRequest;
    // if (jsonString == '{}') {
    //
    // } else {
    //   bookingRequest = BookingRequest.fromJson(json.decode(jsonString));
    //   // Calculate total adults and total children and infants
    //
    //   // Check if rooms is not null before iterating
    //   if (bookingRequest.rooms != null) {
    //     for (Room room in bookingRequest.rooms!) {
    //       // widget.totalAdults += room.adults;
    //       // widget.totalChildrenAndInfant += room.childrenAndInfant;
    //     }
    //   }
    // }


    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 10, 10, 10),
      margin: const EdgeInsets.fromLTRB(10.0, 10, 10, 10.0),
      // height: h * 0.43,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1st ------------------------------------------
          // 0.01.ph,

          CommonText(
            text: '${widget.destination}',
            weight: FontWeight.bold,
            fontSize: 12.0,
            color: AppColors.appColorPrimary,
          ),

          // -----------------------------
          0.02.ph,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,  // Align children from start
            children: [
              CommonText(
                text: hotel.hotelName ?? '',
                fontSize: 15,
                weight: FontWeight.w600,
              ),
              Row(
                children: [
                  if (hotel.category == 'S1') ...[
                    Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                  ],
                  if (hotel.category == 'S2') ...[
                    Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                    Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                  ],
                  if (hotel.category == 'S3') ...[
                    Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                    Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                    Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                  ],
                  if (hotel.category == 'S4') ...[
                    Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                    Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                    Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                    Icon(Icons.star, color: Color.fromRGBO(236, 171, 71, 1)),
                  ],
                  if (hotel.category == 'S5') ...[
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
          0.02.ph,
// -----------------------------------------------------
          CommonText(
            text:
                hotel.address ?? '',
            fontSize: 11,
            weight: FontWeight.normal,
          ),
          CommonText(
            text: '7.62 km from Center',
            fontSize: 11,
            weight: FontWeight.bold,
          ),
          0.02.ph,

          // // -----------------------------------------------------
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Container(
          //         height: 40,
          //         width: 40,
          //         decoration: BoxDecoration(
          //           border: Border.all(),
          //           borderRadius: BorderRadius.circular(3.0),
          //         ),
          //         child: Icon(Icons.share_outlined,
          //             color: Colors.black, size: 20)),
          //     0.02.pw,
          //     Container(
          //         height: 40,
          //         width: 40,
          //         decoration: BoxDecoration(
          //           border: Border.all(),
          //           borderRadius: BorderRadius.circular(3.0),
          //         ),
          //         child: Icon(Icons.favorite_border,
          //             color: Colors.black, size: 20)),
          //   ],
          // ),
          //
          // 0.02.ph,
// -----------------------------------------------------
          // -----------------------------------------------------
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CarouselSlider(
              items: hotel.imageUrls?.map((item) {
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
                height:
                    size.height * 0.3, // Customize the height of the carousel
                autoPlay: true, // Enable auto-play
                enlargeCenterPage:
                    false, // Increase the size of the center item
                enableInfiniteScroll: true, // Enable infinite scroll
                onPageChanged: (index, reason) {
                  // Optional callback when the page changes
                  // You can use it to update any additional UI components
                },
              ),
            ),
          ),

          0.02.ph,
// -----------------------------------------------------
          // -----------------------------------------------------
          CommonText(
            text: 'About the property',
            fontSize: 20,
            weight: FontWeight.bold,
          ),
          0.02.ph,
          ReadMoreText(
            hotel.description ?? '',
            trimMode: TrimMode.Line,
            trimLines: 4,
            colorClickableText: Colors.pink,
            trimCollapsedText: 'Read more',
            trimExpandedText: 'Read less',
            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          0.02.ph,
          if ((widget.hotel.includedServices?.length ?? 0) > 0) ...[
            CommonText(
              text: 'Main services',
              fontSize: 20,
              weight: FontWeight.bold,
            ),
            0.02.ph,
            Container(
              height: widget.hotel.includedServices != null ? 34 * widget.hotel.includedServices!.length.toDouble() : 0.0,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // number of items in each row
                  mainAxisSpacing: 8.0, // spacing between rows
                  crossAxisSpacing: 8.0,
                  childAspectRatio: (1 / .4),
                ),
                padding: EdgeInsets.all(8.0), // padding around the grid
                itemCount: widget.hotel.includedServices?.length, // total number of items
                itemBuilder: (context, index) {
                  return Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Row(
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Icon(servicesIcon[index],
                          //       color: Colors.black54, size: 30),
                          // ),
                          CommonText(
                            text: widget.hotel.includedServices![index],
                            fontSize: 10,
                            weight: FontWeight.normal,
                          ),
                        ],
                      ));
                },
              ),
            ),
            0.02.ph,
          ],
          if ((widget.hotel.otherServices?.length ?? 0) > 0) ...[
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: 'Other services',
                          fontSize: 20,
                          weight: FontWeight.bold,
                        ),
                        IconButton(
                          icon: Icon(
                            _isExpanded ? Icons.expand_less : Icons.expand_more,
                          ),
                          onPressed: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                        ),
                      ],
                    ),
                    0.02.ph,
                    Container(
                      height: widget.hotel.otherServices != null ? _isExpanded ? 32 * widget.hotel.otherServices!.length.toDouble() : 0.0 : 0.0,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // number of items in each row
                          mainAxisSpacing: 8.0, // spacing between rows
                          crossAxisSpacing: 8.0,
                          childAspectRatio: (1 / .4),
                        ),
                        padding: EdgeInsets.all(8.0), // padding around the grid
                        itemCount: widget.hotel.otherServices?.length, // total number of items
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    servicesIcon[0],
                                    color: Colors.black54,
                                    size: 30,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: CommonText(
                                      text: widget.hotel.otherServices![index],
                                      fontSize: 10,
                                      weight: FontWeight.normal,
                                      maxLines: null, // Allows for unlimited lines
                                      //overflow: TextOverflow.visible, // Ensures text overflows properly
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    0.02.ph,
                  ],
                );
              }
            ),
            // CommonText(
            //   text: 'Other services',
            //   fontSize: 20,
            //   weight: FontWeight.bold,
            // ),
          ],

          RoomsWidget(widget: widget),
// -----------------------------------------------------
          0.02.ph,

          //ReviewWidget(),

// -----------------------------------------------------

          0.05.ph,
          // CustomButton(
          //     height: 35,
          //     width: w,
          //     // text: 'Avail this Flight for \$${total.toStringAsFixed(2)}',
          //     text: "Book",
          //     onPress: () {
          //       // Get.to(() => RoomDetailsScreen(
          //       //   fare: widget.charges.toStringAsFixed(2),
          //       //   tax: widget.tax.toStringAsFixed(2),
          //       //   total: total.toStringAsFixed(2),
          //       //   traveller: widget.traveller,
          //       //   cabinClass: widget.cabinClass,
          //       //   searchID: widget.searchID,
          //       //   flightID: widget.flightID,
          //       //   departFlight: widget.departFlight,
          //       //   arriveFlight: widget.arriveFlight,
          //       //   departFromDate1: widget.departFromDate1,
          //       //   departFromTime1: widget.departFromTime1,
          //       //   departFromCode1: widget.departFromCode1,
          //       //   departFromDate2: widget.departFromDate2,
          //       //   departFromTime2: widget.departFromTime2,
          //       //   departFromCode2: widget.departFromCode2,
          //       //   arriveToDate1: widget.arriveToDate1,
          //       //   arriveToTime1: widget.arriveToTime1,
          //       //   arriveToCode1: widget.arriveToCode1,
          //       //   arriveToDate2: widget.arriveToDate2,
          //       //   arriveToCode2: widget.arriveToCode2,
          //       //   arriveToTime2: widget.arriveToTime2,
          //       //   paymentID: '',
          //       //   adultCount: widget.adultCount,
          //       //   childCount: widget.childCount,
          //       //   infantCount: widget.infantCount,
          //       //   //
          //       //   child1age: widget.child1age,
          //       //   child2age: widget.child2age,
          //       //   child3age: widget.child3age,
          //       //   child4age: widget.child4age,
          //       //   //
          //       //   infant1age: widget.infant1age,
          //       //   infant2age: widget.infant2age,
          //       //   infant3age: widget.infant3age,
          //       //   infant4age: widget.infant4age,
          //       //   //
          //       // ));
          //       // Get.to(() => PaymentMethodScreen(
          //       // dataController.myLoggedIn.value
          //       //     ? Get.to(() => RoomDetailsScreen(
          //       //   fare: widget.charges.toStringAsFixed(2),
          //       //   tax: widget.tax.toStringAsFixed(2),
          //       //   total: total.toStringAsFixed(2),
          //       //   traveller: widget.traveller,
          //       //   cabinClass: widget.cabinClass,
          //       //   searchID: widget.searchID,
          //       //   flightID: widget.flightID,
          //       //   departFlight: widget.departFlight,
          //       //   arriveFlight: widget.arriveFlight,
          //       //   departFromDate1: widget.departFromDate1,
          //       //   departFromTime1: widget.departFromTime1,
          //       //   departFromCode1: widget.departFromCode1,
          //       //   departFromDate2: widget.departFromDate2,
          //       //   departFromTime2: widget.departFromTime2,
          //       //   departFromCode2: widget.departFromCode2,
          //       //   arriveToDate1: widget.arriveToDate1,
          //       //   arriveToTime1: widget.arriveToTime1,
          //       //   arriveToCode1: widget.arriveToCode1,
          //       //   arriveToDate2: widget.arriveToDate2,
          //       //   arriveToCode2: widget.arriveToCode2,
          //       //   arriveToTime2: widget.arriveToTime2,
          //       //   paymentID: '',
          //       //   adultCount: widget.adultCount,
          //       //   childCount: widget.childCount,
          //       //   infantCount: widget.infantCount,
          //       //   //
          //       //   child1age: widget.child1age,
          //       //   child2age: widget.child2age,
          //       //   child3age: widget.child3age,
          //       //   child4age: widget.child4age,
          //       //   //
          //       //   infant1age: widget.infant1age,
          //       //   infant2age: widget.infant2age,
          //       //   infant3age: widget.infant3age,
          //       //   infant4age: widget.infant4age,
          //       //   //
          //       // ))
          //       //     : Dialogs.showCustomAlertDialog(context,
          //       //     "Please Login\n\nLogin required for flight booking",
          //       //         () {
          //       //       Get.offAll(() => LoginScreen());
          //       //     }, () {
          //       //       Get.back();
          //       //     });
          //       // Get.to(() => PassengerDetailsScreen(
          //       //       fare: widget.charges.toString(),
          //       //       tax: widget.tax.toString(),
          //       //       total: total.toStringAsFixed(2),
          //       //       traveller: widget.traveller,
          //       //       cabinClass: widget.cabinClass,
          //       //       searchID: widget.searchID,
          //       //       flightID: widget.flightID,
          //       //       departFlight: widget.departFlight,
          //       //       arriveFlight: widget.arriveFlight,
          //       //       departFromDate1: widget.departFromDate1,
          //       //       departFromTime1: widget.departFromTime1,
          //       //       departFromCode1: widget.departFromCode1,
          //       //       departFromDate2: widget.departFromDate2,
          //       //       departFromTime2: widget.departFromTime2,
          //       //       departFromCode2: widget.departFromCode2,
          //       //       arriveToDate1: widget.arriveToDate1,
          //       //       arriveToTime1: widget.arriveToTime1,
          //       //       arriveToCode1: widget.arriveToCode1,
          //       //       arriveToDate2: widget.arriveToDate2,
          //       //       arriveToCode2: widget.arriveToCode2,
          //       //       arriveToTime2: widget.arriveToTime2,
          //       //     ));
          //     }),
        ],
      ),
    );
  }
}

class RoomsWidget extends StatelessWidget {
  //RoomsWidget(required this.widget);

  HotelPackageWidget widget;
  RoomsWidget({required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 238 * widget.rooms!.length.toDouble(),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.rooms?.length,
        itemBuilder: (context, index) {
          final roomOption = widget.rooms?[index];
          return Column(
            children: [
              RoomOption(
                room:roomOption,
                roomType: roomOption?.roomDescription ?? '',
                roomDetails: [
                  RoomDetail(
                    title: roomOption?.mealPlan ?? '',
                    price: (roomOption?.currency ?? '') + ' ' + (roomOption?.totalAmount?.toString() ?? ''),
                  ),
                ],
                widget: widget,
              ),
              if (index < widget.rooms!.length - 1) 0.03.ph, // Add space between items
            ],
          );
        },
      ),
    );
  }
}

// class RoomsWidget extends StatelessWidget {
//   const RoomsWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CommonText(
//             text: 'Booking options for: 1 room',
//             fontSize: 20,
//             weight: FontWeight.bold,
//           ),
//           0.02.ph,
//       Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             RoomOption(
//               roomType: 'Standard double room',
//               roomDetails: [
//                 RoomDetail(
//                   title: 'ROOM ONLY',
//                   price: 'US\$31',
//                 ),
//                 RoomDetail(
//                   title: 'BED AND BREAKFAST',
//                   price: 'US\$36',
//                 ),
//               ],
//             ),
//             RoomOption(
//               roomType: 'Deluxe double room',
//               roomDetails: [
//                 RoomDetail(
//                   title: 'ROOM ONLY',
//                   price: 'US\$45',
//                 ),
//                 RoomDetail(
//                   title: 'BED AND BREAKFAST',
//                   price: 'US\$50',
//                 ),
//               ],
//             ),
//           ],
//         ),
//       )
//
//         ],
//       ),
//     );
//   }
// }

class RoomOption extends StatefulWidget {
  final String roomType;
  final List<RoomDetail> roomDetails;
  final HotelPackageWidget widget;
  final Rooms? room;

  RoomOption(
      {required this.roomType,
        required this.roomDetails,
        required this.widget, required this.room});

  @override
  _RoomOptionState createState() => _RoomOptionState();
}

class _RoomOptionState extends State<RoomOption> {
  RoomDetail? selectedRoom;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.roomType,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.bed, color: Colors.green),
              ],
            ),
            SizedBox(height: 8),
            ...widget.roomDetails.map((detail) => Column(
              children: [
                Divider(),
                RoomDetailWidget(
                  room: widget.room,
                  detail: detail,
                  widget: widget.widget,
                  isSelected: selectedRoom == detail,
                  onSelect: () {
                    setState(() {
                      if (selectedRoom == detail) {
                        selectedRoom = null; // Deselect the room if it is already selected
                      } else {
                        widget.widget.roomsList.forEach((element) {
                          element?.rooms?.forEach((e) {
                            if(e.roomId == widget.room?.roomId){
                              var roo = element.clone();
                              roo.rooms?.add(e);
                              widget.widget.widget.selectedRoomsList.add(roo);
                              e.selected = true;
                            }
                          });
                        });
                        selectedRoom = detail; // Select the new room
                      }
                    });
                  },
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class RoomDetail extends StatelessWidget {
  final String title;
  final String price;

  RoomDetail({required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class RoomDetailWidget extends StatefulWidget {
  final RoomDetail detail;
  final HotelPackageWidget widget;
  final Rooms? room;
  final bool isSelected;
  final VoidCallback onSelect;

  RoomDetailWidget({
    required this.detail,
    required this.widget,
    required this.room,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  _RoomDetailWidgetState createState() => _RoomDetailWidgetState();
}

class _RoomDetailWidgetState extends State<RoomDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.detail.title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 30.0,
          child: OutlinedButton(
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('VIEW CONDITIONS'),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.detail.price,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            CustomButton(
              height: 35,
              width: MediaQuery.of(context).size.width / 3,
              text: widget.isSelected ? 'Selected' : 'Select',
              onPress: widget.onSelect,
            ),
          ],
        ),
      ],
    );
  }
}

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: 'Guest reviews',
            fontSize: 20,
            weight: FontWeight.bold,
          ),
          0.02.ph,
          CommonText(
            text: '4.5/10',
            fontSize: 20,
            weight: FontWeight.bold,
          ),
          SizedBox(height: 8),
          chartRow(context, 'Cleanliness', 1.0),
          chartRow(context, 'Staff and Service', 0.8),
          chartRow(context, 'Amenities', 0.6),
          chartRow(context, 'Property conditions and facilities', 0.4),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

Widget chartRow(BuildContext context, String label, double pct) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: Theme.of(context).textTheme.bodyMedium),
      LinearProgressIndicator(
        value: pct,
        minHeight: 11,
        backgroundColor: Colors.grey,
        borderRadius: BorderRadius.circular(7),
        valueColor: const AlwaysStoppedAnimation(AppColors.appColorPrimary),
      )
    ],
  );
}
