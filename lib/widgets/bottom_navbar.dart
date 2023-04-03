import 'package:buyitnow/screens/cart/cart_screen.dart';
import 'package:buyitnow/screens/categories/categories_screen.dart';

import 'package:buyitnow/screens/profile/profile_screen.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../screens/home/home_screen.dart';

class ButtomNavBars extends StatefulWidget {
  const ButtomNavBars({super.key});

  @override
  State<ButtomNavBars> createState() => _ButtomNavBarsState();
}

class _ButtomNavBarsState extends State<ButtomNavBars> {
  int _selectedIndex = 0;
  List<Widget> _widgetOption = [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOption.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: const EdgeInsets.all(8.0),
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.category,
                text: 'categories',
              ),
              GButton(
                icon: Icons.shopping_bag_outlined,
                text: 'Cart',
              ),
              GButton(
                icon: Icons.person,
                text: 'profile',
              ),
            ]),
      ),
    );
  }
}
