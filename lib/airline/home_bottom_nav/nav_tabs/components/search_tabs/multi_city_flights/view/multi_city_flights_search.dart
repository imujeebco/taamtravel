// ignore_for_file: invalid_use_of_protected_member

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../../app/configs/app_colors.dart';
import '../../../../../../../app/configs/app_fontweights.dart';
import '../../../../../../../app/configs/app_size_config.dart';
import '../../../../../../../app/utils/custom_widgets/common_text.dart';
import '../../../../../../../app/utils/custom_widgets/custom_button.dart';
import '../../../../../../../app/utils/custom_widgets/custom_textfield.dart';
import '../../../../../../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../../../../../bnb/bottom_nav_view.dart';
import '../controller/multicity_search_controller.dart';

import '../../return_tab.dart';
import 'multi_city_flights_result.dart';

class MulticityFlightScreen extends StatefulWidget {
  const MulticityFlightScreen({super.key});

  @override
  State<MulticityFlightScreen> createState() => _MulticityFlightScreenState();
}

class _MulticityFlightScreenState extends State<MulticityFlightScreen> {
  final MulticitySearchController1 searchController =
      Get.put(MulticitySearchController1());
  final FocusNode _focusNode = FocusNode();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  bool isValidForm = false;
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
  String? toCity = "";
  String? toCode = "";
  String? toCountry = "";
  String? fromCity = "";
  String? fromCode = "";
  String? fromCountry = "";
  String? departDate = "Select Date";
  String? departDateForm = "Select Date";
  String? tripType = "Multicity";
  List<Map<String, dynamic>> cityList = [
    {"from": "Search City", "to": "Search City", "date": "Select Date"}
  ];

