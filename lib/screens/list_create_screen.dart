import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';

class ListCreateScreen extends StatefulWidget {
  static const routeName = '/list/create';

  @override
  _ListCreateScreenState createState() => _ListCreateScreenState();
}

class _ListCreateScreenState extends State<ListCreateScreen> {
  final _form = GlobalKey<FormState>();
  bool _isShared = false;
  Color _pickerColor = Color(0xff03a9f4);

  @override
  Widget build(BuildContext context) {
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
                pickerColor: _pickerColor,
                onColorChanged: (value) {
                  setState(() {
                    _pickerColor = value;
                  });
                },
                layoutBuilder: (BuildContext context, List<Color> colors, PickerItem child) {
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
                onPressed: () => {},
              )
            ],
          ),
        ),
      ),
    );
  }
}