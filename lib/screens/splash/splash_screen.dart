import 'dart:async';

import 'package:buyitnow/screens/login/login_screen.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/bottom_navbar.dart';
import '../login/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async{
      //  SharedPreferences prefs =await SharedPreferences.getInstance();
      //  var token = prefs.getString('token');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ButtomNavBar() ));
     });
  }

  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text('BuyItNow',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}