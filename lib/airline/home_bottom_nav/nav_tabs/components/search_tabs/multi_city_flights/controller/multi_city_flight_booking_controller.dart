import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../../../app/configs/app_colors.dart';
import '../../../../../../../app/data/data_controller.dart';
import '../../../../../../../app/utils/api_utility/api_url.dart';
import '../../../../../../../app/utils/custom_widgets/gradient_snackbar.dart';
import '../../../../../model/flight_booking_model.dart';
import '../../../../../views/booking_details.dart';

class MultiCityFlightBookingController extends GetxController {
  final DataController dataController = Get.put(DataController());
  var isLoading = false.obs;
  var flightBookingModel = FlightBookingModel().obs;

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
  }

  @override
  void onInit() {
    super.onInit();
    loadGetxData();
  }

  Future<List> fetchBooking(
    String searchID,
    String flightID,
    String paymentID,
    String title,
    String firstName,
    String lastName,
    String traveller,
    String dob,
    String passNumber,
    String passExp,
    String email,
    String phoneNum,
    String phoneCode,
    String countryCode,
    int adultCount,
    int childCount,
    int infantCount,
    //
    adult2name,
    adult2Lname,
    adult2dob,
    adult2pass,
    adult2passExp,
    adult3name,
    adult3Lname,
    adult3dob,
    adult3pass,
    adult3passExp,
    adult4name,
    adult4Lname,
    adult4dob,
    adult4pass,
    adult4passExp,
    //
    child1name,
    child1Lname,
    child1dob,
    child1pass,
    child1passExp,
    child2name,
    child2Lname,
    child2dob,
    child2pass,
    child2passExp,
    child3name,
    child3Lname,
    child3dob,
    child3pass,
    child3passExp,
    child4name,
    child4Lname,
    child4dob,
    child4pass,
    child4passExp,
    //
    infant1name,
    infant1Lname,
    infant1dob,
    infant1pass,
    infant1passExp,
    infant2name,
    infant2Lname,
    infant2dob,
    infant2pass,
    infant2passExp,
    infant3name,
    infant3Lname,
    infant3dob,
    infant3pass,
    infant3passExp,
    infant4name,
    infant4Lname,
    infant4dob,
    infant4pass,
    infant4passExp,
  ) async {
    isLoading.value = true;
    int mySearchID = int.parse(searchID);
    int myflightID = int.parse(flightID);
    int mypaymentID = int.parse(paymentID);
    List<Map<String, dynamic>> passengers = [
      {
        "type": "Adult",
        "firstName": firstName,
        "lastName": lastName,
        "requestedAge": 29,
        "birthDate": dob,
        "Title": "MISTER",
        "documentType": "PASSPORT",
        "documentNumber": "BD0123456",
        "documentExpiration": "2028-03-25",
        "email": email,
        "phoneCountryCode": phoneCode,
        "phone": phoneNum,
        "country": countryCode,
        "countryId": 12
      },
    ];
    if (adultCount == 2 || adultCount > 2) {
      passengers.add(
        {
          "type": "Adult",
          "firstName": adult2name,
          "lastName": adult2Lname,
          "requestedAge": 29,
          "birthDate": dob,
          "Title": "MISTER",
          "documentType": "PASSPORT",
          "documentNumber": adult2pass,
          "documentExpiration": "2028-03-25",
          "email": email,
          "phoneCountryCode": phoneCode,
          "phone": phoneNum,
          "country": countryCode,
          "countryId": 12
        },
      );
    }
    if (adultCount == 3 || adultCount > 3) {
      passengers.add(
        {
          "type": "Adult",
          "firstName": adult3name,
          "lastName": adult3Lname,
          "requestedAge": 29,
          "birthDate": dob,
          "Title": "MISTER",
          "documentType": "PASSPORT",
          "documentNumber": adult3pass,
          "documentExpiration": "2028-03-25",
          "email": email,
          "phoneCountryCode": phoneCode,
          "phone": phoneNum,
          "country": countryCode,
          "countryId": 12
        },
      );
    }
    if (adultCount == 4) {
      passengers.add(
        {
          "type": "Adult",
          "firstName": adult4name,
          "lastName": adult4Lname,
          "requestedAge": 29,
          "birthDate": dob,
          "Title": "MISTER",
          "documentType": "PASSPORT",
          "documentNumber": adult4pass,
          "documentExpiration": "2028-03-25",
          "email": email,
          "phoneCountryCode": phoneCode,
          "phone": phoneNum,
          "country": countryCode,
          "countryId": 12
        },
      );
    }
    if (childCount == 1 || childCount > 1) {
      passengers.add(
        {
          "type": "Child",
          "firstName": child1name,
          "lastName": child1Lname,
          "requestedAge": 29,
          "birthDate": child1dob,
          "Title": "MISTER",
          "documentType": "PASSPORT",
          "documentNumber": child1pass,
          "documentExpiration": "2028-03-25",
          "email": email,
          "phoneCountryCode": phoneCode,
          "phone": phoneNum,
          "country": countryCode,
          "countryId": 12
        },
      );
    }
    if (childCount == 2 || childCount > 2) {
      passengers.add(
        {
          "type": "Child",
          "firstName": child2name,
          "lastName": child2Lname,
          "requestedAge": 29,
          "birthDate": child2dob,
          "Title": "MISTER",
          "documentType": "PASSPORT",
          "documentNumber": child2pass,
          "documentExpiration": "2028-03-25",
          "email": email,
          "phoneCountryCode": phoneCode,
          "phone": phoneNum,
          "country": countryCode,
          "countryId": 12
        },
      );
    }
    if (childCount == 3 || childCount > 3) {
      passengers.add(
        {
          "type": "Child",
          "firstName": child3name,
          "lastName": child3Lname,
          "requestedAge": 29,
          "birthDate": child3dob,
          "Title": "MISTER",
          "documentType": "PASSPORT",
          "documentNumber": child3pass,
          "documentExpiration": "2028-03-25",
          "email": email,
          "phoneCountryCode": phoneCode,
          "phone": phoneNum,
          "country": countryCode,
          "countryId": 12
        },
      );
    }
    if (childCount == 4) {
      passengers.add(
        {
          "type": "Child",
          "firstName": child4name,
          "lastName": child4Lname,
          "requestedAge": 29,
          "birthDate": child4dob,
          "Title": "MISTER",
          "documentType": "PASSPORT",
          "documentNumber": child4pass,
          "documentExpiration": "2028-03-25",
          "email": email,
          "phoneCountryCode": phoneCode,
          "phone": phoneNum,
          "country": countryCode,
          "countryId": 12
        },
      );
    }
    if (infantCount == 1 || infantCount > 1) {
      passengers.add(
        {
          "type": "Infant",
          "firstName": infant1name,
          "lastName": infant1Lname,
          "requestedAge": 29,
          "birthDate": infant1dob,
          "Title": "MISTER",
          "documentType": "PASSPORT",
          "documentNumber": infant1pass,
          "documentExpiration": "2028-03-25",
          "email": email,
          "phoneCountryCode": phoneCode,
          "phone": phoneNum,
          "country": countryCode,
          "countryId": 12
        },
      );
    }
    if (infantCount == 2 || infantCount > 2) {
      passengers.add(
        {
          "type": "Infant",
          "firstName": infant2name,
          "lastName": infant2Lname,
          "requestedAge": 29,
          "birthDate": infant2dob,
          "Title": "MISTER",
          "documentType": "PASSPORT",
          "documentNumber": infant2pass,
          "documentExpiration": "2028-03-25",
          "email": email,
          "phoneCountryCode": phoneCode,
          "phone": phoneNum,
          "country": countryCode,
          "countryId": 12
        },
      );
    }
    if (infantCount == 3 || infantCount > 3) {
      passengers.add(
        {
          "type": "Infant",
          "firstName": infant3name,
          "lastName": infant3Lname,
          "requestedAge": 29,
          "birthDate": infant3dob,
          "Title": "MISTER",
          "documentType": "PASSPORT",
          "documentNumber": infant3pass,
          "documentExpiration": "2028-03-25",
          "email": email,
          "phoneCountryCode": phoneCode,
          "phone": phoneNum,
          "country": countryCode,
          "countryId": 12
        },
      );
    }
    if (infantCount == 4) {
      passengers.add(
        {
          "type": "Infant",
          "firstName": infant4name,
          "lastName": infant4Lname,
          "requestedAge": 29,
          "birthDate": infant4dob,
          "Title": "MISTER",
          "documentType": "PASSPORT",
          "documentNumber": infant4pass,
          "documentExpiration": "2028-03-25",
          "email": email,
          "phoneCountryCode": phoneCode,
          "phone": phoneNum,
          "country": countryCode,
          "countryId": 12
        },
      );
    }
    print("LIST: $passengers");
    print(
        "Booking: 1 $mySearchID,2 $myflightID,3 $mypaymentID,4 $countryCode,5 $title,6 $firstName, 7 $lastName,8 $traveller, 9 $dob,10 $passNumber,11 $passExp, 12 $email ,13 $phoneNum, 14 $phoneCode, 15 $countryCode");

    try {
      var headers = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer ${dataController.myToken.value}'
      };
      var body = json.encode({
        "flightSelection": [
          {"flightId": myflightID, "searchId": mySearchID}
        ],
        "paymentTypeId": mypaymentID,
        "microSiteClientId": 3,
        "passengers": passengers
        // [
        //   {
        //     "type": "Adult",
        //     "firstName": firstName,
        //     "lastName": lastName,
        //     "requestedAge": 29,
        //     "birthDate": dob,
        //     "Title": "MISTER",
        //     "documentType": "PASSPORT",
        //     "documentNumber": "BD0123456",
        //     "documentExpiration": "2028-03-25",
        //     "email": email,
        //     "phoneCountryCode": phoneCode,
        //     "phone": phoneNum,
        //     "country": countryCode,
        //     "countryId": 12
        //   },
        //   if (adultCount == 2 || adultCount > 2)
        //     {
        //       {
        //         "type": "Adult",
        //         "firstName": adult2name,
        //         "lastName": "",
        //         "requestedAge": 29,
        //         "birthDate": dob,
        //         "Title": "MISTER",
        //         "documentType": "PASSPORT",
        //         "documentNumber": adult2pass,
        //         "documentExpiration": "2028-03-25",
        //         "email": email,
        //         "phoneCountryCode": phoneCode,
        //         "phone": phoneNum,
        //         "country": countryCode,
        //         "countryId": 12
        //       }
        //     },
        // ]
      });

      var response = await http.post(
        Uri.parse('${baseURL}api/FlightBooking/addBooking'),
        headers: headers,
        body: body,
      );
      print("This is my Token: ${dataController.myToken.value}");

      var jsonData = json.decode(response.body);
      flightBookingModel.value = FlightBookingModel.fromJson(jsonData);

      print("**** FlightBookingController Response ****");
      print("FlightBooking Controller: ${response.body}");
      print("FlightBooking: ${jsonData["parentPnr"]}");
      String? _parentPNR = jsonData["parentPnr"].toString();
      String? _status = jsonData["status"].toString();
      if (response.statusCode == 200) {
        // Get.to(() => BookingDetailsScreen(
        //       parentPNR: _parentPNR,
        //       status: _status,
        //     ));
        isLoading.value = false;
        return [_parentPNR, _status];
      } else {
        print('Error: ${response.statusCode}');
        Get.showSnackbar(gradientSnackbar(
            "Failure",
            "${jsonData["error"] ?? "Something went wrong"}",
            AppColors.red,
            Icons.warning_rounded));
        return ['', ''];
      }
    } catch (e) {
      print('Error: $e');
      Get.showSnackbar(gradientSnackbar("Failure", "Something went wrong",
          AppColors.orange, Icons.warning_rounded));
      isLoading.value = false;
      return ['', ''];
    } finally {
      isLoading.value = false;
    }
  }
}
