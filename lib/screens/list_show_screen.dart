import 'dart:core';

import 'package:flutter/material.dart';

import '../models/list.dart';

class ListShowScreen extends StatefulWidget {
  final String listKey;

  ListShowScreen(this.listKey);

  @override
  _ListShowScreenState createState() => _ListShowScreenState();
}

class _ListShowScreenState extends State<ListShowScreen> {
  List _list = List(color: Colors.black, title: 'Loading'); 
  bool _runLoadList = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_runLoadList) {
      _loadList();
    }
    
    super.didChangeDependencies();
  }

  void _loadList() async {
    _runLoadList = false;
    _isLoading = true;

    var list = await List().fetch(widget.listKey);
    
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
      ),
      body: Text('TODO: List Show'),
    );
  }
}