import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/presentation/home_bottom_nav/model/payment_method_model.dart';

import '../../../app/configs/app_colors.dart';
import '../../../app/data/data_controller.dart';
import '../../../app/utils/api_utility/api_url.dart';
import '../../../app/utils/custom_widgets/gradient_snackbar.dart';

class PaymentMethodController extends GetxController {
  final DataController dataController = Get.put(DataController());
  var isLoading = false.obs;
  var paymentMethodModel = PaymentMethodModel().obs;
  var paymentMethods = <PaymentMethodModel>[].obs;

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
  }

  @override
  void onInit() {
    super.onInit();
    loadGetxData();
  }

  Future<void> fetchMethod() async {
    isLoading.value = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer ${dataController.myToken.value}'
      };

      var response = await http.get(
        Uri.parse(
            '${baseURL}api/FlightBooking/paymentOptions/microSiteClientId/2'),
        headers: headers,
      );
      print("This is my Token: ${dataController.myToken.value}");

      var jsonData = json.decode(response.body);
      List<PaymentMethodModel> data = (jsonData as List)
          .map((item) => PaymentMethodModel.fromJson(item))
          .toList();

      paymentMethods.assignAll(data);
      // paymentMethodModel.value = PaymentMethodModel.fromJson(jsonData);

      print("**** PaymentMethod Response ****");
      print("PaymentMethod Controller: ${response.body}");
      // print("PaymentMethod Controller: ${jsonData[0]["id"]}");

      if (response.statusCode == 200) {
        isLoading.value = false;
    } else {
        print('Error: ${response.statusCode}');
        Get.showSnackbar(gradientSnackbar(
            "Failure",
            "${"Something went wrong"}",
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