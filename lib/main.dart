import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './screens/lists_screen.dart';
import './screens/list_connect.dart';
import './screens/list_create.dart';
import './screens/login_screen.dart';
import './screens/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.greenAccent,
          ),
          home: auth.isAuth ? ListsScreen() : LoginScreen(),
          routes: {
            ListCreate.routeName: (context) => ListCreate(),
            ListConnect.routeName: (context) => ListConnect(),
            Settings.routeName: (context) => Settings(),
          },
        ),
      ),
    );
  }
}