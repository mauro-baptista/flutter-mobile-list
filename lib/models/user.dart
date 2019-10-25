import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../helper/db.dart';

class User {
  String email;
  String name;
  String image;
  List<String> lists;

  DB _db = DB().table('users');

  User({
    @required this.email,
    @required this.name,
    this.image,
    this.lists,
  });

  String get firebaseId => email.replaceAll('.', '_');

  String toJson() => json.encode(this.toMap());

  Map<String, Object> toMap() => {
    'name': name,
    'email': email,
    'image': image,
  };

  static User fromMap(String userData) {
    Map<String, Object> user = json.decode(userData);

    return User(
      name: user['name'],
      email: user['email'],
      image: user['image'] ?? null,
      lists: user['lists'] ?? [],
    );
  }

  void store() => _db.store(firebaseId, this.toMap());

  void attachList(String listKey) => _db.update('$firebaseId/lists', {
    listKey: true,
  });
}