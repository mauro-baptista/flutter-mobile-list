import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './screens/lists_screen.dart';
import './screens/list_connect_screen.dart';
import './screens/list_create_screen.dart';
import './screens/login_screen.dart';
import './screens/settings_screen.dart';

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
          title: 'Mobile App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.greenAccent,
          ),
          home: auth.isAuth ? ListsScreen() : LoginScreen(),
          routes: {
            ListCreateScreen.routeName: (context) => ListCreateScreen(),
            ListConnectScreen.routeName: (context) => ListConnectScreen(),
            SettingsScreen.routeName: (context) => SettingsScreen(),
          },
        ),
      ),
    );
  }
}