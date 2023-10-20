import 'package:flutter/material.dart';

import 'home/ui/home.dart';

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
    return MaterialApp(
      title: 'Flutter Boilerplate',
      theme: ThemeData.light().copyWith(cardTheme: cardTheme),
      darkTheme: ThemeData.dark().copyWith(cardTheme: cardTheme),
      themeMode: ThemeMode.system,
      initialRoute: Home.routeName,
      routes: {
        Home.routeName: (context) => const Home(), // Named routes are no longer recommended. Use a router instead? https://docs.flutter.dev/ui/navigation  https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade
      },
    );
  }
}

/*

// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}

// A button that navigates to a named route.
// The named route extracts the arguments
// by itself.
ElevatedButton(
  onPressed: () {
    // When the user taps the button,
    // navigate to a named route and
    // provide the arguments as an optional
    // parameter.
    Navigator.pushNamed(
      context,
      Home.routeName,
      arguments: ScreenArguments(
        'Extract Arguments Screen',
        'This message is extracted in the build method.',
      ),
    );
  },
  child: const Text('Navigate to screen that extracts arguments'),
),

 */