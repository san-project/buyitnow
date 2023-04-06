import 'package:buyitnow/models/get_product_model.dart';
import 'package:buyitnow/utils/extensions.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../utils/colors.dart';
import '../cart/cart_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.item});
  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 351.00.h,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: item.thumbnail.url,
                    height: 351.00.h,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: ElevatedButton(
                        // color: Colors.red,

                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black12,
                            padding: EdgeInsets.all(8.w),
                            shape: const CircleBorder()),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 25.w,
                          color: Colors.white,
                        )),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Icon(
                      item.isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            // Expanded(
            //   child: DraggableScrollableSheet(
            //     expand: true,
            //     builder: (context, scrollController) {
            //       return Container(
            //         color: Colors.red,
            //       );
            //     },
            //   ),
            // ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffe5e5e9),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 35.h),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.name,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: AppColors.priceColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBarIndicator(
                                  rating: 2.75,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 1,
                                  itemSize: 25.0,
                                  direction: Axis.horizontal,
                                ),
                                Text("(3.5)")
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(item.description),
                        SizedBox(
                          height: 26.h,
                        ),
                        Row(
                          children: [
                            Text(
                              ' Seller : ',
                              style: TextStyle(
                                  color: AppColors.grayColor, fontSize: 16),
                            ),
                            Text(item.seller.businessName)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            BottomAppBar(
              child: Container(
                height: 70.h,
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹ ${item.price.toString()}',
                      style: TextStyle(
                          fontSize: 25,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                    FloatingActionButton.extended(
                      label: Text(
                        'add To Cart',
                        style: TextStyle(color: AppColors.priceColor),
                      ), // <-- Text
                      backgroundColor: Colors.grey.shade300,
                      icon: Icon(
                        // <-- Icon
                        CupertinoIcons.cart_badge_plus,
                        color: AppColors.priceColor,
                        size: 24.0,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CartScreen()));
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _icon(
    IconData icon, {
    Color color = const Color(0xffa8a09b),
    double size = 20,
    double padding = 10,
    bool isOutLine = false,
    Function? onPressed,
  }) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color(0xffa8a09b),
            style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        color: isOutLine ? Colors.transparent : Colors.grey,
        boxShadow: const [
          BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 5,
              spreadRadius: 10,
              offset: Offset(5, 5)),
        ],
      ),
      child: Icon(icon,
          color: item.isFavourite ? Colors.red : Colors.grey, size: size),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: const BorderRadius.all(Radius.circular(13)));
  }
}
