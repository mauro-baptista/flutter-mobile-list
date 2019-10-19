import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class List extends StatelessWidget {
  final DataSnapshot snapshot;

  List(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Text(snapshot.value.toString());
  }
}