import 'dart:async';

import 'package:flutter/material.dart';

import '../helper/db.dart';
import '../models/user.dart';

class List {
  DB _db = DB().table('lists');

  User user;
  String title;
  Color color;
  bool shared = false;

  List({
    this.title,
    this.color,
    this.shared,
    this.user,
  });

  String colorToString() => color.toString().split('(0xff')[1].split(')')[0];

  static Color colorFromString(String colorString) => Color(int.parse('ff$colorString', radix: 16));

  Map<String, Object> toMap() {
    assert(title.isNotEmpty);
    assert(color != null);

    return {
      'title': title,
      'color': colorToString(),
      'shared': shared, 
      'user': user.firebaseId ?? null,
    };
  }

  String store() {
    var list = _db.reference.push();

    list.set(this.toMap());

    user.attachList(list.key);

    return list.key;
  }

  Future<List> fetch(String id) async {
    dynamic listData = await _db.fetch(id);

    return List(
      title: listData['title'],
      shared: listData['shared'],
      color: List.colorFromString(listData['color']),
    );
  }
}