// ignore_for_file: unnecessary_question_mark

class UserProfileModel {
  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? username;
  String? roleIds;
  bool? isActive;
  String? createdDate;
  String? modifiedDate;
  String? createdBy;
  String? modifiedBy;
  dynamic? agencyId;
  String? verificationKey;

  UserProfileModel(
      {this.id,
      this.firstName,
      this.middleName,
      this.lastName,
      this.email,
      this.username,
      this.roleIds,
      this.isActive,
      this.createdDate,
      this.modifiedDate,
      this.createdBy,
      this.modifiedBy,
      this.agencyId,
      this.verificationKey});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    email = json['email'];
    username = json['username'];
    roleIds = json['roleIds'];
    isActive = json['isActive'];
    createdDate = json['createdDate'];
    modifiedDate = json['modifiedDate'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    agencyId = json['agencyId'];
    verificationKey = json['verificationKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['username'] = this.username;
    data['roleIds'] = this.roleIds;
    data['isActive'] = this.isActive;
    data['createdDate'] = this.createdDate;
    data['modifiedDate'] = this.modifiedDate;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    data['agencyId'] = this.agencyId;
    data['verificationKey'] = this.verificationKey;
    return data;
  }
}
