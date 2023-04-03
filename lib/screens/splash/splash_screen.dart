import 'dart:async';

import 'package:buyitnow/screens/login/login_screen.dart';
import 'package:buyitnow/utils/shared_prefs.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/material.dart';

import '../../widgets/bottom_navbar.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      final token = SharedPrefs.instance().token;

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  token != null ? const ButtomNavBars() : const SiginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text(
            'BuyItNow',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
