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
import '../../../app/configs/app_colors.dart';
import '../../../app/utils/custom_widgets/custom_outline_button_Wicon.dart';
import '../../../app/utils/custom_widgets/custom_textfield.dart';
import '../search_hotels.dart';

class AccommodationTabView extends StatefulWidget {
  AccommodationTabView({super.key});

  @override
  State<AccommodationTabView> createState() => _AccommodationTabViewState();
}

class _AccommodationTabViewState extends State<AccommodationTabView> {
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
  final SearchController1 searchController = Get.put(SearchController1());
  final FocusNode _focusNode = FocusNode();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  bool isValidForm = false;
  final _formkey = GlobalKey<FormState>();
  int selectedTabIndex = 0;
  String? toCity = "";
  String? toCode = "";
  String? toCountry = "";
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

  Future<void> _selectDepartDate(BuildContext context) async {
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
        depart = picked;
      });
    }
  }

  Future<void> _selectArriveDate(BuildContext context) async {
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
                // Search City widgets --------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.appColorPrimary,
                    ),
                    0.04.pw,
                    SizedBox(
                      width: w * 0.8,
                      child: CustomTextField(
                          icon: toController.text.isEmpty
                              ? SizedBox.shrink()
                              : Icon(Icons.close_rounded),
                          onTap: () {
                            toController.clear();
                          },
                          textEditingController: toController,
                          hintText: 'Search City',
                          labelText: 'To',
                          onChanged: (value) {
                            searchController
                                .fetchSearch2(toController.text.trim());
                          },
                          validator: (inputValue) {
                            if (inputValue!.isEmpty) {
                              return "Search City";
                            }
                            return null;
                          }),
                    ),
                  ],
                ),
                Obx(
                  () {
                    return searchController.mySearch2 == ""
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
                                            toController.text =
                                                "${airport.city}, ${airport.country}";
                                            toCode = airport.code.toString();
                                            toCity = airport.city.toString();
                                            toCountry =
                                                airport.country.toString();
                                            searchController.fetchSearch2("");
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
                        _selectDepartDate(context);
                      },
                      child: FlightTimeWidget(
                          type: 'Check-in', date: '$departDate'),
                    ),
                    InkWell(
                      onTap: () {
                        departDate == "Select Date"
                            ? MyToast.snackToast("Select DEPARTURE First", 0)
                            : _selectArriveDate(context);
                      },
                      child: FlightTimeWidget(
                        type: 'Check-out',
                        date: '$arriveDate',
                      ),
                    ),
                  ],
                ),
                // Occupants ------------------------------------
                0.04.ph,
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
                // SizedBox(
                //   width: w,
                //   child: DropdownButton(
                //       isDense: true,
                //       isExpanded: true,
                //       icon: Icon(Icons.arrow_drop_down),
                //       value: selectedTraveller,
                //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                //       items: travellerList.map((String item) {
                //         return DropdownMenuItem(
                //             value: item, child: CommonText(text: item));
                //       }).toList(),
                //       onChanged: (String? val) {
                //         setState(() => selectedTraveller = val!);
                //       }),
                // ),
                // Cabin Class  ---------------------------------
                // 0.04.ph,
                // CommonText(text: 'CABIN CLASS', fontSize: 12.0),
                //
                // SizedBox(
                //   width: w,
                //   child: DropdownButton(
                //       isDense: true,
                //       isExpanded: true,
                //       icon: Icon(Icons.arrow_drop_down),
                //       value: selectedCabin,
                //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                //       items: cabinList.map((String item) {
                //         return DropdownMenuItem(
                //             value: item, child: CommonText(text: item));
                //       }).toList(),
                //       onChanged: (String? val) {
                //         setState(() => selectedCabin = val!);
                //       }),
                // ),
                // Search Flight Button -----------------------------------
                // Spacer(),
                0.04.ph,
                CustomButton(
                  height: 40,
                  width: w,
                  text: 'Search Hotels',
                  onPress: () {
                    resMap["checkIn"] = departDateForm;
                    resMap["checkOut"] = arriveDateForm;
                    resMap["Rooms"] = roomList;
                    resMap["destination"] = toCode;

                    print("Response Map: $resMap");

                    if (toCity == "" ||
                        departDate == "Select Date" ||
                        departDate == "" ||
                        arriveDate == "Select Date" ||
                        arriveDateForm == "") {
                      Get.showSnackbar(gradientSnackbar(
                          "Incomplete Form",
                          "Please fill the form correctly",
                          AppColors.orange,
                          Icons.warning_rounded));
                    } else {
                      Get.to(() => SearchHotelScreen(
                            dataMap: resMap,
                          ));
                    }
                  },
                ),
                0.04.ph,
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Row ageDropdown(text, child) {
  //   return Row(
  //     children: [
  //       CommonText(text: "$text:   "),
  //       SizedBox(
  //         width: 80,
  //         child: DropdownButton(
  //             isDense: true,
  //             isExpanded: true,
  //             icon: Icon(Icons.arrow_drop_down),
  //             value: child.toString(),
  //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
  //             items: childAgeList.map((String item) {
  //               return DropdownMenuItem(
  //                   value: item, child: CommonText(text: item));
  //             }).toList(),
  //             onChanged: (String? val) {
  //               setState(() => child = val!);
  //             }),
  //       ),
  //     ],
  //   );
  // }

  //--------------------- Add Room func
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
