import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/auth.dart';
import '../widgets/main_drawer.dart';

class ListsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<Auth>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Lists'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {}
          )
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}