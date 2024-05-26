// ignore_for_file: unnecessary_question_mark

class BookingHistoryModel {
  dynamic? id;
  dynamic? ticketAmount;
  dynamic? taxAmount;
  dynamic? agencyMarkup;
  dynamic? microSiteMarkup;
  dynamic? afroMarkup;
  dynamic? totalAmount;
  String? currency;
  String? parentPnr;
  String? status;
  String? paymentStatus;
  String? departure;
  String? arrival;
  String? departureDateTime;
  String? arrivalDateTime;
  String? tripType;
  String? bookingDate;
  dynamic? bookingId;
  String? airlineName;
  String? agency;

  BookingHistoryModel(
      {this.id,
      this.ticketAmount,
      this.taxAmount,
      this.agencyMarkup,
      this.microSiteMarkup,
      this.afroMarkup,
      this.totalAmount,
      this.currency,
      this.parentPnr,
      this.status,
      this.paymentStatus,
      this.departure,
      this.arrival,
      this.departureDateTime,
      this.arrivalDateTime,
      this.tripType,
      this.bookingDate,
      this.bookingId,
      this.airlineName,
      this.agency});

  BookingHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketAmount = json['ticketAmount'];
    taxAmount = json['taxAmount'];
    agencyMarkup = json['agencyMarkup'];
    microSiteMarkup = json['microSiteMarkup'];
    afroMarkup = json['afroMarkup'];
    totalAmount = json['totalAmount'];
    currency = json['currency'];
    parentPnr = json['parentPnr'];
    status = json['status'];
    paymentStatus = json['paymentStatus'];
    departure = json['departure'];
    arrival = json['arrival'];
    departureDateTime = json['departureDateTime'];
    arrivalDateTime = json['arrivalDateTime'];
    tripType = json['tripType'];
    bookingDate = json['bookingDate'];
    bookingId = json['bookingId'];
    airlineName = json['airlineName'];
    agency = json['agency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticketAmount'] = this.ticketAmount;
    data['taxAmount'] = this.taxAmount;
    data['agencyMarkup'] = this.agencyMarkup;
    data['microSiteMarkup'] = this.microSiteMarkup;
    data['afroMarkup'] = this.afroMarkup;
    data['totalAmount'] = this.totalAmount;
    data['currency'] = this.currency;
    data['parentPnr'] = this.parentPnr;
    data['status'] = this.status;
    data['paymentStatus'] = this.paymentStatus;
    data['departure'] = this.departure;
    data['arrival'] = this.arrival;
    data['departureDateTime'] = this.departureDateTime;
    data['arrivalDateTime'] = this.arrivalDateTime;
    data['tripType'] = this.tripType;
    data['bookingDate'] = this.bookingDate;
    data['bookingId'] = this.bookingId;
    data['airlineName'] = this.airlineName;
    data['agency'] = this.agency;
    return data;
  }
}