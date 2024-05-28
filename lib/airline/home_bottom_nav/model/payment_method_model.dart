// class PaymentMethodModel {
//   int? id;
//   String? name;

//   PaymentMethodModel({this.id, this.name});

//   PaymentMethodModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     return data;
//   }
// }

class PaymentMethodModel {
 int? id;
 String? name;

  PaymentMethodModel({ this.id, this.name});

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
