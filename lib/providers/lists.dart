import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../helper/db.dart';
import '../models/user.dart';

class Lists with ChangeNotifier {
  DB _db = DB().table('lists');
  DB _dbUser = DB().table('users');

  String id;
  String title;
  Color color;
  bool shared = false;
  User owner;
  int items_count = 0;
  int items_done_count = 0;

  Lists({
    this.id,
    this.title,
    this.color,
    this.shared,
    this.owner,
    this.items_count,
    this.items_done_count,
  });

  String colorToString() => color.toString().split('(0xff')[1].split(')')[0];

  static Color colorFromString(String colorString) => Color(int.parse('ff$colorString', radix: 16));

  String store() {
    Map<String, Object> data = {
      'title': title,
      'color': colorToString(),
      'shared': shared, 
      'owner': owner.firebaseId ?? null,
      'users': {
          owner.firebaseId: {
            'image': owner.image,
            'accepted': true,
          },
      },
    };

    String listKey = _db.store(null, data);

    owner.attachList(listKey);

    notifyListeners();

    return listKey;
  }

  void update(Map<String, Object> data) {
    _db.update(this.id, data);
  }

  Future<Lists> fetch(String id) async {
    dynamic listData = await _db.fetch(id);

    if (listData == null) {
      return null;
    }

    return Lists(
      id: id,
      title: listData['title'] ?? 'a',
      shared: listData['shared'] ?? false,
      color: Lists.colorFromString(listData['color'] ?? 'ff00ff'),
      items_count: listData['items_count'] ?? 0,
      items_done_count: listData['items_count'] ?? 0,
    );
  }

 //Doesnt it belongs to user models? :thinking_face:
  Future<List> lists(String userId) async {
    var lists = new List<String>();
    DataSnapshot userListData = await _dbUser.reference.child(userId).child('lists').once();
    
    for(String key in userListData.value.keys) {
      lists.add(key);
    } 

    return lists;
  }

  Future<Lists> incrementItems() async {
    this.items_count++;

    _db.update(this.id, {
      'items_count': this.items_count,
    });

    return this;
  }
}