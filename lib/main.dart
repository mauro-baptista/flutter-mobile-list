import 'package:flutter/material.dart';
import 'package:mobile_list/screens/login_screen.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './screens/lists_screen.dart';

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
          home: auth.isAuth ? ListsScreen() : LoginScreen()
        ),
      ),
    );
  }
}