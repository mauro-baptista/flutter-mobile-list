import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/auth.dart';
import '../screens/list_create_screen.dart';
import '../widgets/main_drawer.dart';
import '../widgets/list.dart' as list;

class ListsScreen extends StatelessWidget {
  
  Future<List<list.List>> _loadLists(User user) async {
      List<String> lists = await user.lists();
      
      return lists.map((listKey) => list.List(listKey)).toList();
  }

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
      body: FutureBuilder(
        future: _user.lists(),
        builder: (context, response) {
          if (response.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: response.data.length,
            itemBuilder: (context, index) {
              return list.List(response.data[index]);
            },
          );
        },
      ),
    );
  }
}