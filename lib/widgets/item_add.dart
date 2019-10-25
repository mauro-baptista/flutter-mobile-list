import 'package:flutter/material.dart';

import '../providers/lists.dart';
import '../providers/items.dart';

class ItemAdd extends StatefulWidget {
  final Lists list;

  ItemAdd(this.list);

  @override
  _ItemAddState createState() => _ItemAddState();
}

class _ItemAddState extends State<ItemAdd> {
  final _form = GlobalKey<FormState>();

  String _name;

  bool _isLoading = false;

  void _saveForm(BuildContext context) {
    if (!_form.currentState.validate()) {
      return;
    }

    _form.currentState.save();
    
    setState(() {
      _isLoading = true;
    });

    Items(
      name: _name,
      list: widget.list,
    ).store();

    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _form,
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: '',
              decoration: InputDecoration(
                labelText: 'Item',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Item is required';
                }

                return null;
              },
              onSaved: (value) {
                _name = value;
              }
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton.icon(
                icon: Icon(Icons.add),
                label: Text('Add Item'),
                color: widget.list.color,
                textColor: Colors.white,
                elevation: 0,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () => _isLoading ? null : _saveForm(context),
              ),
          ],
        ),
      ),
    );
  }
}