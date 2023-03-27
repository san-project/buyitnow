
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


import '../models/product_model.dart';
import '../screens/product_details/product_details.dart';
import '../screens/product_details/product_details_screen.dart';


class NewItemWidget extends StatelessWidget {
  NewItemWidget({
    Key? key,
  }) : super(key: key);
  final items = Product.getProducts();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
   // var prod = context.watch<ProductProvider>().prod;
   // var myList = context.watch<ProductProvider>().myList;
    return MasonryGridView.count(
        padding: const EdgeInsets.only(top: 20),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailsScreen(item: items[index])));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Positioned(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        fit: BoxFit.cover,
                        items[index].image,
                      ),
                    )),
                    Positioned(
                        right: 12,
                        top: 12,
                        child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            height: 35,
                            width: 35,
                            child: GestureDetector(
                                onTap: () {
                                  // if (!myList.contains(prod[index])) {
                                  //   context
                                  //       .read<ProductProvider>()
                                  //       .addToList(prod[index]);
                                  // } else {
                                  //   context
                                  //       .read<ProductProvider>()
                                  //       .removeFormList(prod[index]);
                                  // }
                                },
                                child: 
                                // myList.contains(prod[index])
                                //     ? const Icon(
                                //         Icons.favorite,
                                //       )
                                //     : 
                                    const Icon(
                                        Icons.favorite_border,
                                      ))))
                  ],
                ),
                SizedBox(
                  height: height * 0.012,
                ),
                Text(
                  items[index].name,
                  style: const TextStyle(color: Colors.grey),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ ${items[index].price.toString()}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add))
                  ],
                )
              ],
            ),
          );
        });
  }
}
