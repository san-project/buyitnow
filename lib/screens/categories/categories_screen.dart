import 'package:buyitnow/providers/category_provider.dart';
import 'package:buyitnow/screens/categories_product/categories_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/loading_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<String> images = [
    'assets/clothes-rack.png',
    'assets/electric-appliance.png',
    'assets/cleaning.png',
    'assets/gadgets.png',
    'assets/personal-hygiene.png',
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryProvider>().getAllCategories(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: LoadingWidget(),
            );
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: provider.categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                final currentCategory = provider.categories[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CategoryProductSCreen(
                              categoryId: currentCategory.id,
                              categoryName: currentCategory.category,
                            )));
                  },
                  child: Card(
                    child: GridTile(
                      child: Stack(
                        children: [
                          Center(
                            child: Image.asset(
                              images[index],
                              scale: 4,
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                currentCategory.category,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
