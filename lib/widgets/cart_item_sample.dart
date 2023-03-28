import 'package:buyitnow/utils/colors.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItemSamples extends StatelessWidget {
  const CartItemSamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < 3; i++)
          Container(
            height: 110.h,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: 70.h,
                  // width: 70.w,
                  child: Image.network(
                    'https://i.pinimg.com/550x/72/a4/30/72a430c1c88f7a478c866d378d6fe67c.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Product Title',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      const Text(
                        '₹ 800.00',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.priceColor,
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                  )
                                ]),
                            child: Icon(
                              CupertinoIcons.minus,
                              size: 18,
                            ),
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              '01',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                  )
                                ]),
                            child: Icon(
                              CupertinoIcons.plus,
                              size: 18,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}
