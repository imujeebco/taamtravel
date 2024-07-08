// ignore_for_file: unnecessary_question_mark

class SearchHotelPNRModel {
  dynamic? ticketAmount;
  dynamic? taxAmount;
  dynamic? agencyMarkup;
  dynamic? microSiteMarkup;
  dynamic? afroMarkup;
  dynamic? totalAmount;
  String? currency;
  String? pnr;
  String? bookingReference;
  String? parentPnr;
  String? status;
  String? paymentStatus;
  String? bookingDate;
  List<Hotels>? hotels;

  SearchHotelPNRModel(
      {this.ticketAmount,
        this.taxAmount,
        this.agencyMarkup,
        this.microSiteMarkup,
        this.afroMarkup,
        this.totalAmount,
        this.currency,
        this.pnr,
        this.bookingReference,
        this.parentPnr,
        this.status,
        this.paymentStatus,
        this.bookingDate,
        this.hotels});

  SearchHotelPNRModel.fromJson(Map<String, dynamic> json) {
    ticketAmount = json['ticketAmount'];
    taxAmount = json['taxAmount'];
    agencyMarkup = json['agencyMarkup'];
    microSiteMarkup = json['microSiteMarkup'];
    afroMarkup = json['afroMarkup'];
    totalAmount = json['totalAmount'];
    currency = json['currency'];
    pnr = json['pnr'];
    bookingReference = json['bookingReference'];
    parentPnr = json['parentPnr'];
    status = json['status'];
    paymentStatus = json['paymentStatus'];
    bookingDate = json['bookingDate'];
    if (json['hotels'] != null) {
      hotels = <Hotels>[];
      json['hotels'].forEach((v) {
        hotels!.add(new Hotels.fromJson(v));
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
    data['parentPnr'] = this.parentPnr;
    data['status'] = this.status;
    data['paymentStatus'] = this.paymentStatus;
    data['bookingDate'] = this.bookingDate;
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
  String? currency;
  String? pnr;
  String? bookingReference;
  String? checkIn;
  String? checkOut;
  Hotel? hotel;
  Room? room;
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
        this.checkIn,
        this.checkOut,
        this.hotel,
        this.room,
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
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    hotel = json['hotel'] != null ? new Hotel.fromJson(json['hotel']) : null;
    room = json['room'] != null ? new Room.fromJson(json['room']) : null;
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
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    if (this.hotel != null) {
      data['hotel'] = this.hotel!.toJson();
    }
    if (this.room != null) {
      data['room'] = this.room!.toJson();
    }
    if (this.passengers != null) {
      data['passengers'] = this.passengers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hotel {
  int? id;
  dynamic? totalAmount;
  Null? taxesAmount;
  String? currency;
  String? provider;
  String? hotelName;
  String? room;
  String? nonRefundable;
  String? category;
  List<String>? imageUrls;
  List<String>? includedServices;
  List<String>? otherServices;
  String? latitude;
  String? longitude;
  String? description;
  Null? ratings;
  String? address;
  String? phoneNumber;
  String? rating;
  String? review;

  Hotel(
      {this.id,
        this.totalAmount,
        this.taxesAmount,
        this.currency,
        this.provider,
        this.hotelName,
        this.room,
        this.nonRefundable,
        this.category,
        this.imageUrls,
        this.includedServices,
        this.otherServices,
        this.latitude,
        this.longitude,
        this.description,
        this.ratings,
        this.address,
        this.phoneNumber,
        this.rating,
        this.review});

  Hotel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalAmount = json['totalAmount'];
    taxesAmount = json['taxesAmount'];
    currency = json['currency'];
    provider = json['provider'];
    hotelName = json['hotelName'];
    room = json['room'];
    nonRefundable = json['nonRefundable'];
    category = json['category'];
    imageUrls = json['imageUrls'].cast<String>();
    includedServices = json['includedServices'].cast<String>();
    otherServices = json['otherServices'].cast<String>();
    latitude = json['latitude'];
    longitude = json['longitude'];
    description = json['description'];
    ratings = json['ratings'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    rating = json['rating'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['totalAmount'] = this.totalAmount;
    data['taxesAmount'] = this.taxesAmount;
    data['currency'] = this.currency;
    data['provider'] = this.provider;
    data['hotelName'] = this.hotelName;
    data['room'] = this.room;
    data['nonRefundable'] = this.nonRefundable;
    data['category'] = this.category;
    data['imageUrls'] = this.imageUrls;
    data['includedServices'] = this.includedServices;
    data['otherServices'] = this.otherServices;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['description'] = this.description;
    data['ratings'] = this.ratings;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    data['rating'] = this.rating;
    data['review'] = this.review;
    return data;
  }
}

class Room {
  int? roomId;
  double? totalAmount;
  double? taxesAmount;
  String? currency;
  String? provider;
  Null? providerReferenceId;
  String? roomDescription;
  String? mealPlan;
  Null? cancellationTill;
  double? cancellationPenalty;
  String? remarks;

  Room(
      {this.roomId,
        this.totalAmount,
        this.taxesAmount,
        this.currency,
        this.provider,
        this.providerReferenceId,
        this.roomDescription,
        this.mealPlan,
        this.cancellationTill,
        this.cancellationPenalty,
        this.remarks});

  Room.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    totalAmount = json['totalAmount'];
    taxesAmount = json['taxesAmount'];
    currency = json['currency'];
    provider = json['provider'];
    providerReferenceId = json['providerReferenceId'];
    roomDescription = json['roomDescription'];
    mealPlan = json['mealPlan'];
    cancellationTill = json['cancellationTill'];
    cancellationPenalty = json['cancellationPenalty'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomId'] = this.roomId;
    data['totalAmount'] = this.totalAmount;
    data['taxesAmount'] = this.taxesAmount;
    data['currency'] = this.currency;
    data['provider'] = this.provider;
    data['providerReferenceId'] = this.providerReferenceId;
    data['roomDescription'] = this.roomDescription;
    data['mealPlan'] = this.mealPlan;
    data['cancellationTill'] = this.cancellationTill;
    data['cancellationPenalty'] = this.cancellationPenalty;
    data['remarks'] = this.remarks;
    return data;
  }
}

class Passengers {
  String? type;
  String? title;
  String? firstName;
  String? lastName;
  int? requestedAge;
  String? courtesyTitle;
  String? email;
  String? phoneCountryCode;
  String? phone;
  String? country;

  Passengers(
      {this.type,
        this.title,
        this.firstName,
        this.lastName,
        this.requestedAge,
        this.courtesyTitle,
        this.email,
        this.phoneCountryCode,
        this.phone,
        this.country});

  Passengers.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    requestedAge = json['requestedAge'];
    courtesyTitle = json['courtesyTitle'];
    email = json['email'];
    phoneCountryCode = json['phoneCountryCode'];
    phone = json['phone'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['requestedAge'] = this.requestedAge;
    data['courtesyTitle'] = this.courtesyTitle;
    data['email'] = this.email;
    data['phoneCountryCode'] = this.phoneCountryCode;
    data['phone'] = this.phone;
    data['country'] = this.country;
    return data;
  }
}
