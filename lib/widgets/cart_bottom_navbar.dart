import 'package:buyitnow/providers/cart_provider.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class CartBottomBar extends StatelessWidget {
  const CartBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Consumer<CartProvider>(builder: (context, provider, _) {
        return Container(
          height: 70.h,
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          decoration: const BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹ ${provider.cart!.totalPrice}',
                style: TextStyle(
                    fontSize: 25,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold),
              ),
              FloatingActionButton.extended(
                label: const Text(
                  'Check Out',
                  style: TextStyle(color: AppColors.priceColor),
                ), // <-- Text
                backgroundColor: Colors.grey.shade300,
                icon: const Icon(
                  // <-- Icon
                  CupertinoIcons.cart_badge_plus,
                  color: AppColors.priceColor,
                  size: 24.0,
                ),
                onPressed: () {
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => CartScreen()));
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
