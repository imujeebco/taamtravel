import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/airline/home_bottom_nav/model/oneWay_flight_quote_model.dart';

import '../../../../../../../app/configs/app_colors.dart';
import '../../../../../../../app/data/data_controller.dart';
import '../../../../../../../app/utils/api_utility/api_url.dart';
import '../../../../../../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../model/multi_city_flight_model.dart';

class MulticityFlightQuoteController extends GetxController {
  final DataController dataController = Get.put(DataController());
  var isLoading = false.obs;
  var oneWayflightQuoteModel = OneWayFlightQuoteModel().obs;
  var multiCityFlightModel = MultiCityFlightModel().obs;
  RxList<MultiCityFlightModel?> responseList = <MultiCityFlightModel?>[].obs;

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
  }

  @override
  void onInit() {
    super.onInit();
    loadGetxData();
  }

  Future<MultiCityFlightModel?> multicityFlightQuote(cityObj) async {
    isLoading.value = true;
    try {
      var headers = {'Content-Type': 'application/json', 'authorization': 'Bearer ${dataController.myToken.value}'};
      var body = json.encode(cityObj);
      var response = await http.post(
        Uri.parse('${baseURL}api/FlightQuote/search'),
        headers: headers,
        body: body,
      );
      print("This is my Token: ${dataController.myToken.value}");

      var jsonData = json.decode(response.body) as Map<String, dynamic>;
      multiCityFlightModel.value = MultiCityFlightModel.fromJson(jsonData);

      print("**** oneWayflightController Response ****");
      print("oneWayflightController: ${response.body}");

      if (response.statusCode == 200) {
        isLoading.value = false;

        return multiCityFlightModel.value;
      } else {
        print('Error: ${response.statusCode}');
        Get.showSnackbar(gradientSnackbar("Failure", "${jsonData["error"] ?? "Something went wrong"}", AppColors.red, Icons.warning_rounded));
        return null;
      }
    } catch (e) {
      print('Error: $e');
      Get.showSnackbar(gradientSnackbar("Failure", "Something went wrong", AppColors.orange, Icons.warning_rounded));
      isLoading.value = false;
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
