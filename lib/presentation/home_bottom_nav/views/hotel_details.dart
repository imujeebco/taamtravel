// ignore_for_file: unnecessary_question_mark

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
import 'package:travel_app/presentation/auth/view/login_screen.dart';
import 'package:travel_app/presentation/home_bottom_nav/controller/flight_fare_rule_controller.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/passenger_details.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/room_details.dart';

import '../../../app/data/data_controller.dart';
import '../../../app/utils/custom_functions/app_alerts.dart';

// ignore: must_be_immutable
class HotelDetailsScreen extends StatefulWidget {
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

  HotelDetailsScreen({
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
  State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {
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
        title: 'Hotel Details',
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
                                  HotelPackageWidget(
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
            // HotelPackageWidget(name: 'Saver',),
          ],
        ),
      ),
    );
  }
}

///////////////////////////// HotelPackageWidget /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
// ignore: must_be_immutable
class HotelPackageWidget extends StatefulWidget {
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

  HotelPackageWidget({
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
    dynamic? total = widget.charges + widget.tax!;
    Size size = MediaQuery.of(context).size;
    List<String> servicesList = ["Luggage room", "Wi-fi", "Airport Shuttle","Restaurant","Bicycle rentals","BBQ Facilities"];
    List<IconData> servicesIcon = [Icons.luggage_outlined,Icons.wifi,Icons.airport_shuttle_outlined,Icons.restaurant,Icons.pedal_bike_outlined,Icons.outdoor_grill_outlined];

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
            text: 'Karachi',
            weight: FontWeight.bold,
            fontSize: 12.0,
            color: AppColors.appColorPrimary,
          ),

          // -----------------------------
          0.02.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonText(
                text: 'GOHO Rooms Badar',
                fontSize: 15,
                weight: FontWeight.w600,
              ),
              Icon(Icons.star,color: Color.fromRGBO(236, 171, 71, 1),size: 15),
              Icon(Icons.star,color: Color.fromRGBO(236, 171, 71, 1),size: 15),
              Icon(Icons.star,color: Color.fromRGBO(236, 171, 71, 1),size: 15),
              Icon(Icons.star,size: 15,),
              Icon(Icons.star,size: 15),
            ],
          ),
          0.02.ph,
// -----------------------------------------------------
          CommonText(
            text: '171 Frere RoadClarke St. Shahrah e Iraq, Saddar, Karachi 74400,',
            fontSize: 11,
            weight: FontWeight.normal,
          ),
          CommonText(
            text: '7.62 km from Center',
            fontSize: 11,
            weight: FontWeight.bold,
          ),
          0.02.ph,

          // -----------------------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Icon(Icons.share_outlined,color:Colors.black,size: 20)
              ),
              0.02.pw,
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Icon(Icons.favorite_border,color:Colors.black,size: 20)
              ),
            ],
          ),

          0.02.ph,
