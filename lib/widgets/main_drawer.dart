import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/list_connect_screen.dart';
import '../screens/list_create_screen.dart';
import '../screens/settings_screen.dart';

class MainDrawer extends StatelessWidget {

  Widget _userInfo(BuildContext context, Auth auth) {
    return Container(
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
              backgroundImage: NetworkImage(auth.user.image),
              backgroundColor: Colors.white,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                auth.user.name,
                style: Theme.of(context).textTheme.title,
              ),
              Text(
                auth.user.email,
                style: Theme.of(context).textTheme.subtitle,
              ),
            ],
          )
        ],
      ),
    );
  }

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
          _userInfo(context, _auth),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Create new List'),
            onTap: () {
              Navigator.of(context).pushNamed(ListCreateScreen.routeName);
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.cloud_queue),
            title: Text('Connect to a List'),
            onTap: () {
              Navigator.of(context).pushNamed(ListConnectScreen.routeName);
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            }
          ),
          Divider(),
          Expanded(
            child: Container(),
          ),
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