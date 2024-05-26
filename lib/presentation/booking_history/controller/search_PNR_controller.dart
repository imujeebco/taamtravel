// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/presentation/booking_history/model/search_PNR_model.dart';
import '../../../app/configs/app_colors.dart';
import '../../../app/data/data_controller.dart';
import '../../../app/utils/api_utility/api_url.dart';
import '../../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../model/booking_history_model.dart';

class SearchPNRController extends GetxController {
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

  Future<void> fetchPNR(String PNR) async {
    isLoading.value = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer ${dataController.myToken.value}'
      };

      var response = await http.get(
          Uri.parse('${baseURL}api/FlightBooking/parentPnr/$PNR'),
          headers: headers);

      var jsonData = json.decode(response.body) as Map<String, dynamic>;
      searchPNRModel.value = SearchPNRModel.fromJson(jsonData);

      print("**** SearchPNR Response ****");
      print("PNR Controller: ${response.body}");
      // print("PaymentMethod Controller: ${jsonData[0]["id"]}");

      if (response.statusCode == 200) {
        isLoading.value = false;
      } else {
        print('Error: ${response.statusCode}');
        // Get.showSnackbar(gradientSnackbar("Failure",
        //     "${"Something went wrong"}", AppColors.red, Icons.warning_rounded));
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
