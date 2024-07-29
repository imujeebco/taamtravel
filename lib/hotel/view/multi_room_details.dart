// ignore_for_file: must_be_immutable, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:readmore/readmore.dart';
import 'package:travel_app/airline/home_bottom_nav/views/passenger_details.dart';
import 'package:travel_app/hotel/view/passenger_details_hotel.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/hotel/view/passenger_details_multi_hotel.dart';
import '../../airline/auth/view/login_screen.dart';
import '../../app/data/data_controller.dart';
import '../../app/utils/custom_functions/app_alerts.dart';
import '../model/booking_request.dart';
import 'Hotel_tabs/search_hotel_model.dart';
import 'Hotel_tabs/search_room_model.dart';

class MultiRoomDetailsScreen extends StatefulWidget {
  Map dataMap;
  List<SearchHotelModel?> hotel;
  String searchId;
  List<SearchRoomModel?> room;
  final List<BookingRequest> multiAccom;

  int totalAdults = 0;
  int totalChildrenAndInfant = 0;

  MultiRoomDetailsScreen({
    super.key,
    required this.dataMap,
    required this.hotel,
    required this.searchId,
    required this.room,
    required this.multiAccom
  });

  @override
  State<MultiRoomDetailsScreen> createState() => _MultiRoomDetailsScreenState();
}

class _MultiRoomDetailsScreenState extends State<MultiRoomDetailsScreen> {
  final DataController dataController = Get.put(DataController());
  String? requestedAge = "";
  String phoneNumber = '';
  String phoneCode = '+1';
  String countryCode = 'US';
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  bool isValidForm = false;

  BookingRequest bookingRequest = BookingRequest();

