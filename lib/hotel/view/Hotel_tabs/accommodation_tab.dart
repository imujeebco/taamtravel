// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_toast.dart';
import 'package:travel_app/app/utils/custom_widgets/gradient_snackbar.dart';

import 'package:intl/intl.dart';
import '../../../app/configs/app_colors.dart';
import '../../../airline/home_bottom_nav/views/search_hotels.dart';

class AccommodationTabView extends StatefulWidget {
  String? toCity;
  String? fromCity;
  String? cabinClass;
  AccommodationTabView(
      {super.key, this.toCity, this.fromCity, this.cabinClass});

  @override
  State<AccommodationTabView> createState() => _AccommodationTabViewState();
}

class _AccommodationTabViewState extends State<AccommodationTabView> {
  String? _cabinClass;
  String? selectedCabin;
  var selectedTraveller = 'Adult';
  int selectedChildAge1 = 2;
  int selectedChildAge2 = 2;
  int selectedChildAge3 = 2;
  int selectedChildAge4 = 2;
  int selectedCIntantAge1 = 0;
  int selectedCIntantAge2 = 0;
  int selectedCIntantAge3 = 0;
  int selectedCIntantAge4 = 0;
  var selectedInfantAge = '0-1';
  // TextEditingController adultController = TextEditingController(text: "1");
  // TextEditingController childController = TextEditingController(text: "0");
  // TextEditingController infantController = TextEditingController(text: "0");
  int roomCount = 1;
  int adultCount = 1;
  int childCount = 0;
  int infantCount = 0;

  @override
  void initState() {
    setArgs();
    super.initState();
  }

  setArgs() {
    _cabinClass = widget.cabinClass;
    selectedCabin = _cabinClass.toString();
    print("Return Tab Cabin: ${widget.cabinClass}");
  }

  var travellerList = [
    'Adult',
    'Child',
    'Infant',
  ];
  // var childAgeList = [
  //   '3-6',
  //   '6-9',
  //   '9-12',
  // ];
  // var infantAgeList = [
  //   '0-1',
  //   '1-2',
  //   '2-3',
  // ];

  String? arriveDate = "Select Date";
  String? departDate = "Select Date";
  String? departDateForm = "Select Date";
  String? arriveDateForm = "Select Date";
  String? tripType = "RoundTrip";
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // flight time widgets --------------------------------

            // ElevatedButton(
            //   onPressed: () => _selectArriveDate(context),
            //   child: Text('Select Date'),
            // ),

            // ElevatedButton(
            //   onPressed: () => _selectDepartDate(context),
            //   child: Text('Select Date'),
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    _selectDepartDate(context);
                  },
                  child: FlightTimeWidget(
                    type: 'Check-in',
                    date: '$departDate',
                  ),
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

            // Traveller ------------------------------------
            0.04.ph,
            CommonText(text: 'Occupants', fontSize: 12.0),

            Counter(
                title: "Adult",
                onInc: () {
                  setState(() {
                    if (adultCount < 4) {
                      adultCount++;
                    }
                  });
                },
                onDec: () {
                  setState(() {
                    if (adultCount > 1) {
                      adultCount--;
                    }
                    if (childCount > adultCount) {
                      childCount--;
                    }
                    if (infantCount > adultCount) {
                      infantCount--;
                    }
                  });
                },
                count: adultCount),
            //
            0.01.ph,
            //
            Counter(
                title: "Child",
                onInc: () {
                  setState(() {
                    if (childCount < adultCount) {
                      childCount++;
                    }
                  });
                },
                onDec: () {
                  setState(() {
                    if (childCount > 0) {
                      childCount--;
                    }
                  });
                },
                count: childCount),

            0.01.ph,
            //
            Counter(
                title: "Infant",
                onInc: () {
                  setState(() {
                    if (infantCount < adultCount) {
                      infantCount++;
                    }
                  });
                },
                onDec: () {
                  setState(() {
                    if (infantCount > 0) {
                      infantCount--;
                    }
                  });
                },
                count: infantCount),
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
            0.04.ph,
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
                if (widget.toCity == "" ||
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
                        cabinClass: widget.cabinClass.toString(),
                        traveller: selectedTraveller.toString(),
                        adultCount: adultCount,
                        childCount: childCount,
                        infantCount: infantCount,
                        toCity: widget.toCity.toString(),
                        fromCity: 'NBO',
                        arriveDate: arriveDateForm.toString(),
                        departDate: departDateForm.toString(),
                        tripType: tripType.toString(),
                        //
                        child1age: selectedChildAge1,
                        child2age: selectedChildAge2,
                        child3age: selectedChildAge3,
                        child4age: selectedChildAge4,
                        //
                        infant1age: selectedCIntantAge1,
                        infant2age: selectedCIntantAge2,
                        infant3age: selectedCIntantAge3,
                        infant4age: selectedCIntantAge4,
                        //
                      ));
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "float",
        elevation: 16.0,
        isExtended: true,
        label: CommonText(
            text: 'Room', color: AppColors.white, weight: FontWeight.w500),
        backgroundColor: AppColors.appColorPrimary,
        tooltip: 'Add Rooms',
        onPressed: () {
          // _addMore();
        },
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(40)),
        icon: Icon(Icons.add, color: AppColors.white, size: 32),
      ),
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