  List<TextEditingController> fromControllers = [];
  List<TextEditingController> toControllers = [];
  var cabinList = [
    'Economy',
    'Business',
    // 'Premium',
    // 'First Class',
  ];
  @override
  void initState() {
    super.initState();
    _addToTextField(0);
    _addFromTextField(0);

    selectedCabin = cabinList[0].toString();
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    fromControllers.forEach((controller) {
      controller.dispose();
    });
    toControllers.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  void _addToTextField(int index) {
    TextEditingController toControllerindex = TextEditingController();
    toControllers.add(toControllerindex);
  }

  void _addFromTextField(int index) {
    TextEditingController fromControllerindex = TextEditingController();
    fromControllers.add(fromControllerindex);
  }

  void onPressSubmit() {
    bool cond = false;
// For Validation ------
    cityList.forEach((elem) {
      if (elem['to'] == "Search City" ||
          elem['from'] == "Search City" ||
          elem['date'] == "Select Date") {
        cond = true;
      }
    });

    if (cond == true) {
      Get.showSnackbar(gradientSnackbar(
          "Incomplete Form",
          "Please fill the form correctly",
          AppColors.orange,
          Icons.warning_rounded));
    } else {
      // preparing data to post -------
      cityList.forEach((itm) {
        itm.addAll({
          'departureCity': itm['from'],
          'arrivalCity': itm['to'],
          'departureDate': itm['date'],
          'ReturnDate': null,
          'Adults': adultCount,
          'Children': childCount,
          'Infants': infantCount,
          'CabinClass': selectedCabin,
          'IsFlexibleDates': true,
          'IsDirectFlight': false,
          'TripType': tripType.toString(),
          'MicrositeClientId': 3,
        });
        itm.remove('to');
        itm.remove('from');
        itm.remove('date');
      });

      print(cityList);
      Get.to(() => MulticitySearchFlightScreen(
            cityList: cityList,
            // cabinClass: selectedCabin.toString(),
            traveller: selectedTraveller.toString(),
            // toCity: "widget.toCity.toString()",
            // fromCity: "widget.fromCity.toString()",
            // arriveDate: null,
            // departDate: departDateForm.toString(),
            // tripType: tripType.toString(),
            // adultCount: adultCount,
            // childCount: childCount,
            // infantCount: infantCount,
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
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.black),
          onTap: () {
            Get.offAll(() => BottomNavScreen());
          },
        ),
        title: CommonText(
            text: 'Multi City',
            weight: AppFontWeights.appTextFontWeightMedium,
            fontSize: 20.0),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // From Field ------------------------
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cityList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DottedBorder(
                          dashPattern: [10, 8],
                          strokeWidth: 1,
                          color: AppColors.appColorPrimary.withOpacity(0.5),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.flight_takeoff_sharp,
                                      color: AppColors.appColorPrimary,
                                    ),
                                    0.04.pw,
                                    SizedBox(
                                      width: w * 0.75,
                                      child: CustomTextField(
                                          icon: fromControllers[index]
                                                  .text
                                                  .isEmpty
                                              ? SizedBox.shrink()
                                              : Icon(Icons.close_rounded),
                                          onTap: () {
                                            fromControllers[index].clear();
                                          },
                                          // focusNode: _focusNode,
                                          textEditingController:
                                              fromControllers[index],
                                          hintText: 'Search City',
                                          labelText: 'From',
                                          onChanged: (val) {
                                            searchController
                                                .fetchMulticitySearch1(
                                                    val!.trim(), index);
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
                                0.02.ph,
                                Obx(
                                  () {
                                    // ignore: unrelated_type_equality_checks
                                    return searchController
                                                .mySearch1[index].value ==
                                            ""
                                        ? Container()
                                        : Container(
                                            height: 250,
                                            margin: EdgeInsets.only(left: 20),
                                            decoration: BoxDecoration(
                                                color: Colors.black12,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: searchController.searchModel
                                                            .value.airports !=
                                                        null &&
                                                    searchController
                                                        .searchModel
                                                        .value
                                                        .airports!
                                                        .isNotEmpty
                                                ? ListView.builder(
                                                    itemCount: searchController
                                                        .searchModel
                                                        .value
                                                        .airports!
                                                        .length,
                                                    itemBuilder:
                                                        (context, ind) {
                                                      final airport =
                                                          searchController
                                                              .searchModel
                                                              .value
                                                              .airports![ind];
                                                      return ListTile(
                                                        onTap: () {
                                                          setState(() {
                                                            fromControllers[
                                                                        index]
                                                                    .text =
                                                                "${airport.code},${airport.city}";
                                                            fromCode = airport
                                                                .code
                                                                .toString();

                                                            // fromCity = airport
                                                            //     .city
                                                            //     .toString();
                                                            // fromCountry = airport
                                                            //     .country
                                                            //     .toString();
                                                            searchController
                                                                .fetchMulticitySearch1(
                                                                    "", index);
                                                            // cityList[index]['fromText'] = "${airport.code},${airport.city}";
                                                            // cityList[index]["from"] = "${airport.code}";
                                                          });
                                                        },
                                                        title:
                                                            Text(airport.name),
                                                        subtitle:
                                                            Text(airport.city),
                                                      );
                                                    },
                                                  )
                                                : Center(
                                                    child: Text(
                                                        "No airports found"),
                                                  ),
                                          );
                                  },
                                ),
                                // To Field ------------------------
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.flight_land_sharp,
                                      color: AppColors.appColorPrimary,
                                    ),
                                    0.04.pw,
                                    SizedBox(
                                      width: w * 0.75,
                                      child: CustomTextField(
                                          icon:
                                              toControllers[index].text.isEmpty
                                                  ? SizedBox.shrink()
                                                  : Icon(Icons.close_rounded),
                                          onTap: () {
                                            toControllers[index].clear();
                                          },
                                          textEditingController:
                                              toControllers[index],
                                          hintText: 'Search City',
                                          labelText: 'To',
                                          onChanged: (val) {
                                            searchController
                                                .fetchMulticitySearch2(
                                                    val!.trim(), index);
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
                                0.02.ph,
                                Obx(
                                  () {
                                    // ignore: unrelated_type_equality_checks
                                    return searchController
                                                .mySearch2[index].value ==
                                            ""
                                        ? Container()
                                        : Container(
                                            height: 250,
                                            margin: EdgeInsets.only(left: 20),
                                            decoration: BoxDecoration(
                                                color: Colors.black12,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: searchController.searchModel
                                                            .value.airports !=
                                                        null &&
                                                    searchController
                                                        .searchModel
                                                        .value
                                                        .airports!
                                                        .isNotEmpty
                                                ? ListView.builder(
                                                    itemCount: searchController
                                                        .searchModel
                                                        .value
                                                        .airports!
                                                        .length,
                                                    itemBuilder:
                                                        (context, ind) {
                                                      final airport =
                                                          searchController
                                                              .searchModel
                                                              .value
                                                              .airports![ind];
                                                      return ListTile(
                                                        onTap: () {
                                                          setState(() {
                                                            toControllers[index]
                                                                    .text =
                                                                "${airport.code},${airport.city}";
                                                            toCode = airport
                                                                .code
                                                                .toString();
                                                            // toCity = airport.city
                                                            //     .toString();
                                                            // toCountry = airport
                                                            //     .country
                                                            //     .toString();
                                                            searchController
                                                                .fetchMulticitySearch2(
                                                                    "", index);

                                                            // cityList[ind]["toText"] = "${airport.code},${airport.city}";
                                                            // cityList[index]["to"] = "${airport.code}";
                                                          });
                                                        },
                                                        title:
                                                            Text(airport.name),
                                                        subtitle:
                                                            Text(airport.city),
                                                      );
                                                    },
                                                  )
                                                : Center(
                                                    child: Text(
                                                        "No airports found"),
                                                  ),
                                          );
                                  },
                                ),
                                0.02.ph,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _selectDepartDate(context, index);
                                      },
                                      child: FlightTimeWidget(
                                          type: 'DEPARTURE',
                                          // date: '$departDate',
                                          date: cityList[index]['date']
                                              .toString()),
                                    ),
                                  ],
                                ),
                                0.01.ph,
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 3),
                      ],
                    );
                  }),
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                    items: cabinList.map((String item) {
                      return DropdownMenuItem(
                          value: item, child: CommonText(text: item));
                    }).toList(),
                    onChanged: (String? val) {
                      setState(() => selectedCabin = val!);
                    }),
              ),
              0.04.ph,
              CustomButton(
                  height: 40,
                  width: w,
                  text: 'Search Flight',
                  onPress: () => onPressSubmit()),
              0.04.ph,
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "float",
        isExtended: true,
        label: CommonText(
            text: 'Add', color: Colors.white, weight: FontWeight.w500),
        backgroundColor: AppColors.appColorPrimary,
        tooltip: 'Add Cities',
        onPressed: () {
          _addMore();
        },
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(40)),
        icon: Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

////////////////////Funtions
  ///
  void setCityCode(int index, String? value, String? type) {
    setState(() {
      value = type;
    });
  }

  void _addMore() {
    if (cityList.length < 5) {
      setState(() {
        cityList.add({
          "from": "Search City",
          "to": "Search City",
          "date": "Select Date"
        });
        _addToTextField(cityList.length);
        _addFromTextField(cityList.length);
        print(toControllers.toString());
      });
    } else {
      Get.showSnackbar(gradientSnackbar(
          "Limit reached",
          "You can only add up to 5 visits",
          AppColors.appColorGrey,
          Icons.warning_amber_rounded));
    }
  }

//
  Future<void> _selectDepartDate(BuildContext context, int index) async {
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
        cityList[index]["date"] = departDateForm;
        cityList[index]["from"] = fromCode;
        cityList[index]["to"] = toCode;
        print(cityList.toString());
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('E, d MMM y').format(date);
  }

  String _formatDateForm(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
