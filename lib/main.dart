import 'package:flutter/material.dart';

import '../screens/new_compliment.dart';
import '../screens/home_screen.dart';
import '../screens/share_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compliments',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        NewCompliment.routeName: (context) => const NewCompliment(),
        ShareScreen.routeName: (context) => ShareScreen(),
      },
    );
  }
}