// -----------------------------------------------------
          // -----------------------------------------------------
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CarouselSlider(
              items: [
                Image.network('https://cdn5.travelconline.com/unsafe/fit-in/2000x0/filters:quality(75):format(webp)/https%3A%2F%2Fi.travelapi.com%2Flodging%2F91000000%2F90120000%2F90113500%2F90113432%2F0ee5b7ff_z.jpg',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover),
                Image.network('https://cdn5.travelconline.com/unsafe/fit-in/2000x0/filters:quality(75):format(webp)/https%3A%2F%2Fi.travelapi.com%2Flodging%2F91000000%2F90120000%2F90113500%2F90113432%2Fb4a24cb4_z.jpg',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover),
                Image.network('https://cdn5.travelconline.com/unsafe/fit-in/2000x0/filters:quality(75):format(webp)/https%3A%2F%2Fi.travelapi.com%2Flodging%2F91000000%2F90120000%2F90113500%2F90113432%2Ff3d623e5_z.jpg',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover),
              ],
              options: CarouselOptions(
                viewportFraction: 1,
                height: size.height*0.3, // Customize the height of the carousel
                autoPlay: true, // Enable auto-play
                enlargeCenterPage: false, // Increase the size of the center item
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
            'Make yourself at home in one of the 80 air-conditioned '
                'rooms featuring refrigerators and LED televisions. '
                'Complimentary wireless internet access keeps you '
                'connected, and cable programming is available for '
                'your entertainment. Bathrooms with separate bathtubs '
                'and showers feature jetted bathtubs and rainfall '
                'showerheads. Conveniences include phones, as well '
                'as safes and complimentary newspapers.\n\n'
                'Take advantage of recreation opportunities such as '
                'a fitness center, or other amenities including '
                'complimentary wireless internet access and concierge '
                'services. Additional amenities at this hotel include'
                ' babysitting (surcharge), wedding services, and a '
                'picnic area. Guests can get around on the shuttle '
                '(surcharge), which operates within 9 miles.\n\n'
                'Stop by the hotel\'s restaurant, Ruby restaurant, '
                'for lunch or dinner. Dining is also available at '
                'the coffee shop/cafe, and 24-hour room service is '
                'provided. Mingle with other guests at the '
                'complimentary reception, held daily. Wrap up your '
                'day with a drink at the bar/lounge. A complimentary '
                'buffet breakfast is served daily from 7 AM to 11 AM.\n\n'
                'Featured amenities include a 24-hour business center,'
                ' complimentary newspapers in the lobby, and dry '
                'cleaning/laundry services. Planning an event in '
                'Karachi? This hotel has 1550 square feet '
                '(144 square meters) of space consisting of a '
                'conference center and meeting rooms. Guests may use '
                'a train station pick-up service for a surcharge, '
                'and free valet parking is available onsite.',
            trimMode: TrimMode.Line,
            trimLines: 4,
            colorClickableText: Colors.pink,
            trimCollapsedText: 'Read more',
            trimExpandedText: 'Read less',
            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          0.02.ph,
          CommonText(
            text: 'Main services',
            fontSize: 20,
            weight: FontWeight.bold,
          ),
          0.02.ph,
          Container(
            height: 34 * servicesList.length.toDouble(),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of items in each row
                mainAxisSpacing: 8.0, // spacing between rows
                crossAxisSpacing: 8.0,
                childAspectRatio: (1 / .4),

              ),
              padding: EdgeInsets.all(8.0), // padding around the grid
              itemCount: servicesList.length, // total number of items
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
                          child: Icon(servicesIcon[index],color:Colors.black54,size: 30),
                        ),
                        CommonText(
                          text: servicesList[index],
                          fontSize: 10,
                          weight: FontWeight.normal,
                        ),
                      ],
                    )
                );
              },
            ),
          ),
          0.02.ph,
          RoomsWidget(widget: widget),
// -----------------------------------------------------
          0.02.ph,

          ReviewWidget(),


