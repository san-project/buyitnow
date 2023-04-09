import 'dart:developer';

import 'package:buyitnow/providers/product_provider.dart';
import 'package:buyitnow/screens/product_details/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProductProvider>().getWishlistProducts(context);
      log("timeframe $timeStamp");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text('Wishlist'),
        centerTitle: true,
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.wishlist.isEmpty) {
            return const Center(
                child: Text('You have not added any product to wishlist'));
          } else {
            return ListView.builder(
              itemCount: provider.wishlist.length,
              itemBuilder: (context, index) {
                final currentProduct = provider.wishlist[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsScreen(item: currentProduct),
                    ));
                  },
                  leading: Image.network(currentProduct.thumbnail.url),
                  title: Text(currentProduct.name),
                  subtitle: Text(
                    currentProduct.description,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border)),
                );
              },
            );
          }
        },
      ),
    );
  }
}
