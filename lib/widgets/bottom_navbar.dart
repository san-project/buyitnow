import 'package:buyitnow/screens/cart/cart_screen.dart';
import 'package:buyitnow/screens/categories/categories_screen.dart';
import 'package:buyitnow/screens/home_screen.dart';
import 'package:buyitnow/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ButtomNavBar extends StatefulWidget {
  const ButtomNavBar({super.key});

  @override
  State<ButtomNavBar> createState() => _ButtomNavBarState();
}

class _ButtomNavBarState extends State<ButtomNavBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOption = <Widget>[
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(), 
    ProfileScreen(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child :_widgetOption.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15.0),
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          gap: 8,
          padding: const EdgeInsets.all(8.0),
          onTabChange: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: const [
            GButton(icon: Icons.home,text: 'Home',),
            GButton(icon: Icons.category,text: 'categories',),
            GButton(icon: Icons.badge,text: 'Cart',),
            GButton(icon: Icons.person,text: 'profile',),
          ]
          ),
      ),
    );
  }
}