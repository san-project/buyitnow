import 'package:buyitnow/screens/home/home_screen.dart';
import 'package:buyitnow/utils/shared_prefs.dart';
import 'package:buyitnow/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../utils/colors.dart';
import '../../widgets/bottom_navbar.dart';
import '../../widgets/cart_bottom_navbar.dart';
import '../../widgets/cart_item_sample.dart';
import '../login/login_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (SharedPrefs.instance().token != null) {
        context.read<CartProvider>().getCartProduct(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SharedPrefs.instance().token == null
        ? Scaffold(
            appBar: AppBar(
              title: const Text(
                'Cart',
                style: TextStyle(
                    fontSize: 23,
                    color: AppColors.priceColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('You Should Login'),
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const SiginPage(),
                          ),
                          (route) => false);
                    },
                    child: const Text('Sign In'))
              ],
            )),
          )
        : Consumer<CartProvider>(builder: (context, provider, _) {
            if (provider.isLoading || provider.cart == null) {
              return const LoadingWidget();
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Cart',
                    style: TextStyle(
                        fontSize: 23,
                        color: AppColors.priceColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                body: provider.cart?.cart.isEmpty ?? true
                    ? Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/empty-cart.png',
                              scale: 3,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Your Cart is Empty',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ButtomNavBars()));
                                },
                                child: const Text('Start Shopping'))
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: provider.cart?.cart.length,
                        itemBuilder: (context, index) =>
                            CartItem(cart: provider.cart!.cart[index]),
                      ),
                bottomNavigationBar:
                    provider.cart!.cart.isNotEmpty ? CartBottomBar() : null,
              );
            }
          });
  }
}

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//       title: Text('Cart',style: TextStyle(color: Colors.black),),
      
//     ),
//     body: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: 2,
//               itemBuilder: (context,index){
//                 return Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Image(
//                               height: 100,
//                               width: 100,
//                               image: NetworkImage('https://i.pinimg.com/550x/72/a4/30/72a430c1c88f7a478c866d378d6fe67c.jpg')),
//                             SizedBox(height: 10,),
//                             Expanded(child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text('Demo Product'),
//                                     Icon(Icons.delete)
//                                   ],
//                                 ),
                                
//                                 SizedBox(height: 5,),
//                                 Text('800.00'),
//                                 Align(
//                                   alignment: Alignment.centerRight,
//                                   child: Container(
//                                     height: 35,
//                                     width: 100,
//                                     decoration: BoxDecoration(
//                                       color: Colors.green,
//                                       borderRadius: BorderRadius.circular(5)
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Icon(Icons.remove,color: Colors.white,),
//                                           Text('1',style: TextStyle(color: Colors.white)),
//                                           Icon(Icons.add,color: Colors.white,)
                                          
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ))
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//             })
//             ),
//             Column(
//               children: [
//                 ReusableWidget(title: 'sub Total', value: '\$ 800.00'),
//                 ReusableWidget(title: 'delivery charges', value: '\$ 50.00'),
//                 ReusableWidget(title: 'Total Price', value: '\$ 850.00'),
//                 SizedBox(height: 30,),
//                 SizedBox(
//             width: double.infinity,
//             height: 60,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green
//               ),
//               onPressed: (){
              
//             }, 
//             child: Text('PROCEED To CHECKOUT',style: TextStyle(color: Colors.white),)),
//           )

    
//               ],
//             )
//         ],
//       ),
//     ),
//     );
//   }
// }

// class ReusableWidget extends StatelessWidget {
//   final String title,value;
//   const ReusableWidget({super.key, required this.title, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title),
//           Text(value)
//         ],
//       ),
//     );
//   }
// }