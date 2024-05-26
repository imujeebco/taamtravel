// ignore_for_file: must_be_immutable, camel_case_types

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/presentation/booking_history/view/search_PNR_screen.dart';

import '../../../app/data/data_controller.dart';
import '../../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../../auth/view/login_screen.dart';
import '../controller/booking_history_controller.dart';
import '../controller/share_ticket_controller.dart';
import '../model/booking_history_model.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final DataController dataController = Get.put(DataController());
  final BookingHistoryController bookingHistoryController = Get.put(BookingHistoryController());
  final Rx<BookingHistoryModel> bookingHistoryModel = BookingHistoryModel().obs;
  final RxList<BookingHistoryModel> bookingHistoryList = <BookingHistoryModel>[].obs;
  final RxBool isLoading = false.obs;
  String? formattedDate = "";
  String? formattedTime = "";

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

    return formattedDate;
  }

  String formatTime(String dateTimeString) {
    // Parse the input date and time string
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the time
    String formattedTime = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

    return formattedTime;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookingHistoryController.fetchBookings();
      dataController.loadMyData();
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
        body: dataController.myLoggedIn.value
            ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SearchBar(),
                    ),
                  ),
                  Expanded(
                    child: Obx(() {
                      if (bookingHistoryController.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return bookingHistoryController.bookingHistoryList.isEmpty
                            ? Center(
                                child: Text('No Bookings Available'),
                              )
                            : ListView.builder(
                                itemCount: bookingHistoryController.bookingHistoryList.length,
                                itemBuilder: (context, index) {
                                  var bookings = bookingHistoryController.bookingHistoryList[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: DottedBorder(
                                      dashPattern: [10, 8],
                                      strokeWidth: 1,
                                      color: AppColors.appColorPrimary,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(15.0, 15, 15, 30),
                                        margin: const EdgeInsets.all(20.0),
                                        // height: h * 0.43,
                                        decoration: BoxDecoration(color: Colors.white),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // 1st  FROM TO ------------------------------------------------
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    CommonText(text: "ID "),
                                                    CommonText(
                                                      text: " ${bookings.bookingId}",
                                                      weight: FontWeight.bold,
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    CommonText(text: "PNR"),
                                                    CommonText(
                                                      text: " ${bookings.parentPnr}",
                                                      weight: FontWeight.bold,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            0.02.ph,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                FromToFlightWidget(
                                                  date: formatDate(bookings.departureDateTime.toString()),
                                                  time: formatTime(bookings.departureDateTime.toString()),
                                                  city: '${bookings.departure}',
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
                                                      text: bookings.tripType.toString(),
                                                      fontSize: 10.0,
                                                    )
                                                  ],
                                                ),
                                                FromToFlightWidget(
                                                  date: formatDate(bookings.arrivalDateTime.toString()),
                                                  time: formatTime(bookings.arrivalDateTime.toString()),
                                                  city: '${bookings.arrival}',
                                                ),
                                              ],
                                            ),
                                            0.08.ph,
                                            CommonText(
                                              text: 'Fare Information',
                                              weight: FontWeight.w600,
                                            ),
                                            0.02.ph,
                                            // CommonText(
                                            //   text: 'Adult x 01',
                                            //   fontSize: 11,
                                            // ),
                                            // 0.02.ph,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                CommonText(
                                                  text: 'Fare',
                                                  fontSize: 11,
                                                ),
                                                CommonText(
                                                  text: '\$ ${bookings.ticketAmount}',
                                                  fontSize: 11,
                                                ),
                                              ],
                                            ),
                                            0.02.ph,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                CommonText(
                                                  text: 'Taxes and Fees',
                                                  fontSize: 11,
                                                ),
                                                CommonText(
                                                  text: '\$ ${bookings.taxAmount}',
                                                  fontSize: 11,
                                                ),
                                              ],
                                            ),
                                            0.02.ph,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                CommonText(
                                                  text: 'Agency Charges',
                                                  fontSize: 11,
                                                ),
                                                CommonText(
                                                  text: '\$ ${bookings.agencyMarkup}',
                                                  fontSize: 11,
                                                ),
                                              ],
                                            ),
                                            0.02.ph,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                CommonText(
                                                  text: 'Other Charges',
                                                  fontSize: 11,
                                                ),
                                                CommonText(
                                                  text: '\$ 20',
                                                  fontSize: 11,
                                                ),
                                              ],
                                            ),

                                            // 0.02.ph,
                                            Divider(color: Colors.black),

                                            0.02.ph,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                CommonText(
                                                  text: 'Total Charges',
                                                  fontSize: 11,
                                                  weight: FontWeight.w700,
                                                ),
                                                CommonText(
                                                  text: '\$ ${bookings.totalAmount}',
                                                  fontSize: 11,
                                                  weight: FontWeight.w700,
                                                ),
                                              ],
                                            ),
                                            0.02.ph,
                                            Divider(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                CommonText(text: "Status"),
                                                CommonText(text: "${bookings.status}", weight: FontWeight.w500),
                                              ],
                                            ),
                                            Divider(),
                                            0.02.ph,
                                            CustomButton(
                                                height: 40,
                                                width: w,
                                                text: 'Share',
                                                onPress: () {
                                                  showModalBottomSheet(
                                                    enableDrag: true,
                                                    isScrollControlled: true,
                                                    showDragHandle: true,
                                                    useSafeArea: true,
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return SingleChildScrollView(
                                                        child: Container(
                                                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                            child: BottomSheetWidget(pnr: "${bookings.parentPnr}")),
                                                      );
                                                    },
                                                  );
                                                })
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                      }
                    }),
                  ),
                ],
              )
            : Padding(
                padding: EdgeInsets.all(20),
                child: GotoLoginWidget(),
              ));
  }
}

