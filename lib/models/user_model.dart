// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.token,
    required this.name,
    required this.email,
  });

  String id;
  String token;
  String name;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        token: json["token"] ?? '',
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "token": token,
        "name": name,
        "email": email,
      };
}
