import 'package:buyitnow/screens/home_screen.dart';
import 'package:buyitnow/screens/login/login_screen.dart';
import 'package:buyitnow/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: const Color(0xfff3f3f3)),
      home: ButtomNavBar(),
    );
  }
}
