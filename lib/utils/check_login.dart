import 'package:buyitnow/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import '../screens/login/login_screen.dart';

Future<bool?> checkLogin(BuildContext context) async {
  final token = SharedPrefs.instance().token;
  if (token == null) {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        // title: Icon(
        //   Icons.person_4_sharp,
        //   color: Colors.tealAccent,
        // ),
        contentPadding: const EdgeInsets.all(16),
        actionsPadding: EdgeInsets.all(2),
        content: const Text(
            'Please log in or create an account to add this product to your cart.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const SiginPage(),
                ),
                (route) => false,
              );
            },
            child: const Text('Sign In'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  } else {
    return true;
  }
}
