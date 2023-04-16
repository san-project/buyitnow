import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/box.png',
            scale: 4,
          ),
          SizedBox(
            height: 20,
          ),
          const Text(
            'Product is Empty',
            style: TextStyle(fontSize: 25),
          )
        ],
      ),
    );
  }
}
