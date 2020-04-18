import 'package:flutter/material.dart';

class UserInfoWidgets {
  static var name = Text("John Doe");
  static var email = Text("40022345");

  static Widget avatar = CircleAvatar(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    child: Text(
      "JD",
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
