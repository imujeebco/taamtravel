class SearchHotelModel {
  int? id;
  String? errorMessage;
  String? stackTrace;
  List<Hotels>? hotels;

  SearchHotelModel({this.id, this.errorMessage, this.stackTrace, this.hotels});

  SearchHotelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    errorMessage = json['errorMessage'];
    stackTrace = json['stackTrace'];
    if (json['hotels'] != null) {
      hotels = <Hotels>[];
      json['hotels'].forEach((v) {
        hotels!.add(new Hotels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['errorMessage'] = this.errorMessage;
    data['stackTrace'] = this.stackTrace;
    if (this.hotels != null) {
      data['hotels'] = this.hotels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hotels {
  int? id;
  dynamic totalAmount;
  dynamic taxesAmount;
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
  List<Ratings>? ratings;
  String? address;
  String? phoneNumber;
  String? rating;
  String? review;

  Hotels(
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

  Hotels.fromJson(Map<String, dynamic> json) {
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
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(new Ratings.fromJson(v));
      });
    }
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
    if (this.ratings != null) {
      data['ratings'] = this.ratings!.map((v) => v.toJson()).toList();
    }
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    data['rating'] = this.rating;
    data['review'] = this.review;
    return data;
  }
}

class Ratings {
  String? source;
  String? numReviews;
  String? score;

  Ratings({this.source, this.numReviews, this.score});

  Ratings.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    numReviews = json['numReviews'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    data['numReviews'] = this.numReviews;
    data['score'] = this.score;
    return data;
  }
}
