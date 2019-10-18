import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  String id;
  String email;
  String name;
  String image;

  User({
    @required this.id,
    @required this.email,
    @required this.name,
    this.image,
  });

  String toJson() {
    return json.encode({
      'id': id,
      'name': name,
      'email': email,
      'image': image,
    });
  }

  static User fromMap(String userData) {
    Map<String, Object> user = json.decode(userData);

    return User(
      id: user['id'],
      name: user['name'],
      email: user['email'],
      image: user['image'] ?? null,
    );
  }
}