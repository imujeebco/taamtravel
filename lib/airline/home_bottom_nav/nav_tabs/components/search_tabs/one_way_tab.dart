// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/airline/home_bottom_nav/nav_tabs/components/search_tabs/return_tab.dart';

import '../../../../../app/configs/app_colors.dart';
import '../../../../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../../../views/oneWay_flights.dart';

class OneWayTabView extends StatefulWidget {
  String? toCity;
  String? fromCity;
  String? cabinClass;
  OneWayTabView({super.key, this.toCity, this.fromCity, this.cabinClass});

  @override
  State<OneWayTabView> createState() => _OneWayTabViewState();
}

class _OneWayTabViewState extends State<OneWayTabView> {
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
  int adultCount = 1;
  int childCount = 0;
  int infantCount = 0;
  // TextEditingController adultController = TextEditingController(text: "1");
  // TextEditingController childController = TextEditingController(text: "0");
  // TextEditingController infantController = TextEditingController(text: "0");

  @override
  void initState() {
    setArgs();
    super.initState();
  }

  setArgs() {
    _cabinClass = widget.cabinClass;
    selectedCabin = _cabinClass.toString();
    print("OneWay Tab Cabin: ${widget.cabinClass}");
  }

  var travellerList = [
    'Adult',
    'Child',
    'Infant',
  ];
  var cabinList = [
    'Economy',
    'Business',
    // 'Premium',
    // 'First Class',
  ];
  var childAgeList = [
    '3-6',
    '6-9',
    '9-12',
  ];
  var infantAgeList = [
    '0-1',
    '1-2',
    '2-3',
  ];
  String? departDate = "Select Date";
  String? departDateForm = "Select Date";
  String? tripType = "OneWay";

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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // flight time widgets --------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _selectDepartDate(context);
                },
                child: FlightTimeWidget(
                  type: 'DEPARTURE',
                  date: '$departDate',
                ),
              ),
            ],
          ),

          // Traveller ------------------------------------
          0.04.ph,
          CommonText(text: 'TRAVELLER', fontSize: 12.0),
          Counter(
              title: "Adult",
              onInc: () {
                setState(() {
                  if (adultCount < 4) {
                    adultCount++;
                  }
                  childCount = 0;
                  infantCount = 0;
                });
              },
              onDec: () {
                setState(() {
                  if (adultCount > 1) {
                    adultCount--;
                  }
                  childCount = 0;
                  infantCount = 0;
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

          childCount == 1
              ? Column(
                  children: [
                    0.01.ph,
                    ageCounter(
                        title: "Child 1 age:",
                        onInc: () {
                          setState(() {
                            if (selectedChildAge1 < 12) {
                              selectedChildAge1++;
                            }
                          });
                        },
                        onDec: () {
                          setState(() {
                            if (selectedChildAge1 > 2) {
                              selectedChildAge1--;
                            }
                          });
                        },
                        age: selectedChildAge1),
                  ],
                )
              : Container(),

          childCount == 2
              ? Column(children: [
                  0.01.ph,
                  ageCounter(
                      title: "Child 1 age:",
                      onInc: () {
                        setState(() {
                          if (selectedChildAge1 < 12) {
                            selectedChildAge1++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedChildAge1 > 2) {
                            selectedChildAge1--;
                          }
                        });
                      },
                      age: selectedChildAge1),
                  0.01.ph,
                  ageCounter(
                      title: "Child 2 age:",
                      onInc: () {
                        setState(() {
                          if (selectedChildAge2 < 12) {
                            selectedChildAge2++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedChildAge2 > 2) {
                            selectedChildAge2--;
                          }
                        });
                      },
                      age: selectedChildAge2)
                ])
              : Container(),
          childCount == 3
              ? Column(children: [
                  0.01.ph,
                  ageCounter(
                      title: "Child 1 age:",
                      onInc: () {
                        setState(() {
                          if (selectedChildAge1 < 12) {
                            selectedChildAge1++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedChildAge1 > 2) {
                            selectedChildAge1--;
                          }
                        });
                      },
                      age: selectedChildAge1),
                  0.01.ph,
                  ageCounter(
                      title: "Child 2 age:",
                      onInc: () {
                        setState(() {
                          if (selectedChildAge2 < 12) {
                            selectedChildAge2++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedChildAge2 > 2) {
                            selectedChildAge2--;
                          }
                        });
                      },
                      age: selectedChildAge2),
                  0.01.ph,
                  ageCounter(
                      title: "Child 3 age:",
                      onInc: () {
                        setState(() {
                          if (selectedChildAge3 < 12) {
                            selectedChildAge3++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedChildAge3 > 2) {
                            selectedChildAge3--;
                          }
                        });
                      },
                      age: selectedChildAge3)
                ])
              : Container(),
          childCount == 4
              ? Column(children: [
                  0.01.ph,
                  ageCounter(
                      title: "Child 1 age:",
                      onInc: () {
                        setState(() {
                          if (selectedChildAge1 < 12) {
                            selectedChildAge1++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedChildAge1 > 2) {
                            selectedChildAge1--;
                          }
                        });
                      },
                      age: selectedChildAge1),
                  0.01.ph,
                  ageCounter(
                      title: "Child 2 age:",
                      onInc: () {
                        setState(() {
                          if (selectedChildAge2 < 12) {
                            selectedChildAge2++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedChildAge2 > 2) {
                            selectedChildAge2--;
                          }
                        });
                      },
                      age: selectedChildAge2),
                  0.01.ph,
                  ageCounter(
                      title: "Child 3 age:",
                      onInc: () {
                        setState(() {
                          if (selectedChildAge3 < 12) {
                            selectedChildAge3++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedChildAge3 > 2) {
                            selectedChildAge3--;
                          }
                        });
                      },
                      age: selectedChildAge3),
                  0.01.ph,
                  ageCounter(
                      title: "Child 4 age:",
                      onInc: () {
                        setState(() {
                          if (selectedChildAge4 < 12) {
                            selectedChildAge4++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedChildAge4 > 2) {
                            selectedChildAge4--;
                          }
                        });
                      },
                      age: selectedChildAge4)
                ])
              : Container(),
          //

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
          infantCount == 1
              ? Column(
                  children: [
                    0.01.ph,
                    ageCounter(
                        title: "Infant 1 age:",
                        onInc: () {
                          setState(() {
                            if (selectedCIntantAge1 < 2) {
                              selectedCIntantAge1++;
                            }
                          });
                        },
                        onDec: () {
                          setState(() {
                            if (selectedCIntantAge1 > 0) {
                              selectedCIntantAge1--;
                            }
                          });
                        },
                        age: selectedCIntantAge1),
                  ],
                )
              : Container(),

          infantCount == 2
              ? Column(children: [
                  0.01.ph,
                  ageCounter(
                      title: "Infant 1 age:",
                      onInc: () {
                        setState(() {
                          if (selectedCIntantAge1 < 2) {
                            selectedCIntantAge1++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedCIntantAge1 > 0) {
                            selectedCIntantAge1--;
                          }
                        });
                      },
                      age: selectedCIntantAge1),
                  0.01.ph,
                  ageCounter(
                      title: "Infant 2 age:",
                      onInc: () {
                        setState(() {
                          if (selectedCIntantAge2 < 2) {
                            selectedCIntantAge2++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedCIntantAge2 > 0) {
                            selectedCIntantAge2--;
                          }
                        });
                      },
                      age: selectedCIntantAge2)
                ])
              : Container(),
          infantCount == 3
              ? Column(children: [
                  0.01.ph,
                  ageCounter(
                      title: "Infant 1 age:",
                      onInc: () {
                        setState(() {
                          if (selectedCIntantAge1 < 2) {
                            selectedCIntantAge1++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedCIntantAge1 > 0) {
                            selectedCIntantAge1--;
                          }
                        });
                      },
                      age: selectedCIntantAge1),
                  0.01.ph,
                  ageCounter(
                      title: "Infant 2 age:",
                      onInc: () {
                        setState(() {
                          if (selectedCIntantAge2 < 2) {
                            selectedCIntantAge2++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedCIntantAge2 > 0) {
                            selectedCIntantAge2--;
                          }
                        });
                      },
                      age: selectedCIntantAge2),
                  0.01.ph,
                  ageCounter(
                      title: "Infant 3 age:",
                      onInc: () {
                        setState(() {
                          if (selectedCIntantAge3 < 2) {
                            selectedCIntantAge3++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedCIntantAge3 > 0) {
                            selectedCIntantAge3--;
                          }
                        });
                      },
                      age: selectedCIntantAge3)
                ])
              : Container(),
          infantCount == 4
              ? Column(children: [
                  0.01.ph,
                  ageCounter(
                      title: "Infant 1 age:",
                      onInc: () {
                        setState(() {
                          if (selectedCIntantAge1 < 2) {
                            selectedCIntantAge1++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedCIntantAge1 > 0) {
                            selectedCIntantAge1--;
                          }
                        });
                      },
                      age: selectedCIntantAge1),
                  0.01.ph,
                  ageCounter(
                      title: "Infant 2 age:",
                      onInc: () {
                        setState(() {
                          if (selectedCIntantAge2 < 2) {
                            selectedCIntantAge2++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedCIntantAge2 > 0) {
                            selectedCIntantAge2--;
                          }
                        });
                      },
                      age: selectedCIntantAge2),
                  0.01.ph,
                  ageCounter(
                      title: "Infant 3 age:",
                      onInc: () {
                        setState(() {
                          if (selectedCIntantAge3 < 2) {
                            selectedCIntantAge3++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedCIntantAge3 > 0) {
                            selectedCIntantAge3--;
                          }
                        });
                      },
                      age: selectedCIntantAge3),
                  0.01.ph,
                  ageCounter(
                      title: "Infant 4 age:",
                      onInc: () {
                        setState(() {
                          if (selectedCIntantAge4 < 2) {
                            selectedCIntantAge4++;
                          }
                        });
                      },
                      onDec: () {
                        setState(() {
                          if (selectedCIntantAge4 > 0) {
                            selectedCIntantAge4--;
                          }
                        });
                      },
                      age: selectedCIntantAge4)
                ])
              : Container(),
          // Cabin Class  ---------------------------------
          0.04.ph,
          CommonText(text: 'CABIN CLASS', fontSize: 12.0),

          SizedBox(
            width: w,
            child: DropdownButton(
                isDense: true,
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down),
                value: selectedCabin,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                items: cabinList.map((String item) {
                  return DropdownMenuItem(value: item, child: CommonText(text: item));
                }).toList(),
                onChanged: (String? val) {
                  setState(() => selectedCabin = val!);
                }),
          ),

          // Search Flight Button -----------------------------------
          // Spacer(),
          0.04.ph,
          CustomButton(
            height: 40,
            width: w,
            text: 'Search Flight',
            onPress: () {
              if (widget.toCity == "" || widget.fromCity == "" || departDate == "Select Date" || departDate == "") {
                Get.showSnackbar(gradientSnackbar("Incomplete Form", "Please fill the form correctly", AppColors.orange, Icons.warning_rounded));
              } else {
                Get.to(() => OneWaySearchFlightScreen(
                      cabinClass: widget.cabinClass.toString(),
                      traveller: selectedTraveller.toString(),
                      toCity: widget.toCity.toString(),
                      fromCity: widget.fromCity.toString(),
                      arriveDate: null,
                      departDate: departDateForm.toString(),
                      tripType: tripType.toString(),
                      adultCount: adultCount,
                      childCount: childCount,
                      infantCount: infantCount,
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
    );
  }

  Row ageDropdown(text, child) {
    return Row(
      children: [
        CommonText(text: "$text:   "),
        SizedBox(
          width: 80,
          child: DropdownButton(
              isDense: true,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down),
              value: child.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
              items: childAgeList.map((String item) {
                return DropdownMenuItem(value: item, child: CommonText(text: item));
              }).toList(),
              onChanged: (String? val) {
                setState(() => child = val!);
              }),
        ),
      ],
    );
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
              IconButton(iconSize: 10, color: Colors.white, onPressed: onDec, icon: Icon(Icons.remove)),
              CommonText(
                text: "$age",
                color: Colors.white,
                fontSize: 15,
                weight: FontWeight.bold,
              ),
              IconButton(iconSize: 10, color: Colors.white, onPressed: onInc, icon: Icon(Icons.add)),
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
              IconButton(onPressed: onDec, icon: Icon(Icons.remove, color: Colors.white, size: 20)),
              CommonText(
                text: "$count",
                color: Colors.white,
                weight: FontWeight.bold,
              ),
              IconButton(onPressed: onInc, icon: Icon(Icons.add, color: Colors.white, size: 20)),
            ],
          ),
        ),
      ],
    );
  }
}
