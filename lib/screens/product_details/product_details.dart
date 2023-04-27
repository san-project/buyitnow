import 'package:buyitnow/models/get_product_model.dart';
import 'package:buyitnow/providers/cart_provider.dart';
import 'package:buyitnow/providers/product_provider.dart';
import 'package:buyitnow/screens/seller_product/seller_product_screen.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../utils/check_login.dart';
import '../../utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../widgets/bottom_navbar.dart';

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
  late bool isAddedToCart;

  @override
  void initState() {
    isFavourite = widget.item.isFavourite;
    _images = widget.item.images.map((e) => e.url).toList();
    _images.insert(0, widget.item.thumbnail.url);
    isAddedToCart = context.read<CartProvider>().cart?.cart.any(
              (element) => element.product.id == widget.item.id,
            ) ??
        false;
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
                        .map((item) => CachedNetworkImage(
                              imageUrl: item,
                              height: 351.00.h,
                              width: double.infinity,
                              fit: BoxFit.contain,
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
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 3,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _curernt == index
                                ? const Color.fromRGBO(0, 0, 0, 0.9)
                                : const Color.fromRGBO(0, 0, 0, 0.4),
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
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
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
                            Expanded(
                              child: Text(
                                widget.item.name,
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: AppColors.priceColor,
                                    fontWeight: FontWeight.bold),
                              ),
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
                                  itemCount: 1,
                                  itemSize: 25.0,
                                  direction: Axis.horizontal,
                                ),
                                const Text("(3.5)")
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
                            const Text(
                              ' Seller : ',
                              style: TextStyle(
                                  color: AppColors.grayColor, fontSize: 16),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SellerProductScreen(
                                            sellerName:
                                                widget.item.seller.businessName,
                                            sellerId: widget.item.seller.id,
                                          )));
                                },
                                child: Text(
                                  widget.item.seller.businessName,
                                  style: const TextStyle(color: Colors.blue),
                                ))
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
                decoration: const BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹ ${widget.item.price.toString()}',
                      style: const TextStyle(
                          fontSize: 25,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Consumer<CartProvider>(builder: (context, provider, _) {
                      final isOutOfStock = widget.item.countInStock <= 0;
                      final isAddedToCart =
                          provider.cartProducts.contains(widget.item.id);
                      return FloatingActionButton.extended(
                        label: isOutOfStock
                            ? const Text('Out Of Stock')
                            : Text(
                                isAddedToCart ? 'Go To Cart' : 'Add To Cart',
                                style: const TextStyle(
                                    color: AppColors.priceColor),
                              ), // <-- Text
                        backgroundColor:
                            isOutOfStock ? Colors.grey : Colors.orange[400],
                        icon: const Icon(
                          // <-- Icon
                          CupertinoIcons.cart_badge_plus,
                          color: AppColors.priceColor,
                          size: 24.0,
                        ),
                        onPressed: isOutOfStock
                            ? null
                            : () async {
                                final isLoggedIn =
                                    await checkLogin(context) ?? false;

                                if (isLoggedIn && mounted) {
                                  !isAddedToCart
                                      ? context
                                          .read<CartProvider>()
                                          .addCartProduct(
                                              widget.item.id, context)
                                      : Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const ButtomNavBars(
                                                    index: 2,
                                                  )));
                                }
                              },
                      );
                    }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
