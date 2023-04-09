import 'package:buyitnow/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import '../screens/login/login_screen.dart';

Future<bool?> checkLogin(BuildContext context) async {
  final token = SharedPrefs.instance().token;
  if (token == null) {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Please Sing In'),
        actions: [
          ElevatedButton(
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
