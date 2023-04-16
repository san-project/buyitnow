import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: 50,
          width: 50,
          child: Lottie.asset('assets/animations/empty_cart.json')),
    );
  }
}
