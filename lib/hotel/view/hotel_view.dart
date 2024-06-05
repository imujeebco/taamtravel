// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';

import '../../airline/home_bottom_nav/controller/search_controller.dart';
import 'Hotel_tabs/accommodation_tab.dart';

class HotelScreen extends StatefulWidget {
  String? cabinClass;
  HotelScreen({super.key, this.cabinClass});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
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
  String? fromCity = "";
  String? fromCode = "";
  String? fromCountry = "";
  List<Map<String, dynamic>> roomList = [];
  Map<String, dynamic> roomData = {
    "Adults": 0,
    "ChildrenAndInfant": 0,
    "ChildrenAndInfantAges": []
  };
  onTabSelect(int index) => setState(() => selectedTabIndex = index);

  var tabsNames = [
    'One Accommodation',
    'Multiple Accommodations',
  ];

  @override
  void initState() {
    super.initState();
    roomList.add(
        {"Adults": 0, "ChildrenAndInfant": 0, "ChildrenAndInfantAges": []});
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return DefaultTabController(
      length: tabsNames.length,
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              TabBar(
                onTap: (index) {
                  onTabSelect(index);
                },
                dividerColor: Colors.transparent,
                labelColor: AppColors.appColorWhite,
                indicatorColor: Colors.transparent,
                unselectedLabelColor: Colors.black,
                labelPadding:
                    EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                tabs: List.generate(tabsNames.length, (i) {
                  return Container(
                    alignment: Alignment.center,
                    height: 40,
                    // width: 180,
                    decoration: BoxDecoration(
                      color: selectedTabIndex == i
                          ? AppColors.appColorPrimary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: CommonText(
                      text: tabsNames[i],
                      fontSize: 10.0,
                      color:
                          selectedTabIndex == i ? Colors.white : Colors.black,
                      weight: selectedTabIndex == i
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  );
                }),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    AccommodationTabView(
                        cabinClass: widget.cabinClass ?? "Economy",
                        fromCity: fromCode,
                        toCity: toCode),
                    AccommodationTabView(
                        cabinClass: widget.cabinClass ?? "Economy",
                        fromCity: fromCode,
                        toCity: toCode),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.all(10),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              // To Field ------------------------
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Icon(
              //       Icons.location_on_outlined,
              //       color: AppColors.appColorPrimary,
              //     ),
              //     0.04.pw,
              //     SizedBox(
              //       width: w * 0.8,
              //       child: CustomTextField(
              //           icon: toController.text.isEmpty
              //               ? SizedBox.shrink()
              //               : Icon(Icons.close_rounded),
              //           onTap: () {
              //             toController.clear();
              //           },
              //           textEditingController: toController,
              //           hintText: 'Search City',
              //           labelText: 'To',
              //           onChanged: (value) {
              //             searchController
              //                 .fetchSearch2(toController.text.trim());
              //           },
              //           validator: (inputValue) {
              //             if (inputValue!.isEmpty) {
              //               return "Search City";
              //             }
              //             return null;
              //           }),
              //     ),
              //   ],
              // ),
              // Obx(
              //   () {
              //     // ignore: unrelated_type_equality_checks
              //     return searchController.mySearch2 == ""
              //         ? Container()
              //         : Container(
              //             height: 250,
              //             margin: EdgeInsets.only(left: 20),
              //             decoration: BoxDecoration(
              //                 color: Colors.black.withOpacity(0.05),
              //                 borderRadius: BorderRadius.circular(15)),
              //             child: searchController
              //                             .searchModel.value.airports !=
              //                         null &&
              //                     searchController.searchModel.value
              //                         .airports!.isNotEmpty
              //                 ? ListView.builder(
              //                     itemCount: searchController
              //                         .searchModel.value.airports!.length,
              //                     itemBuilder: (context, index) {
              //                       final airport = searchController
              //                           .searchModel
              //                           .value
              //                           .airports![index];
              //                       return ListTile(
              //                         onTap: () {
              //                           setState(() {
              //                             toController.text =
              //                                 "${airport.city}, ${airport.country}";
              //                             toCode =
              //                                 airport.code.toString();
              //                             toCity =
              //                                 airport.city.toString();
              //                             toCountry =
              //                                 airport.country.toString();
              //                             searchController
              //                                 .fetchSearch2("");
              //                           });
              //                         },
              //                         title: Text(airport.city),
              //                         subtitle: Text(airport.country),
              //                       );
              //                     },
              //                   )
              //                 : Center(
              //                     child: Text("No city found"),
              //                   ),
              //           );
              //   },
              // ),

              // Tab Bar Container --------------------------------------
              // Container(
              //   margin: const EdgeInsets.only(top: 30.0),
              //   width: w,
              //   color: AppColors.appColorAccent,
              //   child: DefaultTabController(
              //     length: tabsNames.length,
              //     child: Column(
              //       children: [
              // TabBar(
              //   onTap: (index) {
              //     onTabSelect(index);
              //   },
              //   dividerColor: Colors.transparent,
              //   labelColor: AppColors.appColorWhite,
              //   indicatorColor: Colors.transparent,
              //   unselectedLabelColor: Colors.black,
              //   // indicatorWeight: 2.5,
              //   // indicatorPadding: EdgeInsets.symmetric(horizontal: 20.0),
              //   labelPadding: EdgeInsets.symmetric(
              //       horizontal: 8.0, vertical: 30.0),
              //   tabs: List.generate(tabsNames.length, (i) {
              //     return Container(
              //       alignment: Alignment.center,
              //       height: 40,
              //       width: 180,
              //       decoration: BoxDecoration(
              //         color: selectedTabIndex == i
              //             ? AppColors.appColorPrimary
              //             : Colors.transparent,
              //         borderRadius: BorderRadius.circular(20.0),
              //       ),
              //       child: CommonText(
              //         text: tabsNames[i],
              //         fontSize: 12.0,
              //         color: selectedTabIndex == i
              //             ? Colors.white
              //             : Colors.black,
              //         weight: selectedTabIndex == i
              //             ? FontWeight.w600
              //             : FontWeight.w400,
              //       ),
              //     );
              //   }),
              // ),
              // Container(
              //   height: 350,
              //   child: TabBarView(
              //     children: [
              //       AccommodationTabView(
              //           cabinClass: widget.cabinClass ?? "Economy",
              //           fromCity: fromCode,
              //           toCity: toCode),
              //       AccommodationTabView(
              //           cabinClass: widget.cabinClass ?? "Economy",
              //           fromCity: fromCode,
              //           toCity: toCode),
              //     ],
              //   ),
              // ),
              //     ],
              //   ),
              // ),
              // ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
