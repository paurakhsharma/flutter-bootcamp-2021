import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hamrocoffee/services/coffee_provider.dart';
import 'package:hamrocoffee/services/order_provider.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();
    final coffeeProvider = context.watch<CoffeeProvider>();

    final total = orderProvider.orders.map((e) => e.price).sum;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your orders'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final order = orderProvider.orders[index];
                final coffee = coffeeProvider.menu.firstWhere(
                  (coffee) => coffee.id == order.coffeeId,
                );

                return ListTile(
                  title: Text(
                    coffee.name,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    order.size,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  trailing: Text(
                    order.price.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              },
              itemCount: orderProvider.orders.length,
            ),
          ),
          Text(
            'Total: $total',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
