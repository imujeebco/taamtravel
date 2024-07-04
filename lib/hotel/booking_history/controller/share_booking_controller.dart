// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/airline/booking_history/model/search_PNR_model.dart';
import '../../../app/configs/app_colors.dart';
import '../../../app/data/data_controller.dart';
import '../../../app/utils/api_utility/api_url.dart';
import '../../../app/utils/custom_widgets/gradient_snackbar.dart';

class ShareBookingController extends GetxController {
  final DataController dataController = Get.put(DataController());
  var isLoading = false.obs;
  var searchPNRModel = SearchPNRModel().obs;

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
  }

  @override
  void onInit() {
    super.onInit();
    loadGetxData();
  }

  Future<void> shareTicket(String PNR, String email) async {
    isLoading.value = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer ${dataController.myToken.value}'
      };

      var response = await http.get(
          Uri.parse('${baseURL}api/HotelBooking/parentPnr/$PNR/email/$email'),
          headers: headers);

      print("**** SearchPNR Response ****");
      print("PNR Controller: ${response.body}");

      if (response.statusCode == 200) {
        Get.back();
        Get.showSnackbar(gradientSnackbar(
            "Success",
            "${"Ticket details has been emailed"}",
            AppColors.green,
            Icons.check_circle_rounded));
        isLoading.value = false;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      // Get.showSnackbar(gradientSnackbar("Failure", "Something went wrong",
      //     AppColors.orange, Icons.warning_rounded));
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
