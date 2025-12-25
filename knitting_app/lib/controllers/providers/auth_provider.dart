import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;
  bool get isLoggedIn => _user != null;

  AuthProvider() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
