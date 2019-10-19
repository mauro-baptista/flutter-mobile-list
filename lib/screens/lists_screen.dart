import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import '../models/user.dart';
import '../providers/auth.dart';
import '../screens/list_create_screen.dart';
import '../widgets/main_drawer.dart';
import '../widgets/list.dart';

class ListsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User _user = Provider.of<Auth>(context).user;

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
      body: new FirebaseAnimatedList(
        key: new ValueKey<bool>(false),
        query: _user.lists(),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          return new SizeTransition(
            sizeFactor: animation,
            child: List(snapshot),
          );
        },
      ),
    );
  }
}