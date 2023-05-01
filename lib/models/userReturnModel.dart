// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel? userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel? data) => json.encode(data!.toJson());

class UserModel {
  UserModel({
    this.createdAt,
    this.email,
    this.firstname,
    this.lastname,
    this.phone,
    this.publicId,
    this.userModelReturn,
    this.userId,
    this.userType,
    this.username,
    this.isVerified,
    this.token,
    this.profileUrl,
  });

  DateTime? createdAt;
  String? email;
  String? firstname;
  String? lastname;
  String? phone;
  String? publicId;
  String? userModelReturn;
  int? userId;
  String? userType;
  String? username;
  bool? isVerified;
  String? token;
  dynamic profileUrl;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        email: json["email"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        phone: json["phone"],
        publicId: json["public_id"],
        userModelReturn: json["return"],
        userId: json["user_id"] ?? json["id"],
        userType: json["user_type"],
        username: json["username"],
        isVerified: json["is_verified"],
        token: json["token"],
        profileUrl: json["profile_url"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt?.toIso8601String(),
        "email": email,
        "firstname": firstname,
        "lastname": lastname,
        "phone": phone,
        "public_id": publicId,
        "return": userModelReturn,
        "user_id": userId,
        "user_type": userType,
        "username": username,
        "is_verified": isVerified,
        "token": token,
        "profile_url": profileUrl,
      };
}
