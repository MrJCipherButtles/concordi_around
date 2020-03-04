import 'package:concordi_around/widgets/drawer.dart';
import 'package:concordi_around/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Map(), 
        drawer: SidebarDrawer(), 
        resizeToAvoidBottomInset: false);
  }
}
