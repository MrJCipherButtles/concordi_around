import 'dart:async';
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
    Map<String, String> auth;

    

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount account) async {
      print("got new account" + account.toString());
      _currentUser = account;
      auth = await _currentUser.authHeaders;
      return auth;
    });

    if (_currentUser != null) {
      auth = await _currentUser.authHeaders;
      return auth;
    }

    if (_googleSignIn.currentUser == null) {
      if (_currentUser == null) {
        await _handleSignIn();
      }
    }

    _currentUser = await _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }
}
