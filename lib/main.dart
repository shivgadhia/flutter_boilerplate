import 'package:flutter/material.dart';

import 'main_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var cardTheme = CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));

    var navigation = MainNavigator();

    return MaterialApp(
      title: 'Flutter Boilerplate',
      theme: ThemeData.light().copyWith(cardTheme: cardTheme),
      darkTheme: ThemeData.dark().copyWith(cardTheme: cardTheme),
      themeMode: ThemeMode.system,
      initialRoute: navigation.initialRoute(),
      routes: navigation.routes(),
    );
  }
}