class GotoLoginWidget extends StatelessWidget {
  const GotoLoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          // height: 140,
          width: 160,
          child: Image(
            image: AssetImage("assets/icons/logo.png"),
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 20),
        CommonText(
          text: "Start Your Journey",
          weight: FontWeight.w500,
          fontSize: 18,
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CommonText(
              text: "You will find great deals with reasonable fares for your desired destinations with Taam Travel",
              weight: FontWeight.w300,
              textAlign: TextAlign.center,
              fontSize: 15),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
                height: 40,
                width: 240,
                text: 'Login',
                onPress: () {
                  Get.offAll(() => LoginScreen());
                }),
          ],
        )
      ],
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
  String? pnr;
  BottomSheetWidget({super.key, required this.pnr});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  TextEditingController emailController = TextEditingController();
  final ShareTicketController shareTicketController = Get.put(ShareTicketController());
  final RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Obx(() {
          if (shareTicketController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommonText(text: "Share Ticket", weight: FontWeight.w400, fontSize: 18),
                SizedBox(height: 5.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColors.appColorPrimary.withOpacity(0.1),
                  ),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'example@email.com',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: 16.0),
                CustomButton(
                    height: 40,
                    width: w,
                    text: 'Share',
                    onPress: () {
                      RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (emailController.text.trim().isEmpty) {
                        Get.showSnackbar(gradientSnackbar("Error", "Email field is empty", AppColors.orange, Icons.warning_rounded));
                      } else if (!emailRegExp.hasMatch(emailController.text.trim())) {
                        Get.showSnackbar(gradientSnackbar("Error", "Please type a valid email", AppColors.orange, Icons.warning_rounded));
                      } else {
                        shareTicketController.shareTicket(widget.pnr.toString(), emailController.text.trim());
                      }
                    })
              ],
            );
          }
        }),
      ),
    );
  }
}

class FlightSummaryWidget extends StatelessWidget {
  const FlightSummaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [10, 8],
      strokeWidth: 1,
      color: AppColors.appColorPrimary,
      child: Container(
        padding: EdgeInsets.fromLTRB(15.0, 15, 15, 30),
        margin: const EdgeInsets.all(20.0),
        // height: h * 0.43,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1st  FROM TO ------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FromToFlightWidget(
                  date: 'Fri 29 Dec 23',
                  time: '19:30',
                  city: 'CAI',
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
                      text: 'EK06',
                      fontSize: 12.0,
                    )
                  ],
                ),
                FromToFlightWidget(
                  date: 'Sat 29 Dec 23',
                  time: '22:30',
                  city: 'DXB',
                ),
              ],
            ),
            0.04.ph,
            CommonText(
              text: 'Fare Information',
              weight: FontWeight.w600,
            ),
            0.02.ph,
            CommonText(
              text: 'Adult x 01',
              fontSize: 11,
            ),
            0.02.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Fare',
                  fontSize: 11,
                ),
                CommonText(
                  text: '\$ 125',
                  fontSize: 11,
                ),
              ],
            ),
            0.02.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Taxes and Fees',
                  fontSize: 11,
                ),
                CommonText(
                  text: '\$ 2',
                  fontSize: 11,
                ),
              ],
            ),
            0.02.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Extra Baggage',
                  fontSize: 11,
                ),
                CommonText(
                  text: '\$ 20',
                  fontSize: 11,
                ),
              ],
            ),

            0.02.ph,
            Divider(color: Colors.black),

            0.02.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Total Charges',
                  fontSize: 11,
                  weight: FontWeight.w700,
                ),
                CommonText(
                  text: '\$ 147',
                  fontSize: 11,
                  weight: FontWeight.w700,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FromToFlightWidget extends StatelessWidget {
  const FromToFlightWidget({
    required this.time,
    required this.date,
    required this.city,
    super.key,
  });

  final String date, time, city;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: date, //'Fri 29 Dec 23',
          fontSize: 10.0,
        ),
        0.005.ph,
        CommonText(
          text: time, //'19:30',
          fontSize: 20.0,
          weight: FontWeight.bold,
        ),
        0.005.ph,
        CommonText(
          text: city, //'CAI',
          fontSize: 16.0,
          weight: FontWeight.w600,
        ),
      ],
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.appColorPrimary.withOpacity(0.1),
      ),
      child: TextField(
        onTap: () {
          Get.to(() => SearchPNRScreen());
        },
        readOnly: true,
        decoration: InputDecoration(
          hintText: 'Search PNR',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.0),
        ),
        onChanged: (value) {},
      ),
    );
  }
}