  @override
  void initState() {
    super.initState();
    // String jsonString = jsonEncode(widget.dataMap);

    bookingRequest = widget.multiAccom[0]; //BookingRequest.fromJson(json.decode(jsonString));
    // Calculate total adults and total children and infants

    // Check if rooms is not null before iterating
    if (bookingRequest.rooms != null) {
      for (Room room in bookingRequest.rooms!) {
        widget.totalAdults += room.adults;
        widget.totalChildrenAndInfant += room.childrenAndInfant;
      }
    }
    // print('Total Adults: ${}widget.totalAdults');
    // print('Total Children and Infants: $totalChildrenAndInfant');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      dataController.loadMyData();
    });
  }

  String _formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('E, d MMM y').format(date);
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Your Trip Details',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.people),
                  SizedBox(width: 8),
                  Text('${widget.totalAdults} Adults ${widget.totalChildrenAndInfant > 0 ? '+ ${widget.totalChildrenAndInfant}'  : '' }'),
                ],
              ),
              Column(
                children: widget.multiAccom.map((e) =>
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.pin_drop),
                            SizedBox(width: 8),
                            Text(e.city ?? ''),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.calendar_today),
                            SizedBox(width: 8),
                            Text('${_formatDate(e.checkIn ?? '')} - ${_formatDate(e.checkOut ?? '')}'),
                          ],
                        )
                      ],
                    ),
                ).toList(),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('Change your trip'),
              ),
              SizedBox(height: 16),
        Column(
          children: widget.hotel.asMap().entries.map((entry) {
            int index = entry.key;
            var e = entry.value;

            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.pin_drop),
                          SizedBox(width: 8),
                          Text(widget.multiAccom[index].city ?? ''),
                        ],
                      ),
                      Text(
                        e?.hotels?[0].hotelName ?? '',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          if (e?.hotels?[0].category == 'S1') ...[
                            Icon(Icons.star,
                                color: Color.fromRGBO(236, 171, 71, 1)),
                          ],
                          if (e?.hotels?[0].category == 'S2') ...[
                            Icon(Icons.star,
                                color: Color.fromRGBO(236, 171, 71, 1)),
                            Icon(Icons.star,
                                color: Color.fromRGBO(236, 171, 71, 1)),
                          ],
                          if (e?.hotels?[0].category == 'S3') ...[
                            Icon(Icons.star,
                                color: Color.fromRGBO(236, 171, 71, 1)),
                            Icon(Icons.star,
                                color: Color.fromRGBO(236, 171, 71, 1)),
                            Icon(Icons.star,
                                color: Color.fromRGBO(236, 171, 71, 1)),
                          ],
                          if (e?.hotels?[0].category == 'S4') ...[
                            Icon(Icons.star,
                                color: Color.fromRGBO(236, 171, 71, 1)),
                            Icon(Icons.star,
                                color: Color.fromRGBO(236, 171, 71, 1)),
                            Icon(Icons.star,
                                color: Color.fromRGBO(236, 171, 71, 1)),
                            Icon(Icons.star,
                                color: Color.fromRGBO(236, 171, 71, 1)),
                          ],
                          if (e?.hotels?[0].category == 'S5') ...[
                            Icon(Icons.star,
                                color: Color.fromRGBO(236, 171, 71, 1)),
                            Icon(Icons.star,
                                color: Color.fromRGBO(236, 171, 71, 1)),
                            Icon(Icons.star,
                                color: Color.fromRGBO(236, 171, 71, 1)),
                            Icon(Icons.star,
                                color: Color.fromRGBO(236, 171, 71, 1)),
                            Icon(Icons.star,
                                color: Color.fromRGBO(236, 171, 71, 1)),
                          ],
                        ],
                      ),
                      SizedBox(height: 8),
                      Column(
                          children: widget.room[index]!.rooms!.map((r) =>
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.bed),
                                      SizedBox(width: 8),
                                      Text(r.roomDescription ?? ''),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.restaurant),
                                      SizedBox(width: 8),
                                      Text(r.mealPlan ?? ''),
                                    ],
                                  ),
                                ],
                              ),

                          ).toList()),

                      SizedBox(height: 8),
                      ReadMoreText(
                        e?.hotels?[0].description ?? '',
                        trimMode: TrimMode.Line,
                        trimLines: 4,
                        colorClickableText: Colors.pink,
                        trimCollapsedText: 'Read more',
                        trimExpandedText: 'Read less',
                        moreStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        lessStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                             'Price: ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                              '${widget.room[index]!.rooms![0].currency} ${widget.room[index]!.rooms![0].totalAmount.toString()}'
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ],
            );
          }).toList(),
        ),

              SizedBox(height: 16),
              ConfirmTripCard(
                multiAccom: widget.multiAccom,
                rooms: widget.room,
                checkIn: bookingRequest.checkIn ?? '',
                checkOut: bookingRequest.checkIn ?? '',
                destination: bookingRequest.destination ?? '',
                adultCount: widget.totalAdults,
                childCount: widget.totalChildrenAndInfant,
                infantCount: 0,
                child1age: 0,
                child2age: 0,
                child3age: 0,
                child4age: 0,
                infant1age: 0,
                infant2age: 0,
                infant3age: 0,
                infant4age: 0
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmTripCard extends StatelessWidget {
  List<SearchRoomModel?> rooms;
  List<BookingRequest> multiAccom;
  //
  String checkIn;
  String checkOut;
  String destination;
  double total = 0.0;
  //
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

  ConfirmTripCard({
    super.key,
    required this.rooms,
    required this.multiAccom,
    //
    required this.checkIn,
    required this.checkOut,
    required this.destination,
    //
    required this.adultCount,
    required this.childCount,
    required this.infantCount,
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

  // ConfirmTripCard({
  //   required this.amount,
  //   super.key,
  // });
  @override
  Widget build(BuildContext context) {
    final DataController dataController = Get.put(DataController());

    rooms.forEach((element) {
      element?.rooms?.forEach((e) {
        var tot = e.totalAmount.toString();
        total += double.parse(tot);
      });
    });
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'CONFIRM TRIP:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.credit_card, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Total price',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    total.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.save),
              label: Text('Save'),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[200],
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 48),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                dataController.myLoggedIn.value
                    ?
                Get.to(() => PassengerDetailsMultiHotelScreen(
                  multiAccom: multiAccom,
                  checkIn: checkIn,
                  checkOut: checkOut,
                  destination: destination,
                  adultCount: adultCount,
                  childCount: childCount,
                  infantCount: infantCount,
                  total: total.toString(),
                  child1age: child1age,
                  child2age: child2age,
                  child3age: child3age,
                  child4age: child4age,
                  infant1age: infant1age,
                  infant2age: infant2age,
                  infant3age: infant3age,
                  infant4age: infant4age,
                  rooms:rooms,
                  //
                ))
                    : Dialogs.showCustomAlertDialog(context,
                    "Please Login\n\nLogin required for flight booking",
                        () {
                      Get.offAll(() => LoginScreen());
                    }, () {
                      Get.back();
                    });
              },
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}