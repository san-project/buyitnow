import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../models/product_model.dart';
import '../../utils/colors.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.item});
   final Product item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        iconTheme:const IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 351.00.h,
            child:
                Image.network(
                  item.image,
                 // height: 351.00.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                
          ),
          SizedBox(height: 20.h,),
          Expanded(
            child: Container(
              
              decoration: BoxDecoration(
                 color: Color(0xffe5e5e9),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 35.h),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.name,style: TextStyle(fontSize: 25,color: AppColors.priceColor,fontWeight: FontWeight.bold),),
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
                      SizedBox(height: 20.h,),
                      Text(item.description),
                      SizedBox(height: 26.h,),
                      Row(
                        children: [
                          Text(' Seller : ',style: TextStyle(color: AppColors.grayColor,fontSize: 16),),
                          Text(item.sellerName)
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
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('₹ ${item.price.toString()}',style: TextStyle(fontSize: 25,color: AppColors.textColor,fontWeight: FontWeight.bold),),
                              FloatingActionButton.extended(
                                label: Text('add To Cart',style: TextStyle(color: AppColors.priceColor),), // <-- Text
                                backgroundColor: Colors.grey.shade300,
                                icon: Icon( // <-- Icon
                                  CupertinoIcons.cart_badge_plus,
                                  color: AppColors.priceColor,
                                  size: 24.0,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      )
        ],
      ),
      
    );
  }
}