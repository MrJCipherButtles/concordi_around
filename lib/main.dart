import 'package:concordi_around/provider/map_notifier.dart';
import 'package:concordi_around/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ConcordiAround',
        home: MultiProvider(providers: [
          ChangeNotifierProvider(create: (context) => MapNotifier())
        ], child: HomePage()));
  }
}
