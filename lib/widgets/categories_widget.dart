import 'package:buyitnow/utils/colors.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 1; i < 8; i++)
            Container(
              height: 50.h,
              width: 100.h,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // SvgPicture.asset('assets/dress.svg',height: 40.h,width: 40.w,),
                  Text(
                    'dress',
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.priceColor,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}


// class CategoriesWidget extends StatefulWidget {
//   CategoriesWidget({super.key});

//   @override
//   State<CategoriesWidget> createState() => _CategoriesWidgetState();
// }

// class _CategoriesWidgetState extends State<CategoriesWidget> {
//   List<String> item = [
//   "Mobiles",
//   "Deals",
//   "Fashion",
//   "Electroins",
//   "Home",
//   "Beauty",
//   "Books",
//   "Appliances",
//   "Essentials",
//   "Grocery",
// ];

// int current = 0;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: 70,
//         width: double.infinity,
//         child: ListView.builder(
//           physics: BouncingScrollPhysics(),
//           itemCount: item.length,
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (context, index) {
//             return Column(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       current = index;
//                     });
//                   },
//                   child: AnimatedContainer(
//                     duration: Duration(milliseconds: 300),
//                     margin: EdgeInsets.all(5),
//                     width: 80,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: current == index ? Colors.black : Colors.white,
//                       borderRadius: current == index
//                           ? BorderRadius.circular(15)
//                           : BorderRadius.circular(10),
//                       border: current == index
//                           ? Border.all(color: Colors.deepOrange, width: 2)
//                           : null,
//                     ),
//                     child: Center(
//                       child: Text(
//                         item[index],
//                         style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             color:
//                                 current == index ? Colors.white : Colors.black),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible: current == index,
//                   child: Container(
//                     height: 5,
//                     width: 5,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.deepOrange,
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       );
//   }
// }