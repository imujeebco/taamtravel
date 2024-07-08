// ignore_for_file: must_be_immutable, camel_case_types, unrelated_type_equality_checks

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_toast.dart';
import 'package:travel_app/app/utils/custom_widgets/gradient_snackbar.dart';

import 'package:intl/intl.dart';
import '../../../airline/home_bottom_nav/controller/search_controller.dart';
import '../../../airline/home_bottom_nav/nav_tabs/components/search_tabs/multi_city_flights/controller/multicity_search_controller.dart';
import '../../../app/configs/app_colors.dart';
import '../../../app/utils/custom_widgets/custom_outline_button_Wicon.dart';
import '../../../app/utils/custom_widgets/custom_textfield.dart';
import '../../model/booking_request.dart';
import '../../model/destination_details_model.dart';
import '../multiple_search_hotels.dart';
import '../search_hotels.dart';

class MultipleAccommodationTabView extends StatefulWidget {
  MultipleAccommodationTabView({super.key});

  @override
  State<MultipleAccommodationTabView> createState() => _AccommodationTabViewState();
}

class _AccommodationTabViewState extends State<MultipleAccommodationTabView> {
  String? _cabinClass;
  String? selectedCabin;
  // int selectedChildAge1 = 2;
  // int selectedChildAge2 = 2;
  // int selectedChildAge3 = 2;
  // int selectedChildAge4 = 2;
  // int selectedCIntantAge1 = 0;
  // int selectedCIntantAge2 = 0;
  // int selectedCIntantAge3 = 0;
  // int selectedCIntantAge4 = 0;
  // var selectedInfantAge = '0-1';
  // TextEditingController adultController = TextEditingController(text: "1");
  // TextEditingController childController = TextEditingController(text: "0");
  // TextEditingController infantController = TextEditingController(text: "0");
  // int adultCount = 1;
  // int childCount = 0;
  // int infantCount = 0;
  //
  final MulticitySearchController1 searchController = Get.put(MulticitySearchController1());
  final FocusNode _focusNode = FocusNode();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  bool isValidForm = false;
  final _formkey = GlobalKey<FormState>();
  int selectedTabIndex = 0;
  List<int> adultCountList = [1, 1, 1, 1];
  List<int> childCountList = [0, 0, 0, 0];
  List<int> infantCountList = [0, 0, 0, 0];
  List<Map<String, dynamic>> roomList = [];
  Map<String, dynamic> roomData = {
    "Adults": 1,
    "ChildrenAndInfant": 0,
    "ChildrenAndInfantAges": []
  };
  Map<String, dynamic> resMap = {};
  onTabSelect(int index) => setState(() => selectedTabIndex = index);

  List<TextEditingController> destinationControllers = [TextEditingController()];
  //List<Map<String, String?>> destinations = [{}]; // To store city, code, and country for each destination
  List<DestinationDetails> destinations = [DestinationDetails(cityController: TextEditingController())];


  @override
  void initState() {
    setArgs();
    super.initState();
    roomList.add(
        {"Adults": 1, "ChildrenAndInfant": 0, "ChildrenAndInfantAges": []});
  }

  setArgs() {
    selectedCabin = _cabinClass.toString();
  }

  var travellerList = ['Adult', 'Child', 'Infant'];

  String? arriveDate = "Select Date";
  String? departDate = "Select Date";
  String? departDateForm = "Select Date";
  String? arriveDateForm = "Select Date";
  DateTime depart = DateTime.now();

