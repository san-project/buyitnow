import 'package:buyitnow/screens/product_details/product_details.dart';
import 'package:buyitnow/utils/colors.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../../utils/check_login.dart';
import '../../widgets/categories_widget.dart';
import '../wishlist/wishlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProductProvider>().getAllProducts(context);
    });
    super.initState();
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
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: AppColors.textColor,
          ),
          IconButton(
            onPressed: () async {
              final isLoggedIn = await checkLogin(context) ?? false;
              if (isLoggedIn) {
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
        padding: EdgeInsets.only(top: 25.h, left: 22.w, right: 22.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CategoriesWidget(),
            SizedBox(
              height: 25.h,
            ),
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, provider, _) => RefreshIndicator(
                  onRefresh: () async {
                    await provider.getAllProducts(context);
                  },
                  child: Visibility(
                    visible: !provider.isLoading,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: GridView.builder(
                        itemCount: provider.listOfProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                                childAspectRatio: 0.6),
                        itemBuilder: (context, index) {
                          final currentProduct = provider.listOfProducts[index];
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
                                      //padding: EdgeInsets.all(10),
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
                                    currentProduct.price.toString(),
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
                                        rating:
                                            currentProduct.rating.toDouble(),
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 17.0,
                                        direction: Axis.horizontal,
                                      ),
                                      Text(currentProduct.rating.toString()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
