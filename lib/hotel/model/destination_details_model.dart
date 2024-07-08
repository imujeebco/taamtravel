import 'package:flutter/cupertino.dart';

class DestinationDetails {
  TextEditingController cityController;
  String toCity;
  String toCode;
  String toCountry;
  String checkInDate;
  String checkOutDate;


  DestinationDetails({
    required this.cityController,
    this.toCity = "",
    this.toCode = "",
    this.toCountry = "",
    this.checkInDate = "Select Date",
    this.checkOutDate = "Select Date",
  });
}