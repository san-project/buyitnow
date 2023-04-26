import 'package:buyitnow/screens/product_details/product_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../models/order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(color: Colors.grey);
    final textTheme = Theme.of(context).textTheme;
    final borderDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListView(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Order Id # ',
                      style:
                          textTheme.titleSmall?.copyWith(color: Colors.grey)),
                  TextSpan(text: order.id, style: textTheme.titleMedium),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Products',
              style: textTheme.titleLarge,
            ),
            const SizedBox(
              height: 12,
            ),
            ...order.products.map((e) => Container(
                  height: 130,
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsScreen(item: e.product),
                          ));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: borderDecoration.borderRadius!,
                      side: borderDecoration.border!.bottom,
                    ),
                    leading: SizedBox(
                        height: 90,
                        width: 60,
                        child: CachedNetworkImage(
                            imageUrl: e.product.thumbnail.url)),
                    title: Text(
                      e.product.name,
                      style: textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      'Qty: ${e.quantity} x ${e.product.price}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: Text(
                      '₹ ${e.quantity * e.product.price}',
                      style: textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.teal.shade600),
                    ),
                  ),
                )),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: borderDecoration,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      const Text(
                        'Order Date',
                        style: labelStyle,
                      ),
                      Text(
                          '${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}')
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text(
                        'Order Total',
                        style: labelStyle,
                      ),
                      Text('₹ ${order.totalPrice}')
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text(
                        'Seller',
                        style: labelStyle,
                      ),
                      Text(order.seller.businessName)
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text(
                        'Shipping Address',
                        style: labelStyle,
                      ),
                      Text(order.deliveryAddress)
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text(
                        'Order Status',
                        style: labelStyle,
                      ),
                      Text(order.status.value),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
