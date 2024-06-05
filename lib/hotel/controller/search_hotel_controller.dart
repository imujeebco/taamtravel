import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../app/configs/app_colors.dart';
import '../../../app/data/data_controller.dart';
import '../../../app/utils/api_utility/api_url.dart';
import '../../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../view/Hotel_tabs/search_hotel_model.dart';

class SearchHotelController extends GetxController {
  final DataController dataController = Get.put(DataController());
  var isLoading = false.obs;
  var searchHotelModel = SearchHotelModel().obs;

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
  }

  @override
  void onInit() {
    super.onInit();
    loadGetxData();
  }

  Future<void> fetchHotels(Map data) async {
    isLoading.value = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer ${dataController.myToken.value}'
      };
      var body = json.encode(data);
      // var body = json.encode({
      //   "checkIn": "2024-06-10",
      //   "checkOut": "2024-06-15",
      //   "Rooms": [
      //     {"Adults": 1, "ChildrenAndInfant": 0, "ChildrenAndInfantAges": []}
      //   ],
      //   "destination": "NBO"
      // });
      print("Body: $body");

      var response = await http.post(
        Uri.parse('${baseURL}api/HotelBooking/search'),
        headers: headers,
        body: body,
      );
      print("This is my Token: ${dataController.myToken.value}");

      var jsonData = json.decode(response.body) as Map<String, dynamic>;
      searchHotelModel.value = SearchHotelModel.fromJson(jsonData);

      print("**** Search Hotels Response ****");
      print("Search Hotels Controller: ${response.body}");

      if (response.statusCode == 200) {
        isLoading.value = false;
      } else {
        print('Error: ${response.statusCode}');
        Get.showSnackbar(gradientSnackbar(
            "Failure",
            "${jsonData["error"] ?? "Something went wrong"}",
            AppColors.red,
            Icons.warning_rounded));
      }
    } catch (e) {
      print('Error: $e');
      Get.showSnackbar(gradientSnackbar("Failure", "Something went wrong",
          AppColors.orange, Icons.warning_rounded));
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
