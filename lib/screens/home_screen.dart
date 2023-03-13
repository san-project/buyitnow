
import 'package:flutter/material.dart';

import '../widgets/item_widget.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
            toolbarHeight: 70,
            automaticallyImplyLeading: false,
            floating: true,
            title: SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 10),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search',
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            )),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ))),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.filter_alt_rounded,
                      color: Colors.black,
                      size: 30,
                    )),
              )
            ],
          ),
         
          
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'New Items',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: NewItemWidget()),
          )
        ],
      ),
    );
  }
}


// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffe7e7e7),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.8,
//                     child: TextField(
//                       decoration: InputDecoration(
//                           hintText: 'Search',
//                           suffixIcon: IconButton(
//                               onPressed: () {},
//                               icon: const Icon(
//                                 Icons.search,
//                                 color: Colors.black,
//                               )),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20.0),
//                           )),
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(left: 8.0),
//                     child: Icon(Icons.shopping_bag),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 7,
//             ),
//             SizedBox(height: 120, child: CategoriesWidget()),
//             const SizedBox(
//               height: 7,
//             ),
//             const OfferWidger(),
//             const SizedBox(
//               height: 7,
//             ),
//             const Padding(
//               padding: EdgeInsets.all(15.0),
//               child: Text(
//                 'New Items',
//                 style: TextStyle(color: Colors.black, fontSize: 25),
//               ),
//             ),
//             NewItemWidget()
//           ],
//         ),
//       ),
//     );
//   }
// }
