// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../app/configs/app_colors.dart';
import '../../../app/data/data_controller.dart';
import '../../../app/utils/api_utility/api_url.dart';
import '../../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../model/agency_profile_model.dart';

class AgencyProfileController extends GetxController {
  final DataController dataController = Get.put(DataController());
  var isLoading = false.obs;
  var agencyProfileModel = AgencyProfileModel().obs;

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
  }

  @override
  void onInit() {
    super.onInit();
    loadGetxData();
  }

  Future<void> fetchAgency() async {
    isLoading.value = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer ${dataController.myToken.value}'
      };

      var response = await http.get(
          Uri.parse('${baseURL}api/Agency/${dataController.myRoleId.value}'),
          headers: headers);

      var jsonData = json.decode(response.body) as Map<String, dynamic>;
      agencyProfileModel.value = AgencyProfileModel.fromJson(jsonData);

      print("**** AgencyProfile Response ****");
      print("AgencyProfile Controller: ${response.body}");

      if (response.statusCode == 200) {
        isLoading.value = false;
      } else {
        print('Error: ${response.statusCode}');
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
