import 'package:flutter/material.dart';

import '../providers/lists.dart';
import '../screens/list_show_screen.dart';

class List extends StatefulWidget {
  final String listKey;

  List(this.listKey);

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  Lists _list = Lists(color: Colors.black, title: 'Failed to Load List'); 
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
    return _isLoading
      ? CircularProgressIndicator()
      : GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => ListShowScreen(widget.listKey),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          height: 70,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: Card(
              child: Text(
                _list.title,
                style: TextStyle(
                  color: _list.color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
  }
}