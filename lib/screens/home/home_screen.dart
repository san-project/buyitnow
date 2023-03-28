import 'package:buyitnow/screens/product_details/product_details.dart';
import 'package:buyitnow/utils/colors.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../models/product_model.dart';
import '../../widgets/categories_widget.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});
  final items = Product.getProducts();

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: const Text(
          'BuyItNow',
          style: TextStyle(fontSize: 22, color: AppColors.textColor),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: AppColors.textColor,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 25.h, left: 22.w, right: 22.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Our Product',
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Sort by',
                  style: TextStyle(color: AppColors.grayColor),
                )
              ],
            ),
            SizedBox(
              height: 28.h,
            ),
            const CategoriesWidget(),
            SizedBox(
              height: 25.h,
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: widget.items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      mainAxisExtent: 257),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                                item: widget.items[index])));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: AppColors.cardColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                //padding: EdgeInsets.all(10),
                                height: 147.h,
                                width: double.infinity,
                                child: Image.network(
                                  widget.items[index].image,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                )),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              widget.items[index].name,
                              style: const TextStyle(
                                  color: Color(0xff4a5086),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              widget.items[index].price.toString(),
                              style: const TextStyle(
                                  color: AppColors.priceColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBarIndicator(
                                  rating: 2.75,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 17.0,
                                  direction: Axis.horizontal,
                                ),
                                const Text("(3)")
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
