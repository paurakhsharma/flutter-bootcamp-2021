import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hamrocoffeeadmin/models/coffee.dart';
import 'package:hamrocoffeeadmin/models/order.dart';
import 'package:hamrocoffeeadmin/models/user_model.dart';
import 'package:hamrocoffeeadmin/services/coffee_service.dart';
import 'package:hamrocoffeeadmin/services/order_service.dart';
import 'package:hamrocoffeeadmin/services/user_service.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final _orders = <Order>[];
  final _usrs = <UserModel>[];
  final _menu = <Coffee>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders Screen'),
      ),
      body: ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          final coffee = _menu.firstWhereOrNull((c) => c.id == order.coffeeId);

          final user = _usrs.firstWhereOrNull((u) => u.id == order.userId);

          return ListTile(
            title: Text(
              coffee?.name ?? order.coffeeId,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              order.size,
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text(
              user?.name ?? order.userId,
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final orderService = OrderService();
    orderService.getOrders().then((orders) {
      _orders.clear();
      setState(() {
        _orders.addAll(orders);
      });
    });

    final coffeeService = CoffeeService();
    coffeeService.getCoffees().then((coffee) {
      _menu.clear();
      setState(() {
        _menu.addAll(coffee);
      });
    });

    final userService = UserService();
    userService.getUsers().then((users) {
      _usrs.clear();
      setState(() {
        _usrs.addAll(users);
      });
    });
  }
}
