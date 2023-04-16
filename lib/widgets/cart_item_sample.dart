import 'package:buyitnow/models/cart_model.dart';
import 'package:buyitnow/providers/cart_provider.dart';
import 'package:buyitnow/utils/colors.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cart});
  final CartElement cart;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.grayColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            cart.product.thumbnail.url,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20.w,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 140.w),
                  child: Text(
                    cart.product.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Text(
                  '₹ ${cart.product.price}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.priceColor,
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    context
                        .read<CartProvider>()
                        .deleteCart(context, cart.id, cart.product.id);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: cart.quantity <= 1
                          ? null
                          : () {
                              context
                                  .read<CartProvider>()
                                  .updateCartProduct(context, cart.id, false);
                            },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color:
                                cart.quantity == 1 ? Colors.grey : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 10,
                              )
                            ]),
                        child: const Icon(
                          CupertinoIcons.minus,
                          size: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        '${cart.quantity}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    InkWell(
                      onTap: () {
                        context
                            .read<CartProvider>()
                            .updateCartProduct(context, cart.id, true);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: const Icon(
                          CupertinoIcons.plus,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
