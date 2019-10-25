import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import './lists.dart';
import '../helper/db.dart';

enum Status {
  PENDING,
  DONE,
}

class Items with ChangeNotifier {
  DB _db = DB().table('items');

  final String name;
  final Lists list;
  Status status = Status.PENDING;
  
  Items({
    this.name,
    this.list,
    this.status,
  });

  void store() {
    _db.store(null, {
      'name': name,
      'list_id': list.id,
      'status': status == Status.DONE ? 'done' : 'pending',
    });

    list.incrementItems();

    notifyListeners();
  }

  Future<Map<String, dynamic>> items(String listId) async {
    var items = new Map<String, dynamic>();
    DataSnapshot listItems = await _db.reference.orderByChild('list_id').equalTo(listId).once();

    for(String key in listItems.value.keys) {
      items[key] = {
        'id': key,
        'name': listItems.value[key]['name'],
        'status': listItems.value[key]['pending'] == 'done' ? Status.DONE : Status.PENDING,
      };
    } 

    return items;
  }
}