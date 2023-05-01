// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.activeUser,
    this.createdAt,
    this.email,
    this.fcmId,
    this.firstname,
    this.ipAddress,
    this.lastLogin,
    this.lastname,
    this.latitude,
    this.longitude,
    this.password,
    this.phone,
    this.profileUrl,
    this.userReturn,
    this.user,
    this.userType,
    this.verifiedUser,
  });

  dynamic activeUser;
  dynamic createdAt;
  String? email;
  dynamic fcmId;
  String? firstname;
  String? ipAddress;
  dynamic lastLogin;
  String? lastname;
  dynamic latitude;
  dynamic longitude;
  String? password;
  String? phone;
  dynamic profileUrl;
  String? userReturn;
  String? user;
  String? userType;
  dynamic verifiedUser;

  factory User.fromJson(Map<String, dynamic> json) => User(
        activeUser: json["active_user"],
        createdAt: json["created_at"],
        email: json["email"],
        fcmId: json["fcm_id"],
        firstname: json["firstname"],
        ipAddress: json["ip_address"],
        lastLogin: json["last_login"],
        lastname: json["lastname"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        password: json["password"],
        phone: json["phone"],
        profileUrl: json["profile_url"],
        userReturn: json["return"],
        user: json["user"],
        userType: json["user_type"],
        verifiedUser: json["verified_user"],
      );

  Map<String, dynamic> toJson() => {
        "active_user": activeUser,
        "created_at": createdAt,
        "email": email,
        "fcm_id": fcmId,
        "firstname": firstname,
        "ip_address": ipAddress,
        "last_login": lastLogin,
        "lastname": lastname,
        "latitude": latitude,
        "longitude": longitude,
        "password": password,
        "phone": phone,
        "profile_url": profileUrl,
        "return": userReturn,
        "user": user,
        "user_type": userType,
        "verified_user": verifiedUser,
      };
}
