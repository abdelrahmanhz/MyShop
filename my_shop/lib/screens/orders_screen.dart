import 'package:flutter/material.dart';
import 'package:my_shop/providers/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart' as oi ;
import '../providers/orders.dart' show Orders;


class OrdersScreen extends StatelessWidget {

  static const String route = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: orderData.orders.length,
          itemBuilder: (ctx, i) => oi.OrderItem(orderData.orders[i]),
      ),
      drawer: AppDrawer(),
    );
  }
}
