import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/auth.dart';
import '../providers/lists.dart';
import '../screens/list_create_screen.dart';
import '../widgets/main_drawer.dart';
import '../widgets/list.dart' as listWidget;

class ListsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User _user = Provider.of<Auth>(context, listen: false).user;
    
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
      body: Consumer<Lists>(
        builder: (context, auth, child) => FutureBuilder(
          future: Lists().lists(_user.firebaseId),
          builder: (context, response) {
            if (response.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: response.data?.length ?? 0,
              itemBuilder: (context, index) {
                if (response.data == null) {
                  return null;
                }
                
                return listWidget.List(response.data[index]);
              },
            );
          },
        ),
      ),
    );
  }
}