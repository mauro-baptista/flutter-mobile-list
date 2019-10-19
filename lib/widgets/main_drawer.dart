import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context, listen: false);

    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Mobile List'),
            automaticallyImplyLeading: false,
          ),
          Container(
            width: double.infinity,
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    right: 20,
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(_auth.user.image),
                    backgroundColor: Colors.white,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _auth.user.name,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(
                      _auth.user.email,
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              _auth.logout();
            }
          ),
        ],
      ),
    );
  }
}