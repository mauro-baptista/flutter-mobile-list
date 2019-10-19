import 'package:flutter/material.dart';

class ListCreateScreen extends StatelessWidget {
  static const routeName = '/list/create';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New List'),
      ),
      body: Text('TODO: Add New'),
    );
  }
}