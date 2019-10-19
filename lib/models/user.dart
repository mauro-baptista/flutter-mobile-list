import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';

class User {
  String id;
  String email;
  String name;
  String image;

  final FirebaseDatabase db = FirebaseDatabase();

  User({
    @required this.id,
    @required this.email,
    @required this.name,
    this.image,
  });

  String get firebaseId => email.replaceAll('.', '_');

  String toJson() => json.encode(this.toMap());

  Map<String, String> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'image': image,
  };

  static User fromMap(String userData) {
    Map<String, Object> user = json.decode(userData);

    return User(
      id: user['id'],
      name: user['name'],
      email: user['email'],
      image: user['image'] ?? null,
    );
  }

  void store() => db.reference().child('user/$firebaseId').update(this.toMap());

  Query lists() => db.reference().child('user/$firebaseId/lists');
}