  Future<void> _selectDepartDate(BuildContext context, int i) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    // ignore: unrelated_type_equality_checks
    if (picked != null && picked != departDate) {
      setState(() {
        departDate = _formatDate(picked).toString();
        departDateForm = _formatDateForm(picked).toString();
        destinations[i].checkInDate = _formatDateForm(picked).toString();
        depart = picked;
      });
    }
  }

  Future<void> _selectArriveDate(BuildContext context, int i) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: depart,
      firstDate: depart,
      lastDate: DateTime(2101),
    );

    // ignore: unrelated_type_equality_checks
    if (picked != null && picked != arriveDate) {
      setState(() {
        arriveDate = _formatDate(picked).toString();
        arriveDateForm = _formatDateForm(picked).toString();
        destinations[i].checkOutDate = _formatDateForm(picked).toString();
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('E, d MMM y').format(date);
  }

  String _formatDateForm(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Search City widgets --------------------------------
                    for (int i = 0; i < destinations.length; i++) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColors.appColorPrimary,
                          ),
                          0.04.pw,
                          SizedBox(
                            width: w * 0.67,
                            child: CustomTextField(
                                icon: destinations[i].cityController.text.isEmpty
                                    ? SizedBox.shrink()
                                    : Icon(Icons.close_rounded),
                                onTap: () {
                                  destinations[i].cityController.clear();
                                },
                                textEditingController: destinations[i].cityController,
                                hintText: 'Search City',
                                labelText: 'To',
                                onChanged: (value) {
                                  searchController
                                      .fetchMulticitySearch2(destinations[i].cityController.text.trim(),i);
                                },
                                validator: (inputValue) {
                                  if (inputValue!.isEmpty) {
                                    return "Search City";
                                  }
                                  return null;
                                }),
                          ),
                          if(i != 0)
                          IconButton(
                              icon: Icon(Icons.remove_circle),
                              onPressed: () {
                                _removeDestination(i);
                              }//onRemove,
                          ),
                        ],
                      ),
                      Obx(
                            () {
                          return searchController
                              .mySearch2[i].value ==
                              ""
                              ? Container()
                              : Container(
                            height: 250,
                            margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(15)),
                            child: searchController
                                .searchModel.value.airports !=
                                null &&
                                searchController
                                    .searchModel.value.airports!.isNotEmpty
                                ? ListView.builder(
                              itemCount: searchController
                                  .searchModel.value.airports!.length,
                              itemBuilder: (context, index) {
                                final airport = searchController
                                    .searchModel.value.airports![index];
                                return ListTile(
                                  onTap: () {
                                    setState(() {
                                      destinations[i].cityController.text =
                                      "${airport.city}, ${airport.country}";
                                      destinations[i].toCode = airport.code.toString();
                                      destinations[i].toCity = airport.city.toString();
                                      destinations[i].toCountry =
                                          airport.country.toString();
                                      searchController.fetchMulticitySearch2("",i);
                                    });
                                  },
                                  title: Text(airport.city),
                                  subtitle: Text(airport.country),
                                );
                              },
                            )
                                : Center(
                              child: Text("No city found"),
                            ),
                          );
                        },
                      ),
                    //-------------------- Checkin Checkout Date
                      0.04.ph,
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            _selectDepartDate(context,i);
                          },
                          child: FlightTimeWidget(
                              type: 'Check-in', date: '${destinations[i].checkInDate}'),
                        ),
                        InkWell(
                          onTap: () {
                            destinations[i].checkInDate == "Select Date"
                                ? MyToast.snackToast("Select DEPARTURE First", 0)
                                : _selectArriveDate(context,i);
                          },
                          child: FlightTimeWidget(
                            type: 'Check-out',
                            date: '${destinations[i].checkOutDate}',
                          ),
                        ),
                      ],
                    ),
                      0.04.ph,
                      if((destinations.length -1) != i)...[
                        Divider(),
                        0.04.ph,
                      ],
                    ],
                    // Occupants ------------------------------------
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: roomList.length,
                        itemBuilder: (context, index) {
                          return DottedBorder(
                            dashPattern: [10, 8],
                            strokeWidth: 1,
                            color: AppColors.appColorPrimaryDark,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CommonText(
                                              text: 'Occupants', fontSize: 12.0),
                                          CommonText(
                                              text: 'Room #${index + 1}',
                                              fontSize: 15.0,
                                              weight: FontWeight.w500),
                                        ],
                                      ),
                                      Spacer(),
                                      index == 0
                                          ? SizedBox.shrink()
                                          : InkWell(
                                        onTap: () {
                                          setState(() {
                                            roomList.removeAt(index);
                                            childCountList[index] = 0;
                                            infantCountList[index] = 0;
                                          });
                                        },
                                        child: Image(
                                            height: 20,
                                            width: 20,
                                            image: AssetImage(
                                                "assets/icons/delete.png")),
                                      )
                                    ],
                                  ),
                                  Divider(),
                                  Counter(
                                      title: "Adult",
                                      onInc: () {
                                        setState(() {
                                          if (roomList[index]["Adults"] < 4) {
                                            roomList[index]["Adults"]++;
                                          }
                                        });
                                      },
                                      onDec: () {
                                        setState(() {
                                          if (roomList[index]["Adults"] > 1) {
                                            roomList[index]["Adults"]--;
                                          }
                                          if (childCountList[index] >
                                              roomList[index]["Adults"]) {
                                            childCountList[index]--;
                                          }
                                          if (infantCountList[index] >
                                              roomList[index]["Adults"]) {
                                            infantCountList[index]--;
                                          }
                                        });
                                      },
                                      count: roomList[index]["Adults"]),
                                  //
                                  0.01.ph,
                                  //
                                  Counter(
                                      title: "Child",
                                      onInc: () {
                                        setState(() {
                                          if (childCountList[index] <
                                              roomList[index]["Adults"]) {
                                            childCountList[index]++;
                                            roomList[index]["ChildrenAndInfant"] =
                                                childCountList[index] +
                                                    infantCountList[index];
                                          }
                                        });
                                      },
                                      onDec: () {
                                        setState(() {
                                          if (childCountList[index] > 0) {
                                            childCountList[index]--;
                                            roomList[index]["ChildrenAndInfant"] =
                                                childCountList[index] +
                                                    infantCountList[index];
                                          }
                                        });
                                      },
                                      count: childCountList[index]),
                                  //
                                  0.01.ph,
                                  //
                                  Counter(
                                      title: "Infant",
                                      onInc: () {
                                        setState(() {
                                          if (infantCountList[index] <
                                              roomList[index]["Adults"]) {
                                            infantCountList[index]++;
                                            roomList[index]["ChildrenAndInfant"] =
                                                childCountList[index] +
                                                    infantCountList[index];
                                          }
                                        });
                                      },
                                      onDec: () {
                                        setState(() {
                                          if (infantCountList[index] > 0) {
                                            infantCountList[index]--;
                                            roomList[index]["ChildrenAndInfant"] =
                                                childCountList[index] +
                                                    infantCountList[index];
                                          }
                                        });
                                      },
                                      count: infantCountList[index]),
                                ],
                              ),
                            ),
                          );
                        }),
                    0.04.ph,
                    Align(
                      alignment: Alignment.center,
                      child: Outline_button_icon(
                        width: double.infinity,
                        height: 35,
                        onPress: () {
                          _addMore();
                        },
                        iconPath: "assets/icons/key_room.png",
                        text: "Add Room",
                      ),
                    ),
                    0.04.ph,
                    Align(
                      alignment: Alignment.center,
                      child: Outline_button_icon(
                        width: double.infinity,
                        height: 35,
                        onPress: () {
                          _addDestination();
                        },
                        iconPath: "assets/icons/adddesti.png",
                        text: "Add Destination",
                      ),
                    ),
                    0.04.ph,
                    CustomButton(
                      height: 40,
                      width: w,
                      text: 'Search Hotels',
                      onPress: () {
                        bool cond = false;

                        destinations.forEach((elem) {
                          if (elem.cityController.text == "Search City" ||
                              elem.checkInDate == "Search Date" ||
                              elem.checkOutDate == "Select Date") {
                            cond = true;
                          }
                        });

                        if (cond == true) {
                          Get.showSnackbar(gradientSnackbar(
                              "Incomplete Form",
                              "Please fill the form correctly",
                              AppColors.orange,
                              Icons.warning_rounded));
                        }else{


                          var request = <BookingRequest>[];
                          destinations.forEach((elem) async {
                            var r = BookingRequest();
                            r.checkIn = elem.checkInDate;
                            r.checkOut = elem.checkOutDate;
                            r.destination = elem.toCode;
                            r.rooms = [];
                            roomList.forEach((room) async {
                              Room roo = Room(adults: room['Adults'], childrenAndInfant: room['ChildrenAndInfant'], childrenAndInfantAges: []);
                              r.rooms?.add(roo);
                            });
                            request.add(r);
                          });

                          Get.to(() => MultipleSearchHotelScreen(
                                   dataMap: resMap, multiAccom: request));
                        }




    // resMap["checkIn"] = departDateForm;
                        // resMap["checkOut"] = arriveDateForm;
                        // resMap["Rooms"] = roomList;
                        // resMap["destination"] = toCode;
                        //
                        // print("Response Map: $resMap");
                        //
                        // if (toCity == "" ||
                        //     departDate == "Select Date" ||
                        //     departDate == "" ||
                        //     arriveDate == "Select Date" ||
                        //     arriveDateForm == "") {
                        //   Get.showSnackbar(gradientSnackbar(
                        //       "Incomplete Form",
                        //       "Please fill the form correctly",
                        //       AppColors.orange,
                        //       Icons.warning_rounded));
                        // } else {
                        //   Get.to(() => SearchHotelScreen(
                        //     dataMap: resMap,
                        //   ));
                        // }
                      },
                    ),
                    0.04.ph,
                  ],
                ),
                0.02.ph,
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _addMore() {
    if (roomList.length < 4) {
      setState(() {
        roomList.add(
            {"Adults": 1, "ChildrenAndInfant": 0, "ChildrenAndInfantAges": []});
      });
    } else {
      Get.showSnackbar(gradientSnackbar(
          "Limit reached",
          "You can only add up to 4 rooms",
          Colors.grey,
          Icons.warning_amber_rounded));
    }
  }

  void _addDestination() {
    setState(() {
      destinations.add(DestinationDetails(cityController: TextEditingController()));
    });
  }

  void _removeDestination(int index) {
    setState(() {
      if (destinations.length > 1) {
        destinations.removeAt(index);
      } else {
        Get.showSnackbar(gradientSnackbar(
            "Limit",
            "At least one destination is required",
            Colors.grey,
            Icons.warning_amber_rounded));
      }
    });
  }
}

