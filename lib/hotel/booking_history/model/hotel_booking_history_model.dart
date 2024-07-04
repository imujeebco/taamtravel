// ignore_for_file: unnecessary_question_mark

class HotelBookingHistoryModel {
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
  String? checkIn;
  String? checkOut;
  String? hotelName;
  String? roomName;
  String? bookingDate;
  dynamic? bookingId;
  String? passenger;
  String? agency;
  String? createdBy;
  bool? isPublicBooking;
  bool? isGuestBooking;

  HotelBookingHistoryModel(
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
      this.checkIn,
      this.checkOut,
      this.hotelName,
      this.roomName,
      this.bookingDate,
      this.bookingId,
      this.passenger,
      this.agency,
      this.createdBy,
      this.isPublicBooking,
      this.isGuestBooking,});

  HotelBookingHistoryModel.fromJson(Map<String, dynamic> json) {
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
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    hotelName = json['hotelName'];
    roomName = json['roomName'];
    passenger = json['passenger'];
    bookingDate = json['bookingDate'];
    bookingId = json['bookingId'];
    createdBy = json['createdBy'];
    isPublicBooking = json['isPublicBooking'];
    isGuestBooking = json['isGuestBooking'];
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
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    data['hotelName'] = this.hotelName;
    data['roomName'] = this.roomName;
    data['passenger'] = this.passenger;
    data['bookingDate'] = this.bookingDate;
    data['bookingId'] = this.bookingId;
    data['createdBy'] = this.createdBy;
    data['createdBy'] = this.createdBy;
    data['isPublicBooking'] = this.isPublicBooking;
    data['isGuestBooking'] = this.isGuestBooking;
    return data;
  }
}