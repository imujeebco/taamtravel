// ignore_for_file: unnecessary_question_mark

class HotelBookingModel {
  dynamic? type;
  dynamic? redirectUrl;
  dynamic? ticketAmount;
  dynamic? taxAmount;
  dynamic? agencyMarkup;
  dynamic? microSiteMarkup;
  dynamic? afroMarkup;
  dynamic? totalAmount;
  dynamic? currency;
  dynamic? parentPnr;
  dynamic? status;
  List<Hotels>? hotels;

  HotelBookingModel(
      {this.type,
      this.redirectUrl,
      this.ticketAmount,
      this.taxAmount,
      this.agencyMarkup,
      this.microSiteMarkup,
      this.afroMarkup,
      this.totalAmount,
      this.currency,
      this.parentPnr,
      this.status,
      this.hotels});

  HotelBookingModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    redirectUrl = json['redirectUrl'];
    ticketAmount = json['ticketAmount'];
    taxAmount = json['taxAmount'];
    agencyMarkup = json['agencyMarkup'];
    microSiteMarkup = json['microSiteMarkup'];
    afroMarkup = json['afroMarkup'];
    totalAmount = json['totalAmount'];
    currency = json['currency'];
    parentPnr = json['parentPnr'];
    status = json['status'];
    if (json['hotels'] != null) {
      hotels = <Hotels>[];
      json['hotels'].forEach((v) {
        hotels!.add(new Hotels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['redirectUrl'] = this.redirectUrl;
    data['ticketAmount'] = this.ticketAmount;
    data['taxAmount'] = this.taxAmount;
    data['agencyMarkup'] = this.agencyMarkup;
    data['microSiteMarkup'] = this.microSiteMarkup;
    data['afroMarkup'] = this.afroMarkup;
    data['totalAmount'] = this.totalAmount;
    data['currency'] = this.currency;
    data['parentPnr'] = this.parentPnr;
    data['status'] = this.status;
    if (this.hotels != null) {
      data['hotels'] = this.hotels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hotels {
  dynamic? ticketAmount;
  dynamic? taxAmount;
  dynamic? agencyMarkup;
  dynamic? microSiteMarkup;
  dynamic? afroMarkup;
  dynamic? totalAmount;
  dynamic? currency;
  dynamic? pnr;
  dynamic? bookingReference;
  List<Passengers>? passengers;

  Hotels(
      {this.ticketAmount,
      this.taxAmount,
      this.agencyMarkup,
      this.microSiteMarkup,
      this.afroMarkup,
      this.totalAmount,
      this.currency,
      this.pnr,
      this.bookingReference,
      this.passengers});

  Hotels.fromJson(Map<String, dynamic> json) {
    ticketAmount = json['ticketAmount'];
    taxAmount = json['taxAmount'];
    agencyMarkup = json['agencyMarkup'];
    microSiteMarkup = json['microSiteMarkup'];
    afroMarkup = json['afroMarkup'];
    totalAmount = json['totalAmount'];
    currency = json['currency'];
    pnr = json['pnr'];
    bookingReference = json['bookingReference'];
    if (json['passengers'] != null) {
      passengers = <Passengers>[];
      json['passengers'].forEach((v) {
        passengers!.add(new Passengers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketAmount'] = this.ticketAmount;
    data['taxAmount'] = this.taxAmount;
    data['agencyMarkup'] = this.agencyMarkup;
    data['microSiteMarkup'] = this.microSiteMarkup;
    data['afroMarkup'] = this.afroMarkup;
    data['totalAmount'] = this.totalAmount;
    data['currency'] = this.currency;
    data['pnr'] = this.pnr;
    data['bookingReference'] = this.bookingReference;
    if (this.passengers != null) {
      data['passengers'] = this.passengers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Segments {
  String? departure;
  String? arrival;
  String? departureAirport;
  String? arrivalAirport;
  String? departureDateTime;
  String? arrivalDateTime;
  dynamic? duration;
  String? airlineLogo;
  String? airline;
  String? airlineName;
  String? flightNumber;
  String? cabinType;
  String? fareType;

  Segments(
      {this.departure,
      this.arrival,
      this.departureAirport,
      this.arrivalAirport,
      this.departureDateTime,
      this.arrivalDateTime,
      this.duration,
      this.airlineLogo,
      this.airline,
      this.airlineName,
      this.flightNumber,
      this.cabinType,
      this.fareType});

  Segments.fromJson(Map<String, dynamic> json) {
    departure = json['departure'];
    arrival = json['arrival'];
    departureAirport = json['departureAirport'];
    arrivalAirport = json['arrivalAirport'];
    departureDateTime = json['departureDateTime'];
    arrivalDateTime = json['arrivalDateTime'];
    duration = json['duration'];
    airlineLogo = json['airlineLogo'];
    airline = json['airline'];
    airlineName = json['airlineName'];
    flightNumber = json['flightNumber'];
    cabinType = json['cabinType'];
    fareType = json['fareType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['departure'] = this.departure;
    data['arrival'] = this.arrival;
    data['departureAirport'] = this.departureAirport;
    data['arrivalAirport'] = this.arrivalAirport;
    data['departureDateTime'] = this.departureDateTime;
    data['arrivalDateTime'] = this.arrivalDateTime;
    data['duration'] = this.duration;
    data['airlineLogo'] = this.airlineLogo;
    data['airline'] = this.airline;
    data['airlineName'] = this.airlineName;
    data['flightNumber'] = this.flightNumber;
    data['cabinType'] = this.cabinType;
    data['fareType'] = this.fareType;
    return data;
  }
}

class FareRules {
  String? category;
  String? description;

  FareRules({this.category, this.description});

  FareRules.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['description'] = this.description;
    return data;
  }
}

class Passengers {
  String? bookingReference;
  String? type;
  String? title;
  String? firstName;
  String? lastName;
  dynamic? requestedAge;
  String? birthDate;
  String? courtesyTitle;
  String? documentType;
  String? documentNumber;
  String? email;
  String? phoneCountryCode;
  String? phone;
  String? country;

  Passengers(
      {this.bookingReference,
      this.type,
      this.title,
      this.firstName,
      this.lastName,
      this.requestedAge,
      this.birthDate,
      this.courtesyTitle,
      this.documentType,
      this.documentNumber,
      this.email,
      this.phoneCountryCode,
      this.phone,
      this.country});

  Passengers.fromJson(Map<String, dynamic> json) {
    bookingReference = json['bookingReference'];
    type = json['type'];
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    requestedAge = json['requestedAge'];
    birthDate = json['birthDate'];
    courtesyTitle = json['courtesyTitle'];
    documentType = json['documentType'];
    documentNumber = json['documentNumber'];
    email = json['email'];
    phoneCountryCode = json['phoneCountryCode'];
    phone = json['phone'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingReference'] = this.bookingReference;
    data['type'] = this.type;
    data['title'] = this.title;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['requestedAge'] = this.requestedAge;
    data['birthDate'] = this.birthDate;
    data['courtesyTitle'] = this.courtesyTitle;
    data['documentType'] = this.documentType;
    data['documentNumber'] = this.documentNumber;
    data['email'] = this.email;
    data['phoneCountryCode'] = this.phoneCountryCode;
    data['phone'] = this.phone;
    data['country'] = this.country;
    return data;
  }
}
