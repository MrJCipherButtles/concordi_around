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

  GoogleSignInAccount get currentUser => _currentUser;

  silentSignIn() async {
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount account) async {
      _currentUser = account;
    });

    return await _googleSignIn.signInSilently();
  }

  getCurrentUserAuth() async {
    Map<String, String> auth;

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount account) async {
      _currentUser = account;
      auth = await _currentUser.authHeaders;
      return auth;
    });

    _currentUser = await _googleSignIn.signInSilently();

    if (_currentUser != null) {
      auth = await _currentUser.authHeaders;
      return auth;
    }

    if (_googleSignIn.currentUser == null) {
      if (_currentUser == null) {
        await _handleSignIn();
      }
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
