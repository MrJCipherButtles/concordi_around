import 'package:concordi_around/widget/drawer.dart';
import 'package:concordi_around/widget/map.dart';
import 'package:flutter/material.dart';

import 'package:concordi_around/views/goto_page.dart';

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
        body: Map(), drawer: SidebarDrawer(), resizeToAvoidBottomInset: false);
  }
}
