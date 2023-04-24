import 'package:buyitnow/models/order_model.dart';
import 'package:buyitnow/providers/order_provider.dart';
import 'package:buyitnow/screens/order_details/order_details_screen.dart';
import 'package:buyitnow/utils/size_config.dart';
import 'package:buyitnow/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OrderProvider>().getAllOrders(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Order History'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const LoadingWidget();
          } else if (value.listOfOrder.isEmpty) {
            return const Text('No ordes');
          } else {
            return ListView.builder(
              itemCount: value.listOfOrder.length,
              itemBuilder: (context, index) {
                final currentOrder = value.listOfOrder[index];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            OrderDetailScreen(order: currentOrder),
                      ));
                    },
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        height: 130.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'OrderId:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(' ${currentOrder.id}'),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Items: ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(currentOrder.products.length.toString()),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Product Status: ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(currentOrder.status.value)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Total:  ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        '₹ ${currentOrder.totalPrice.toString()}'),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
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
