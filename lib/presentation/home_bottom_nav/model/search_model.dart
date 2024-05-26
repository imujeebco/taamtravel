class SearchModel {
  List<Airport>? airports;

  SearchModel({this.airports});

  factory SearchModel.fromJson(List<dynamic> json) {
    List<Airport> airportsList =
        json.map((airportJson) => Airport.fromJson(airportJson)).toList();

    return SearchModel(airports: airportsList);
  }
}

class Airport {
  int id;
  String name;
  String code;
  String country;
  String city;

  Airport(
      {required this.id,
      required this.name,
      required this.code,
      required this.country,
      required this.city});

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      country: json['country'],
      city: json['city'],
    );
  }
}
