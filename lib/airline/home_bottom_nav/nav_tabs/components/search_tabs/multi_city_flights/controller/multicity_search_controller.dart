// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../../../../app/configs/app_colors.dart';
import '../../../../../../../app/data/data_controller.dart';
import '../../../../../../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../../../../../model/search_model.dart';
import '../../../../../../../app/utils/api_utility/api_url.dart';

class MulticitySearchController1 extends GetxController {
  final DataController dataController = Get.put(DataController());
  // RxString mySearch1 = ''.obs;
  // RxString mySearch2 = ''.obs;
  RxList mySearch1 = [''.obs, ''.obs, ''.obs,''.obs, ''.obs, ''.obs, ''.obs].obs;
  RxList mySearch2 = [''.obs, ''.obs, ''.obs, ''.obs, ''.obs, ''.obs, ''.obs].obs;
  var isLoading = false.obs;
  var searchModel = SearchModel().obs;

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
  }

  @override
  void onInit() {
    super.onInit();
    loadGetxData();
  }

  //////////////////////// Save Remember Me Function ////////////////////////
///////////////////////////////////////////////////////////////////////////

  Future<void> fetchMulticitySearch1(String search, int index) async {
    mySearch1[index].value = search;
    isLoading.value = true;
    update();
    try {
      var headers = {'Content-Type': 'application/json', 'authorization': 'Bearer ${dataController.myToken.value}'};
      var body = json.encode({"search": search});

      var response = await http.post(
        Uri.parse('${baseURL}api/Airport/search'),
        headers: headers,
        body: body,
      );
      print("This is my Token: ${dataController.myToken.value}");

      var jsonData = json.decode(response.body);
      searchModel.value = SearchModel.fromJson(jsonData);
      print("**** SearchController Response ****");
      print("Search Controller: $jsonData");

      if (response.statusCode == 200) {
        isLoading.value = false;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');

      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMulticitySearch2(String search, int index) async {
    mySearch2[index].value = search;
    isLoading.value = true;
    update();
    try {
      var headers = {'Content-Type': 'application/json', 'authorization': 'Bearer ${dataController.myToken.value}'};
      var body = json.encode({"search": search});

      var response = await http.post(
        Uri.parse('${baseURL}api/Airport/search'),
        headers: headers,
        body: body,
      );
      print("This is my Token: ${dataController.myToken.value}");

      var jsonData = json.decode(response.body);
      searchModel.value = SearchModel.fromJson(jsonData);
      print("**** SearchController Response ****");
      print("Search Controller: $jsonData");

      if (response.statusCode == 200) {
        isLoading.value = false;
      } else {
        print('Error: ${response.statusCode}');
        Get.showSnackbar(gradientSnackbar("Failure", "${jsonData["error"] ?? "Something went wrong"}", AppColors.red, Icons.warning_rounded));
      }
    } catch (e) {
      print('Error: $e');
      Get.showSnackbar(gradientSnackbar("Failure", "Something went wrong", AppColors.orange, Icons.warning_rounded));
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
