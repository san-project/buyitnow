import 'package:buyitnow/providers/auth_provider.dart';
import 'package:buyitnow/providers/cart_provider.dart';
import 'package:buyitnow/providers/category_provider.dart';
import 'package:buyitnow/providers/product_provider.dart';
import 'package:buyitnow/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.instance().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<ProductProvider>(
            create: (_) => ProductProvider()),
        ChangeNotifierProvider<CategoryProvider>(
            create: (_) => CategoryProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Buy It Now',
          theme: ThemeData(useMaterial3: true),
          home: SplashScreen()),
    );
  }
}
