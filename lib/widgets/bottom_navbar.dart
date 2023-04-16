import 'package:buyitnow/screens/cart/cart_screen.dart';
import 'package:buyitnow/screens/categories/categories_screen.dart';

import 'package:buyitnow/screens/profile/profile_screen.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../screens/home/home_screen.dart';

class ButtomNavBars extends StatefulWidget {
  const ButtomNavBars({super.key, this.index = 0});
  final int index;
  @override
  State<ButtomNavBars> createState() => _ButtomNavBarsState();
}

class _ButtomNavBarsState extends State<ButtomNavBars> {
  late int _selectedIndex;
  final List<Widget> _widgetOption = [
    const HomeScreen(),
    const CategoriesScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    _selectedIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOption.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: const Color(0xffebf1e6),
        child: GNav(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            gap: 8,
            backgroundColor: const Color(0xffebf1e6),
            color: Colors.grey.shade800,
            activeColor: Colors.black,
            tabBackgroundColor: const Color(0xffd9e7cb),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            selectedIndex: _selectedIndex,
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
