import 'package:concordi_around/service/map_constant.dart' as constant;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SpinKitRipple(
      color: constant.COLOR_CONCORDIA,
      size: 100.0,
    ));
  }
}
