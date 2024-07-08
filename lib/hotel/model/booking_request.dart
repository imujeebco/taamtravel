class BookingRequest {
  String? checkIn;
  String? checkOut;
  List<Room>? rooms;
  String? destination;

  BookingRequest({
    this.checkIn,
    this.checkOut,
    this.rooms,
    this.destination,
  });

  factory BookingRequest.fromJson(Map<String, dynamic> json) {
    return BookingRequest(
      checkIn: json['checkIn'],
      checkOut: json['checkOut'],
      rooms: List<Room>.from(json['Rooms'].map((x) => Room.fromJson(x))),
      destination: json['destination'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'checkIn': checkIn,
      'checkOut': checkOut,
      'Rooms': rooms?.map((x) => x.toJson()).toList(),
      'destination': destination,
    };
  }
}

class Room {
  final int adults;
  final int childrenAndInfant;
  final List<int> childrenAndInfantAges;

  Room({
    required this.adults,
    required this.childrenAndInfant,
    required this.childrenAndInfantAges,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      adults: json['Adults'],
      childrenAndInfant: json['ChildrenAndInfant'],
      childrenAndInfantAges: List<int>.from(json['ChildrenAndInfantAges']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Adults': adults,
      'ChildrenAndInfant': childrenAndInfant,
      'ChildrenAndInfantAges': childrenAndInfantAges,
    };
  }
}
