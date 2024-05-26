// ignore_for_file: unnecessary_question_mark

class AgencyProfileModel {
  int? id;
  String? name;
  String? code;
  String? logo;
  String? address;
  dynamic? cityId;
  int? countryId;
  int? microSiteClientId;
  bool? isActive;
  String? createdDate;
  String? modifiedDate;
  String? phone1;
  String? phone2;
  String? email;
  String? contactPerson;
  String? remarks;
  String? createdBy;
  String? modifiedBy;

  AgencyProfileModel(
      {this.id,
      this.name,
      this.code,
      this.logo,
      this.address,
      this.cityId,
      this.countryId,
      this.microSiteClientId,
      this.isActive,
      this.createdDate,
      this.modifiedDate,
      this.phone1,
      this.phone2,
      this.email,
      this.contactPerson,
      this.remarks,
      this.createdBy,
      this.modifiedBy});

  AgencyProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    logo = json['logo'];
    address = json['address'];
    cityId = json['cityId'];
    countryId = json['countryId'];
    microSiteClientId = json['microSiteClientId'];
    isActive = json['isActive'];
    createdDate = json['createdDate'];
    modifiedDate = json['modifiedDate'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    email = json['email'];
    contactPerson = json['contactPerson'];
    remarks = json['remarks'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['logo'] = this.logo;
    data['address'] = this.address;
    data['cityId'] = this.cityId;
    data['countryId'] = this.countryId;
    data['microSiteClientId'] = this.microSiteClientId;
    data['isActive'] = this.isActive;
    data['createdDate'] = this.createdDate;
    data['modifiedDate'] = this.modifiedDate;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['email'] = this.email;
    data['contactPerson'] = this.contactPerson;
    data['remarks'] = this.remarks;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    return data;
  }
}
