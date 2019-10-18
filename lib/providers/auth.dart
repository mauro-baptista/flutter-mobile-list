import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  User _user;

  bool get isAuth {
    return _user != null;
  }

  User get user {
    return _user;
  }

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    if (! prefs.containsKey('user')) {
      _googleSingIn();
      
      return;
    }

    _user = User.fromMap(prefs.get('user'));

    notifyListeners();
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');

    _user = null;
    
    _signOutGoogle();
  }

  Future<void> _googleSingIn() async {
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final FirebaseUser user = (await _firebaseAuth.signInWithCredential(credential)).user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);

    _user = User(
      id: user.uid,
      name: user.displayName,
      email: user.email,
      image: user.photoUrl,
    );

    (await SharedPreferences.getInstance()).setString('user', _user.toJson());

    notifyListeners();
  } 

  void _signOutGoogle() async {
    await _googleSignIn.signOut();

    notifyListeners();
  }
}