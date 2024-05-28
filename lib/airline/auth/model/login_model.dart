class LoginModel {
  String? message;
  Data? data;
  int? statusCode;
  String? errorCode;
  String? error;

  LoginModel(
      {this.message, this.data, this.statusCode, this.errorCode, this.error});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    errorCode = json['errorCode'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = this.statusCode;
    data['errorCode'] = this.errorCode;
    data['error'] = this.error;
    return data;
  }
}

class Data {
  int? id;
  String? fullName;
  String? email;
  String? username;
  String? accessToken;
  String? refreshToken;
  int? expireAt;
  int? role;
  int? roleSupportId;

  Data(
      {this.id,
      this.fullName,
      this.email,
      this.username,
      this.accessToken,
      this.refreshToken,
      this.expireAt,
      this.role,
      this.roleSupportId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    username = json['username'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    expireAt = json['expireAt'];
    role = json['role'];
    roleSupportId = json['roleSupportId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['username'] = this.username;
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['expireAt'] = this.expireAt;
    data['role'] = this.role;
    data['roleSupportId'] = this.roleSupportId;
    return data;
  }
}