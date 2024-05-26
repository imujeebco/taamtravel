import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/presentation/home_bottom_nav/views/search_flights.dart';

class SearchDatePickScreen extends StatefulWidget {
  const SearchDatePickScreen({super.key});

  @override
  State<SearchDatePickScreen> createState() => _SearchDatePickScreenState();
}

class _SearchDatePickScreenState extends State<SearchDatePickScreen> {
  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'Search'),
      body: Column(
        children: [
          DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      labelColor: AppColors.appColorPrimary,
                      indicatorColor: AppColors.appColorPrimary,
                      unselectedLabelColor: Colors.black,
                      indicatorWeight: 2.5,
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      labelPadding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                      tabs: [
                        CommonText(text: 'Departing'),
                        CommonText(text: 'Reporting')
                      ]),

                  //---------------------------------

                  Container(
                    // padding: const EdgeInsets.symmetric(vertical: 20.0),
                    height: h * 0.4,
                    child: TabBarView(
                      children: [
                        CalendarWidget(),
                        CalendarWidget(),
                      ],
                    ),
                  ),
                ],
              )),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CustomButton(
                height: 40,
                width: w,
                text: 'Confirm Date',
                onPress: () {
                  // Get.to(() => SearchFlightScreen());
                }),
          ),
        ],
      ),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CalendarDatePicker(
                initialDate: DateTime.now(), //get today's date
                firstDate: DateTime(
                    2000), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2101),
                onDateChanged: (_) {}),
          )
        ],
      ),
    );
  }
}
