import 'package:flutter/material.dart';

class UserInfoWidgets {
  static var name = Text("User Unavailable");
  static var email = Text("Sign in with My Calendar");

  static Widget avatar = CircleAvatar(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    child: Text(
      "UU",
      style: TextStyle(fontSize: 40.0),
    ),
  );

  static Widget setName(var name) {
    return Text(name);
  }

  static Widget setEmail(var email) {
    return Text(email);
  }

  static Widget setAvatar(var avatar) {
    return avatar = Center(
        child: Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image:
              DecorationImage(fit: BoxFit.fill, image: NetworkImage(avatar))),
    ));
  }
}