// -----------------------------------------------------

          0.05.ph,
          CustomButton(
              height: 35,
              width: w,
              // text: 'Avail this Flight for \$${total.toStringAsFixed(2)}',
              text: "Book",
              onPress: () {

                Get.to(() => RoomDetailsScreen(
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
                ));
                // Get.to(() => PaymentMethodScreen(
                // dataController.myLoggedIn.value
                //     ? Get.to(() => RoomDetailsScreen(
                //   fare: widget.charges.toStringAsFixed(2),
                //   tax: widget.tax.toStringAsFixed(2),
                //   total: total.toStringAsFixed(2),
                //   traveller: widget.traveller,
                //   cabinClass: widget.cabinClass,
                //   searchID: widget.searchID,
                //   flightID: widget.flightID,
                //   departFlight: widget.departFlight,
                //   arriveFlight: widget.arriveFlight,
                //   departFromDate1: widget.departFromDate1,
                //   departFromTime1: widget.departFromTime1,
                //   departFromCode1: widget.departFromCode1,
                //   departFromDate2: widget.departFromDate2,
                //   departFromTime2: widget.departFromTime2,
                //   departFromCode2: widget.departFromCode2,
                //   arriveToDate1: widget.arriveToDate1,
                //   arriveToTime1: widget.arriveToTime1,
                //   arriveToCode1: widget.arriveToCode1,
                //   arriveToDate2: widget.arriveToDate2,
                //   arriveToCode2: widget.arriveToCode2,
                //   arriveToTime2: widget.arriveToTime2,
                //   paymentID: '',
                //   adultCount: widget.adultCount,
                //   childCount: widget.childCount,
                //   infantCount: widget.infantCount,
                //   //
                //   child1age: widget.child1age,
                //   child2age: widget.child2age,
                //   child3age: widget.child3age,
                //   child4age: widget.child4age,
                //   //
                //   infant1age: widget.infant1age,
                //   infant2age: widget.infant2age,
                //   infant3age: widget.infant3age,
                //   infant4age: widget.infant4age,
                //   //
                // ))
                //     : Dialogs.showCustomAlertDialog(context,
                //     "Please Login\n\nLogin required for flight booking",
                //         () {
                //       Get.offAll(() => LoginScreen());
                //     }, () {
                //       Get.back();
                //     });
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
      height: 800,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          RoomOption(
            roomType: 'Standard double room',
            roomDetails: [
              RoomDetail(
                title: 'ROOM ONLY',
                price: 'US\$31',
              ),
              RoomDetail(
                title: 'BED AND BREAKFAST',
                price: 'US\$36',
              ),
            ], widget: widget,
          ),
          0.03.ph,
          RoomOption(
            roomType: 'Deluxe double room',
            roomDetails: [
              RoomDetail(
                title: 'ROOM ONLY',
                price: 'US\$45',
              ),
            ], widget: widget,
          ),
        ],
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

class RoomOption extends StatelessWidget {
  final String roomType;
  final List<RoomDetail> roomDetails;
  HotelPackageWidget widget;

  RoomOption({required this.roomType, required this.roomDetails, required this.widget});

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
                    roomType,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.bed, color: Colors.green),
              ],
            ),
            SizedBox(height: 8),
            ...roomDetails.map((detail) => Column(
              children: [
                Divider(),
                RoomDetailWidget(detail: detail,widget: widget,),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.local_offer, size: 16),
            SizedBox(width: 4),
            Text('Package Rate'),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.close, size: 16),
            SizedBox(width: 4),
            Text('Non refundable'),
          ],
        ),
        SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('VIEW CONDITIONS'),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              price,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Get.to(() => RoomDetailsScreen(
                //   fare: widget.charges.toStringAsFixed(2),
                //   tax: widget.tax.toStringAsFixed(2),
                //   total: "45",
                //   traveller: widget.traveller,
                //   cabinClass: widget.cabinClass,
                //   searchID: widget.searchID,
                //   flightID: widget.flightID,
                //   departFlight: widget.departFlight,
                //   arriveFlight: widget.arriveFlight,
                //   departFromDate1: widget.departFromDate1,
                //   departFromTime1: widget.departFromTime1,
                //   departFromCode1: widget.departFromCode1,
                //   departFromDate2: widget.departFromDate2,
                //   departFromTime2: widget.departFromTime2,
                //   departFromCode2: widget.departFromCode2,
                //   arriveToDate1: widget.arriveToDate1,
                //   arriveToTime1: widget.arriveToTime1,
                //   arriveToCode1: widget.arriveToCode1,
                //   arriveToDate2: widget.arriveToDate2,
                //   arriveToCode2: widget.arriveToCode2,
                //   arriveToTime2: widget.arriveToTime2,
                //   paymentID: '',
                //   adultCount: widget.adultCount,
                //   childCount: widget.childCount,
                //   infantCount: widget.infantCount,
                //   //
                //   child1age: widget.child1age,
                //   child2age: widget.child2age,
                //   child3age: widget.child3age,
                //   child4age: widget.child4age,
                //   //
                //   infant1age: widget.infant1age,
                //   infant2age: widget.infant2age,
                //   infant3age: widget.infant3age,
                //   infant4age: widget.infant4age,
                //   //
                // ));
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text('Select'),
            ),
          ],
        ),
      ],
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Room Selection')),
//         body:
//       ),
//     );
//   }
// }



class RoomDetailWidget extends StatelessWidget {
  final RoomDetail detail;
  final HotelPackageWidget widget;

  RoomDetailWidget({required this.detail, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          detail.title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.local_offer, size: 16),
            SizedBox(width: 4),
            Text('Package Rate'),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.close, size: 16),
            SizedBox(width: 4),
            Text('Non refundable'),
          ],
        ),
        SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('VIEW CONDITIONS'),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              detail.price,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => RoomDetailsScreen(
                  fare: widget.charges.toStringAsFixed(2),
                  tax: widget.tax.toStringAsFixed(2),
                  total: "45",
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
                ));
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text('Select',style: TextStyle(color: Colors.white) ),
            ),
          ],
        ),
      ],
    );
  }
}

