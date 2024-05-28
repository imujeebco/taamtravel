import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../app/configs/app_colors.dart';
import '../../../app/data/data_controller.dart';
import '../../../app/utils/api_utility/api_url.dart';
import '../../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../model/booking_history_model.dart';

class BookingHistoryController extends GetxController {
  final DataController dataController = Get.put(DataController());
  var isLoading = false.obs;
  var bookingHistoryModel = BookingHistoryModel().obs;
  var bookingHistoryList = <BookingHistoryModel>[].obs;

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
  }

  @override
  void onInit() {
    super.onInit();
    loadGetxData();
  }

  Future<void> fetchBookings() async {
    isLoading.value = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer ${dataController.myToken.value}'
      };
      var body =
          json.encode({"startDate": "2024-01-01", "endDate": "2025-12-01"});

      var response = await http.post(
          Uri.parse(
              '${baseURL}api/FlightBooking/myBookings?pageSize=100&pageNumber=1'),
          headers: headers,
          body: body);
      // print("This is my Token: ${dataController.myToken.value}");

      var jsonData = json.decode(response.body);
      List<BookingHistoryModel> data = (jsonData as List)
          .map((item) => BookingHistoryModel.fromJson(item))
          .toList();

      bookingHistoryList.assignAll(data);

      print("**** BookingHistory Response ****");
      print("BookingHistory Controller: ${response.body}");
      // print("PaymentMethod Controller: ${jsonData[0]["id"]}");

      if (response.statusCode == 200) {
        isLoading.value = false;
      } else {
        print('Error: ${response.statusCode}');
        Get.showSnackbar(gradientSnackbar("Failure",
            "${"Something went wrong"}", AppColors.red, Icons.warning_rounded));
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
