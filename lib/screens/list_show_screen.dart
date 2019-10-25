import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/items.dart';
import '../providers/lists.dart';
import '../widgets/item_add.dart';

class ListShowScreen extends StatefulWidget {
  final String listKey;

  ListShowScreen(this.listKey);

  @override
  _ListShowScreenState createState() => _ListShowScreenState();
}

class _ListShowScreenState extends State<ListShowScreen> {
  Lists _list = Lists(color: Colors.black, title: 'Loading'); 
  bool _runLoadList = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _loadList();
    
    super.didChangeDependencies();
  }

  void _loadList() async {
    if (!_runLoadList) {
      return;
    }

    _runLoadList = false;
    _isLoading = true;

    var list = await Lists().fetch(widget.listKey);
    
    setState(() {
      _list = list;
    });

    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_list.title),
        backgroundColor: _list.color,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ItemAdd(_list);
                },
              );
            },
          ),
        ],
      ),
      body: _isLoading
        ? CircularProgressIndicator()
        : Consumer<Items>(
        builder: (context, auth, child) => FutureBuilder(
          future: Items().items(_list.id),
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
                
                return ...response.data.map((Map<String, dynamic> values) {
                  return Text('value');
                }).toList();
              },
            );
          },
        ),
      ),
    );
  }
}