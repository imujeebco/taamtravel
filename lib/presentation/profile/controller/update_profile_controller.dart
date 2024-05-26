// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../app/configs/app_colors.dart';
import '../../../app/data/data_controller.dart';
import '../../../app/utils/api_utility/api_url.dart';
import '../../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../../home_bottom_nav/bnb/bottom_nav_view.dart';

class UpdateProfileController extends GetxController {
  final DataController dataController = Get.put(DataController());
  var isLoading = false.obs;

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
  }

  @override
  void onInit() {
    super.onInit();
    loadGetxData();
  }

  Future<void> updateUser(name, midname, lastname, email) async {
    isLoading.value = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer ${dataController.myToken.value}'
      };

      var body = json.encode({
        "firstName": "$name",
        "middleName": "$midname",
        "lastName": "$lastname",
        "email": "$email"
      });

      var response = await http.put(Uri.parse('${baseURL}api/Accounts/account'),
          headers: headers, body: body);

      var jsonData = json.decode(response.body);
      //as Map<String, dynamic>;
      // userProfileModel.value = UserProfileModel.fromJson(jsonData);

      print("**** UpdateProfile Response ****");
      print("UpdateProfile Controller: ${response.body}");

      if (response.statusCode == 200) {
        Get.to(() => BottomNavScreen());
        Get.showSnackbar(gradientSnackbar(
            "Success",
            "${"User Profile Updated"}",
            AppColors.green,
            Icons.check_circle_rounded));
        isLoading.value = false;
      } else {
        print('Error: ${response.statusCode}');
        Get.showSnackbar(gradientSnackbar("Failure", jsonData["title"],
            AppColors.red, Icons.warning_rounded));
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
