import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/presentation/home_bottom_nav/model/flight_quote_model.dart';
import '../../../app/configs/app_colors.dart';
import '../../../app/data/data_controller.dart';
import '../../../app/utils/api_utility/api_url.dart';
import '../../../app/utils/custom_widgets/gradient_snackbar.dart';

class FlightQuoteController extends GetxController {
  final DataController dataController = Get.put(DataController());
  var isLoading = false.obs;
  var flightQuoteModel = FlightQuoteModel().obs;

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
  }

  @override
  void onInit() {
    super.onInit();
    loadGetxData();
  }

  Future<void> fetchFlightQuote(
      String departCity,
      String arriveCity,
      String departDate,
      var arriveDate,
      String tripType,
      String cabinClass,
      int? adult,
      int? child,
      int? infant) async {
    isLoading.value = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer ${dataController.myToken.value}'
      };
      var body = json.encode({
        "DepartureCity": departCity,
        "ArrivalCity": arriveCity,
        "DepartureDate": departDate,
        "ReturnDate": arriveDate,
        // "DepartureCity": "NBO",
        // "ArrivalCity": "MGQ",
        // "DepartureDate": "2024-02-15",
        // "ReturnDate": "2024-02-20",
        "Adults": adult,
        "Children": child,
        "Infants": infant,
        "CabinClass": cabinClass,
        "IsFlexibleDates": true,
        "IsDirectFlight": false,
        "TripType": tripType,
        "MicrositeClientId": 2
        // dataController.mySupportId.value
      });
      print(departCity);
      print(arriveCity);
      print(departDate);
      print(arriveDate);

      var response = await http.post(
        Uri.parse('${baseURL}api/FlightQuote/search'),
        headers: headers,
        body: body,
      );
      print("This is my Token: ${dataController.myToken.value}");

      var jsonData = json.decode(response.body) as Map<String, dynamic>;
      flightQuoteModel.value = FlightQuoteModel.fromJson(jsonData);

      print("**** FlightQouteController Response ****");
      print("FlightQouteController Controller: ${response.body}");

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
