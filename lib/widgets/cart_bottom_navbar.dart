import 'package:buyitnow/providers/cart_provider.dart';
import 'package:buyitnow/providers/order_provider.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class CartBottomBar extends StatelessWidget {
  CartBottomBar({super.key});

  final address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Consumer2<CartProvider, OrderProvider>(
          builder: (context, provider, orderProvider, _) {
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
                onPressed: () async {
                  await showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      enableDrag: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              TextField(
                                controller: address,
                                decoration: const InputDecoration(
                                    hintText: 'Address',
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 231, 226, 226)),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              const Text('Payment Mode: '),
                              SizedBox(
                                height: 70.h,
                                width: SizeConfig.screenWidth,
                                child: Row(
                                  children: [
                                    Radio(
                                        activeColor: Colors.orange[700],
                                        value: orderProvider.paymentMode,
                                        groupValue: PaymentMode.cashOnDelivery,
                                        onChanged: (v) {}),
                                    const Text('Cash On Delivery'),
                                    Radio(
                                        value: orderProvider.paymentMode,
                                        groupValue: PaymentMode.paypal,
                                        onChanged: (v) {}),
                                    const Text(
                                      'Payment (coming soon)',
                                      style: TextStyle(color: Colors.grey),
                                    )
                                    // RadioListTile(
                                    //   title: const Text('Cash On Delivery'),
                                    //   value: orderProvider.paymentMode,
                                    //   groupValue: PaymentMode.cashOnDelivery,
                                    //   onChanged: (value) {},
                                    // ),
                                    // RadioListTile(
                                    //   title: const Text('Paypal (coming soon)'),
                                    //   value: orderProvider.paymentMode,
                                    //   groupValue: PaymentMode.cashOnDelivery,
                                    //   onChanged: (value) {},
                                    // ),
                                  ],
                                ),
                              ),
                              Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (address.text.isEmpty) {
                                        return;
                                      }
                                      orderProvider
                                          .addNewOrder(context, address.text)
                                          .then((value) =>
                                              provider.getCartProduct(context));
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Order Now')),
                              )
                            ],
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
