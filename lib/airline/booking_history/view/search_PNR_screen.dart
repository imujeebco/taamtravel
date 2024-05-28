// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:travel_app/airline/booking_history/view/my_bookings_screen.dart';

import '../../../app/configs/app_colors.dart';
import '../../../app/configs/app_size_config.dart';
import '../../../app/utils/custom_widgets/common_text.dart';
import '../../../app/utils/custom_widgets/custom_appbar.dart';
import '../../../app/utils/custom_widgets/custom_button.dart';
import '../../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../controller/search_PNR_controller.dart';
import '../controller/share_ticket_controller.dart';
import '../model/search_PNR_model.dart';

class SearchPNRScreen extends StatefulWidget {
  const SearchPNRScreen({super.key});

  @override
  State<SearchPNRScreen> createState() => _SearchPNRScreenState();
}

class _SearchPNRScreenState extends State<SearchPNRScreen> {
  final searchController = TextEditingController();
  final SearchPNRController searchPNRController =
      Get.put(SearchPNRController());
  final Rx<SearchPNRModel> searchPNRModel = SearchPNRModel().obs;
  final RxList<SearchPNRModel> PNRList = <SearchPNRModel>[].obs;
  final RxBool isLoading = false.obs;

  String? formattedDate = "";
  String? formattedTime = "";

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

    return formattedDate;
  }

  String formatTime(String dateTimeString) {
    // Parse the input date and time string
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the time
    String formattedTime =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

    return formattedTime;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // searchPNRController.fetchPNR();
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
      appBar: CustomAppBar(title: "Search PNR"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColors.appColorPrimary.withOpacity(0.1),
              ),
              child: TextField(
                autofocus: true,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search PNR',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
                controller: searchController,
                onSubmitted: (value) {
                  searchPNRController.fetchPNR(searchController.text.trim());
                },
              ),
            ),
            searchController.text.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_rounded,
                          size: 88,
                          color: Colors.grey,
                        ),
                        Text("Search for PNR",
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 24,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  )
                : Obx(() {
                    if (searchPNRController.isLoading.value) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (searchPNRController.searchPNRModel.value.flights ==
                          null) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.warning_rounded,
                                size: 88,
                                color: Colors.grey,
                              ),
                              Text("No Result Found",
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        );
                      } else {
                        var data1 =
                            searchPNRController.searchPNRModel.value.flights;
                        var data0 = searchPNRController.searchPNRModel.value;
                        return Expanded(
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: data1!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: DottedBorder(
                                      dashPattern: [10, 8],
                                      strokeWidth: 1,
                                      color: AppColors.appColorPrimary,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            15.0, 15, 15, 30),
                                        margin: const EdgeInsets.all(20.0),
                                        // height: h * 0.43,
                                        decoration:
                                            BoxDecoration(color: Colors.white),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // 1st  FROM TO ------------------------------------------------
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    CommonText(text: "Ref."),
                                                    CommonText(
                                                      text:
                                                          " ${data0.bookingReference}",
                                                      weight: FontWeight.bold,
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    CommonText(text: "PNR"),
                                                    CommonText(
                                                      text:
                                                          " ${data0.parentPnr}",
                                                      weight: FontWeight.bold,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            0.02.ph,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                FromToFlightWidget(
                                                  date: formatDate(data1[index]
                                                      .outBound!
                                                      .departureDateTime
                                                      .toString()),
                                                  time: formatTime(data1[index]
                                                      .outBound!
                                                      .departureDateTime
                                                      .toString()),
                                                  city:
                                                      '${data1[index].outBound!.departure}',
                                                ),
                                                Column(
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons.plane,
                                                      color: AppColors
                                                          .appColorPrimary,
                                                      size: 20.0,
                                                    ),
                                                    // 0.01.ph,
                                                    // CommonText(
                                                    //   text:
                                                    //       bookings.tripType.toString(),
                                                    //   fontSize: 10.0,
                                                    // )
                                                  ],
                                                ),
                                                FromToFlightWidget(
                                                  date: formatDate(data1[index]
                                                      .inBound!
                                                      .arrivalDateTime
                                                      .toString()),
                                                  time: formatTime(data1[index]
                                                      .inBound!
                                                      .arrivalDateTime
                                                      .toString()),
                                                  city:
                                                      '${data1[index].inBound!.arrival}',
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CommonText(
                                                  text: 'Fare',
                                                  fontSize: 11,
                                                ),
                                                CommonText(
                                                  text:
                                                      '\$ ${data0.ticketAmount}',
                                                  fontSize: 11,
                                                ),
                                              ],
                                            ),
                                            0.02.ph,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CommonText(
                                                  text: 'Taxes and Fees',
                                                  fontSize: 11,
                                                ),
                                                CommonText(
                                                  text: '\$ ${data0.taxAmount}',
                                                  fontSize: 11,
                                                ),
                                              ],
                                            ),
                                            0.02.ph,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CommonText(
                                                  text: 'Agency Charges',
                                                  fontSize: 11,
                                                ),
                                                CommonText(
                                                  text:
                                                      '\$ ${data0.agencyMarkup}',
                                                  fontSize: 11,
                                                ),
                                              ],
                                            ),
                                            0.02.ph,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CommonText(
                                                  text: 'Total Charges',
                                                  fontSize: 11,
                                                  weight: FontWeight.w700,
                                                ),
                                                CommonText(
                                                  text:
                                                      '\$ ${data0.totalAmount}',
                                                  fontSize: 11,
                                                  weight: FontWeight.w700,
                                                ),
                                              ],
                                            ),
                                            0.02.ph,
                                            Divider(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CommonText(text: "Status"),
                                                CommonText(
                                                    text: "${data0.status}",
                                                    weight: FontWeight.w500),
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
                                                    builder:
                                                        (BuildContext context) {
                                                      return SingleChildScrollView(
                                                        child: Container(
                                                            padding: EdgeInsets.only(
                                                                bottom: MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                            child: BottomSheetWidget(
                                                                pnr:
                                                                    "${data0.parentPnr}")),
                                                      );
                                                    },
                                                  );
                                                })
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }));
                      }
                    }
                  })
          ],
        ),
      ),
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
  final ShareTicketController shareTicketController =
      Get.put(ShareTicketController());
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
                CommonText(
                    text: "Share Ticket",
                    weight: FontWeight.w400,
                    fontSize: 18),
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
                      RegExp emailRegExp =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (emailController.text.trim().isEmpty) {
                        Get.showSnackbar(gradientSnackbar(
                            "Error",
                            "Email field is empty",
                            AppColors.orange,
                            Icons.warning_rounded));
                      } else if (!emailRegExp
                          .hasMatch(emailController.text.trim())) {
                        Get.showSnackbar(gradientSnackbar(
                            "Error",
                            "Please type a valid email",
                            AppColors.orange,
                            Icons.warning_rounded));
                      } else {
                        shareTicketController.shareTicket(
                            widget.pnr.toString(), emailController.text.trim());
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
