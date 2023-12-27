class UserModel {
  bool? success;
  String? message;
  Data? data;

  UserModel({this.success, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? id;
  String? name;
  String? countryCode;
  String? phone;
  String? email;

  Data({this.id, this.name, this.countryCode, this.phone, this.email});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['country_code'];
    phone = json['phone'];
    email = json['email'];
  }
}
