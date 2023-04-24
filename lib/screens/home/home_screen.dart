import 'dart:developer';

import 'package:buyitnow/providers/category_provider.dart';
import 'package:buyitnow/widgets/filter_diolog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../providers/product_provider.dart';
import '../../utils/check_login.dart';
import '../../widgets/loading_widget.dart';
import '../wishlist/wishlist_screen.dart';
import 'package:buyitnow/screens/product_details/product_details.dart';
import 'package:buyitnow/utils/colors.dart';
import 'package:buyitnow/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProductProvider>().getAllProducts(context);
      context.read<CategoryProvider>().getAllCategories(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController = TextEditingController();
    super.dispose();
  }

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
            onPressed: () async {
              final isLoggedIn = await checkLogin(context) ?? false;
              if (isLoggedIn && mounted) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const WishlistScreen()));
              }
            },
            icon: const Icon(Icons.favorite_outline),
            color: AppColors.textColor,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 5.h, left: 22.w, right: 22.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // const CategoriesWidget(),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search....',
                    hintStyle: TextStyle(
                        fontSize: 16, color: Colors.black.withOpacity(0.6)),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    // fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  onChanged: (value) {
                    context
                        .read<ProductProvider>()
                        .getSearchProducts(context, value);
                  },
                )),
                SizedBox(
                  width: 10.w,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      fixedSize: Size(50.w, 50.w),
                      padding: const EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    // color: Colors.black,
                    onPressed: () async {
                      await showFilterOptions(context);
                      // if (context
                      //         .read<CategoryProvider>()
                      //         .selectedCategories
                      //         .isEmpty &&
                      //     context.read<CategoryProvider>().radioValues ==
                      //         RadioValues.relevance) {
                      // }
                    },
                    child: Image.asset(
                      'assets/filter-lines.png',
                    )),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Expanded(
              child: Consumer2<ProductProvider, CategoryProvider>(
                builder: (context, provider, categoryProvider, _) =>
                    RefreshIndicator(
                  onRefresh: () async {
                    await provider.getAllProducts(context);
                  },
                  child: Builder(builder: (context) {
                    if (provider.isLoading) {
                      return const Center(child: LoadingWidget());
                    }
                    final sortedProducts =
                        categoryProvider.radioValues == RadioValues.relevance
                            ? provider.listOfProducts
                            : provider.listOfProducts.sortedBy((a, b) =>
                                categoryProvider.radioValues ==
                                        RadioValues.lowToHigh
                                    ? a.price.compareTo(b.price)
                                    : b.price.compareTo(a.price));
                    final products = categoryProvider.selectedCategories.isEmpty
                        ? sortedProducts
                        : sortedProducts
                            .filter((element) => categoryProvider
                                .selectedCategories
                                .contains(element.category.id))
                            .toList();
                    return GridView.builder(
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                                childAspectRatio: 0.65),
                        itemBuilder: (context, index) {
                          final currentProduct = products[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                      item: currentProduct)));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: AppColors.cardColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 147.h,
                                      width: double.infinity,
                                      child: Image.network(
                                        currentProduct.thumbnail.url,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                      )),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    currentProduct.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Color(0xff4a5086),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Text(
                                    "₹ ${currentProduct.price}",
                                    style: const TextStyle(
                                        color: AppColors.priceColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
