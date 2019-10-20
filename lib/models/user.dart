import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';

import '../helper/db.dart';

class User {
  String id;
  String email;
  String name;
  String image;

  DB _db = DB().table('users');

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

  void store() => _db.reference.child(firebaseId).set(this.toMap());

  void attachList(String listKey) => _db.reference.child(firebaseId).child('lists').update({
    listKey: true,
  });

  Query lists() => _db.reference.child(firebaseId).child('lists');
}