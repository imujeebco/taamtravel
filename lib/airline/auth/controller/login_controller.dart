import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/configs/app_colors.dart';
import '../../../app/utils/api_utility/api_url.dart';
import '../../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../../home_bottom_nav/bnb/bottom_nav_view.dart';
import '../model/login_model.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var loginModel = LoginModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  //////////////////////// Save Remember Me Function ////////////////////////
///////////////////////////////////////////////////////////////////////////

  Future<void> getLogin(String? username, String? password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading.value = true;
    try {
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode({"username": username, "password": password});

      var response = await http.post(
        Uri.parse('${baseURL}api/authenticator/loginUser'),
        headers: headers,
        body: body,
      );
      // print("This is my Username: $username");
      // print("This is my Password: $password");

      var jsonData = json.decode(response.body) as Map<String, dynamic>;
      loginModel.value = LoginModel.fromJson(jsonData);
      print("**** LoginController Response ****");
      print("Login Controller: $jsonData");

      if (response.statusCode == 200) {
        // print("Login Email: ${jsonData["data"]["email"]}");
        await prefs.setInt('savedID', jsonData["data"]["id"]);
        await prefs.setString('savedName', jsonData["data"]["fullName"]);
        await prefs.setString('savedEmail', jsonData["data"]["email"]);
        await prefs.setString('savedUsername', jsonData["data"]["username"]);
        await prefs.setString('savedToken', jsonData["data"]["accessToken"]);
        await prefs.setInt('roleID', jsonData["data"]["role"]);
        await prefs.setString(
            'savedRefToken', jsonData["data"]["refreshToken"]);
        await prefs.setInt(
            'savedRoleSupportId', jsonData["data"]["roleSupportId"]);

        await prefs.setBool('loggedInStatus', true);
        Get.showSnackbar(gradientSnackbar("Success", "${jsonData["message"]}",
            AppColors.green, Icons.check_circle_rounded));
        isLoading.value = false;

        await Get.to(() => BottomNavScreen());
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
