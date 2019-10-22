import 'package:flutter/material.dart';

class List extends StatelessWidget {
  final String listKey;

  List(this.listKey);

  @override
  Widget build(BuildContext context) {
    return Text(listKey);
  }
}