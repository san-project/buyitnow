import 'package:buyitnow/providers/order_provider.dart';
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
            return Text('No ordes');
          } else {
            return ListView.builder(
              itemCount: value.listOfOrder.length,
              itemBuilder: (context, index) {
                final currentOrder = value.listOfOrder[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currentOrder.products.length.toString()),
                    Text(currentOrder.status)
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
