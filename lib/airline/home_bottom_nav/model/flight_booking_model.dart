// ignore_for_file: unnecessary_question_mark

class FlightBookingModel {
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
  List<Flights>? flights;

  FlightBookingModel(
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
      this.flights});

  FlightBookingModel.fromJson(Map<String, dynamic> json) {
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
    if (json['flights'] != null) {
      flights = <Flights>[];
      json['flights'].forEach((v) {
        flights!.add(new Flights.fromJson(v));
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
    if (this.flights != null) {
      data['flights'] = this.flights!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Flights {
  dynamic? ticketAmount;
  dynamic? taxAmount;
  dynamic? agencyMarkup;
  dynamic? microSiteMarkup;
  dynamic? afroMarkup;
  dynamic? totalAmount;
  dynamic? currency;
  dynamic? pnr;
  dynamic? bookingReference;
  OutBound? outBound;
  OutBound? inBound;
  List<Passengers>? passengers;

  Flights(
      {this.ticketAmount,
      this.taxAmount,
      this.agencyMarkup,
      this.microSiteMarkup,
      this.afroMarkup,
      this.totalAmount,
      this.currency,
      this.pnr,
      this.bookingReference,
      this.outBound,
      this.inBound,
      this.passengers});

  Flights.fromJson(Map<String, dynamic> json) {
    ticketAmount = json['ticketAmount'];
    taxAmount = json['taxAmount'];
    agencyMarkup = json['agencyMarkup'];
    microSiteMarkup = json['microSiteMarkup'];
    afroMarkup = json['afroMarkup'];
    totalAmount = json['totalAmount'];
    currency = json['currency'];
    pnr = json['pnr'];
    bookingReference = json['bookingReference'];
    outBound = json['outBound'] != null
        ? new OutBound.fromJson(json['outBound'])
        : null;
    inBound =
        json['inBound'] != null ? new OutBound.fromJson(json['inBound']) : null;
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
    if (this.outBound != null) {
      data['outBound'] = this.outBound!.toJson();
    }
    if (this.inBound != null) {
      data['inBound'] = this.inBound!.toJson();
    }
    if (this.passengers != null) {
      data['passengers'] = this.passengers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OutBound {
  String? departure;
  String? arrival;
  String? departureAirport;
  String? arrivalAirport;
  String? departureDateTime;
  String? arrivalDateTime;
  String? departureDate;
  String? arrivalDate;
  String? departureTime;
  String? arrivalTime;
  dynamic? duration;
  dynamic? baggageAllowance;
  dynamic? flightRouteId;
  dynamic? flightScheduleId;
  dynamic? companyCode;
  List<Segments>? segments;
  List<FareRules>? fareRules;

  OutBound(
      {this.departure,
      this.arrival,
      this.departureAirport,
      this.arrivalAirport,
      this.departureDateTime,
      this.arrivalDateTime,
      this.departureDate,
      this.arrivalDate,
      this.departureTime,
      this.arrivalTime,
      this.duration,
      this.baggageAllowance,
      this.flightRouteId,
      this.flightScheduleId,
      this.companyCode,
      this.segments,
      this.fareRules});

  OutBound.fromJson(Map<String, dynamic> json) {
    departure = json['departure'];
    arrival = json['arrival'];
    departureAirport = json['departureAirport'];
    arrivalAirport = json['arrivalAirport'];
    departureDateTime = json['departureDateTime'];
    arrivalDateTime = json['arrivalDateTime'];
    departureDate = json['departureDate'];
    arrivalDate = json['arrivalDate'];
    departureTime = json['departureTime'];
    arrivalTime = json['arrivalTime'];
    duration = json['duration'];
    baggageAllowance = json['baggageAllowance'];
    flightRouteId = json['flightRouteId'];
    flightScheduleId = json['flightScheduleId'];
    companyCode = json['companyCode'];
    if (json['segments'] != null) {
      segments = <Segments>[];
      json['segments'].forEach((v) {
        segments!.add(new Segments.fromJson(v));
      });
    }
    if (json['fareRules'] != null) {
      fareRules = <FareRules>[];
      json['fareRules'].forEach((v) {
        fareRules!.add(new FareRules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['departure'] = this.departure;
    data['arrival'] = this.arrival;
    data['departureAirport'] = this.departureAirport;
    data['arrivalAirport'] = this.arrivalAirport;
    data['departureDateTime'] = this.departureDateTime;
    data['arrivalDateTime'] = this.arrivalDateTime;
    data['departureDate'] = this.departureDate;
    data['arrivalDate'] = this.arrivalDate;
    data['departureTime'] = this.departureTime;
    data['arrivalTime'] = this.arrivalTime;
    data['duration'] = this.duration;
    data['baggageAllowance'] = this.baggageAllowance;
    data['flightRouteId'] = this.flightRouteId;
    data['flightScheduleId'] = this.flightScheduleId;
    data['companyCode'] = this.companyCode;
    if (this.segments != null) {
      data['segments'] = this.segments!.map((v) => v.toJson()).toList();
    }
    if (this.fareRules != null) {
      data['fareRules'] = this.fareRules!.map((v) => v.toJson()).toList();
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
