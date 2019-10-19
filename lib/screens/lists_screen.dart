import 'package:flutter/material.dart';

import '../screens/list_create_screen.dart';
import '../widgets/main_drawer.dart';

class ListsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Lists'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(ListCreateScreen.routeName);
            }
          )
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}