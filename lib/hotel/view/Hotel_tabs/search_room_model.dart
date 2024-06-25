class SearchRoomModel {
  int? hotelId;
  int? searchId;
  List<Rooms>? rooms;

  SearchRoomModel({this.hotelId, this.searchId, this.rooms});

  SearchRoomModel.fromJson(Map<String, dynamic> json) {
    hotelId = json['hotelId'];
    searchId = json['searchId'];
    if (json['rooms'] != null) {
      rooms = <Rooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(new Rooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotelId'] = this.hotelId;
    data['searchId'] = this.searchId;
    if (this.rooms != null) {
      data['rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rooms {
  int? roomId;
  dynamic totalAmount;
  dynamic taxesAmount;
  String? currency;
  String? provider;
  String? roomDescription;
  String? mealPlan;
  dynamic cancellationTill;
  dynamic cancellationPenalty;
  String? remarks;

  Rooms(
      {this.roomId,
      this.totalAmount,
      this.taxesAmount,
      this.currency,
      this.provider,
      this.roomDescription,
      this.mealPlan,
      this.cancellationTill,
      this.cancellationPenalty,
      this.remarks});

  Rooms.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    totalAmount = json['totalAmount'];
    taxesAmount = json['taxesAmount'];
    currency = json['currency'];
    provider = json['provider'];
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
    data['roomDescription'] = this.roomDescription;
    data['mealPlan'] = this.mealPlan;
    data['cancellationTill'] = this.cancellationTill;
    data['cancellationPenalty'] = this.cancellationPenalty;
    data['remarks'] = this.remarks;
    return data;
  }
}
