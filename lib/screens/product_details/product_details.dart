import 'package:buyitnow/models/get_product_model.dart';
import 'package:buyitnow/providers/cart_provider.dart';
import 'package:buyitnow/providers/product_provider.dart';
import 'package:buyitnow/screens/login/login_screen.dart';
import 'package:buyitnow/utils/extensions.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../utils/check_login.dart';
import '../../utils/colors.dart';
import '../../utils/shared_prefs.dart';
import '../cart/cart_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.item});
  final ProductModel item;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late bool isFavourite;
  int _curernt = 0;
  late final List<String> _images;
  @override
  void initState() {
    isFavourite = widget.item.isFavourite;
    _images = widget.item.images.map((e) => e.url).toList();
    _images.insert(0, widget.item.thumbnail.url);
    super.initState();
  }

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
                  CarouselSlider(
                    items: _images
                        .map((item) => Container(
                              child: CachedNetworkImage(
                                imageUrl: item,
                                height: 351.00.h,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 1.0,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _curernt = index;
                          });
                        }),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _images.map((url) {
                        int index = _images.indexOf(url);
                        return Container(
                          width: 8.h,
                          height: 8.h,
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 3,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _curernt == index
                                ? Color.fromRGBO(0, 0, 0, 0.9)
                                : Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                        );
                      }).toList(),
                    ),
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
                    child: IconButton(
                      onPressed: () async {
                        final isLoggedIn = await checkLogin(context) ?? false;
                        if (isLoggedIn && mounted) {
                          context
                              .read<ProductProvider>()
                              .addOrRemoveProductWishlist(
                                  widget.item.id, isFavourite, context);
                          setState(() {
                            isFavourite = !isFavourite;
                          });
                        }
                      },
                      icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
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
                              widget.item.name,
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
                        Text(widget.item.description),
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
                            Text(widget.item.seller.businessName)
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
                      '₹ ${widget.item.price.toString()}',
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
                      onPressed: () async {
                        final isLoggedIn = await checkLogin(context) ?? false;
                        if (isLoggedIn && mounted) {
                          context
                              .read<CartProvider>()
                              .addCartProduct(widget.item.id, context);
                        }
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
          color: widget.item.isFavourite ? Colors.red : Colors.grey,
          size: size),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: const BorderRadius.all(Radius.circular(13)));
  }
}
