import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../models/user.dart';
import '../models/list.dart';
import './list_show_screen.dart';

class ListCreateScreen extends StatefulWidget {
  static const routeName = '/list/create';

  @override
  _ListCreateScreenState createState() => _ListCreateScreenState();
}

class _ListCreateScreenState extends State<ListCreateScreen> {
  final _form = GlobalKey<FormState>();
  

  String _title;
  bool _isShared = false;
  Color _pickedColor = Color(0xff03a9f4);

  bool _isLoading = false;

  void _saveForm(BuildContext context, User user) {
    if (!_form.currentState.validate()) {
      return;
    }

    _form.currentState.save();
    
    setState(() {
      _isLoading = true;
    });

    String listKey = List(
      title: _title,
      color: _pickedColor,
      shared: _isShared,
      user: user,
    ).store();
        
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => ListShowScreen(listKey),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<Auth>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create New List'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: '',
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Title is required';
                  }

                  return null;
                },
                onSaved: (value) {
                  _title = value;
                }
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Text(
                  'Choose a Color:',
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              BlockPicker(
                pickerColor: _pickedColor,
                onColorChanged: (Color value) {
                  setState(() {
                    _pickedColor = value;
                  });
                },
                layoutBuilder: (context, colors, child) {
                  return Container(
                    width: double.infinity,
                    height: 310,
                    child: GridView.count(
                      crossAxisCount: 5,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      children: colors.map((Color color) => child(color)).toList(),
                    ),
                  );
                }
              ),
              SwitchListTile(
                title: Text('Share list'),
                value: _isShared,
                subtitle: Text('Will this list be shared with others?'),
                onChanged: (value) {
                  setState(() {
                    _isShared = value;
                  });
                },
              ),
              RaisedButton.icon(
                icon: Icon(Icons.add),
                label: Text('Create List'),
                color: Theme.of(context).accentColor,
                elevation: 0,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () => _isLoading ? null : _saveForm(context, _user),
              ),
            ],
          ),
        ),
      ),
    );
  }
}