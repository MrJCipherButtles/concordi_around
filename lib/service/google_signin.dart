import 'dart:async';
import 'dart:convert' show json;

import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/calendar.readonly',
  ],
);

class GoogleLogIn extends _GoogleLogIn {

  GoogleLogIn._privateConstructor() {}
  static final GoogleLogIn instance = GoogleLogIn._privateConstructor();
}

class _GoogleLogIn {
  GoogleSignInAccount _currentUser;

  getCurrentUser() async {
    if (_googleSignIn.currentUser == null) {
      _currentUser = await _googleSignIn.signInSilently();
      if (_currentUser == null) {
        await _handleSignIn();
      }
    }

    if (_currentUser != null) {
      return _currentUser;
    }
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }


}