class ageCounter extends StatelessWidget {
  String title;
  final Function() onInc;
  final Function() onDec;
  ageCounter({
    super.key,
    required this.title,
    required this.onInc,
    required this.onDec,
    required this.age,
  });

  final int age;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(text: "$title  "),
        Container(
          height: 25,
          decoration: BoxDecoration(
            color: AppColors.appColorPrimary.withOpacity(0.7),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  iconSize: 10,
                  color: Colors.white,
                  onPressed: onDec,
                  icon: Icon(Icons.remove)),
              CommonText(
                text: "$age",
                color: Colors.white,
                fontSize: 15,
                weight: FontWeight.bold,
              ),
              IconButton(
                  iconSize: 10,
                  color: Colors.white,
                  onPressed: onInc,
                  icon: Icon(Icons.add)),
            ],
          ),
        ),
      ],
    );
  }
}

class Counter extends StatelessWidget {
  String? title;
  final Function() onInc;
  final Function() onDec;
  Counter({
    super.key,
    required this.title,
    required this.count,
    required this.onInc,
    required this.onDec,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(text: "$title", weight: FontWeight.bold),
        Container(
          height: 35,
          decoration: BoxDecoration(
            color: AppColors.appColorPrimary,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: onDec,
                  icon: Icon(Icons.remove, color: Colors.white, size: 20)),
              CommonText(
                text: "$count",
                color: Colors.white,
                weight: FontWeight.bold,
              ),
              IconButton(
                  onPressed: onInc,
                  icon: Icon(Icons.add, color: Colors.white, size: 20)),
            ],
          ),
        ),
      ],
    );
  }
}

class FlightTimeWidget extends StatelessWidget {
  const FlightTimeWidget({
    required this.type,
    required this.date,
    super.key,
  });
  final String type, date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: type,
          fontSize: 12,
        ),
        0.005.ph,
        CommonText(
          text: date, //'Fri, 28 Jan 2024',
          weight: FontWeight.bold,
        ),
      ],
    );
  }
}