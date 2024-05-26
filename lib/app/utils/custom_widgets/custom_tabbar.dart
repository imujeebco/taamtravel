// // ignore_for_file: invalid_use_of_protected_member

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class CustomTabBar extends GetWidget<OrderDeliveryController> {
//   final List<int>? tabsNotificationList;
//   final List<String> tabsList;
//   final TabController tabController;
//   const CustomTabBar({Key? key, this.tabsNotificationList, required this.tabsList, required this.tabController}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var theme = context.theme.colorScheme;
//     HeightWidth(context);

//     return GetBuilder<OrderDeliveryController>(
//       init: OrderDeliveryController(),
//       builder: (_) => Container(
//         height: 35,
//         margin: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: TabBar(
//             dividerColor: Colors.transparent,
//             padding: EdgeInsets.zero,
//             // automaticIndicatorColorAdjustment: true,
//             unselectedLabelColor: Colors.grey[800],
//             labelColor: theme.onSecondary,
//             indicator: BoxDecoration(color: theme.secondary, borderRadius: BorderRadius.circular(10.0)),
//             indicatorPadding: EdgeInsets.zero,
//             labelPadding: EdgeInsets.zero,
//             indicatorSize: TabBarIndicatorSize.tab,
//             controller: tabController,
//             tabs: List.generate(tabsList.length, (i) {
//               return _.tabsNotificationsList.value.isNotEmpty
//                   ? Tab(
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           i == 0
//                               ? Container()
//                               : Container(
//                                   padding: const EdgeInsets.symmetric(horizontal: 5),
//                                   height: 25.0,
//                                   decoration: BoxDecoration(
//                                     color: theme.onPrimary,
//                                     borderRadius: BorderRadius.circular(4.0),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       '${_.tabsNotificationsList.value[i]}',
//                                       style: TextStyle(
//                                         color: theme.primary,
//                                         fontWeight: AppFontWeights.appTextFontWeightLight,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: AppPAddings.appMainPaddingExtraSmall),
//                             child: Tab(
//                               child: Text(
//                                 tabsList[i],
//                                 style: TextStyle(
//                                   color: theme.onSecondary,
//                                   fontSize: AppFontSizes.appFontSizeh11,
//                                   fontWeight: AppFontWeights.appTextFontWeightLight,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   : Tab(
//                       child: Text(
//                         tabsList[i],
//                         style: TextStyle(
//                           color: theme.onSecondary,
//                           fontSize: AppFontSizes.appFontSizeh10,
//                           fontWeight: AppFontWeights.appTextFontWeightLight,
//                         ),
//                       ),
//                     );
//             })),
//       ),
//     );
//   }
// }
