import 'package:concordi_around/widget/user/user_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  test('Testing User info', () {
    expect(UserInfoWidgets.setName('John').toString(), Text('John').toString());
    expect(UserInfoWidgets.setEmail('JohnDoe@email.com').toString(),
        Text('JohnDoe@email.com').toString());
  });
}
