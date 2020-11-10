import 'package:flutter/material.dart';
import 'package:tic_tac_toe/win_screen.dart';
import 'screen.dart';
import 'initial_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        MyHomePage.routeName: (context) => MyHomePage(),
        WinScreen.routeName: (context) => WinScreen(),
      },
    );
  }
}
