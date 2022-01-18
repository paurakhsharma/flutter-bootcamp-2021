import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hamrocoffee/models/order.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> orders = [];

  Future<void> getUserOrder(String userId) async {
    final userOrdersDoc = await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .get();

    final userOrder =
        userOrdersDoc.docs.map((e) => Order.fromSnapshot(e)).toList();

    orders = userOrder;

    notifyListeners();
  }

  Future<void> placeOrder(Order order) async {
    final ordersRef = FirebaseFirestore.instance.collection('orders');

    await ordersRef.add(order.toMap());

    getUserOrder(order.userId);
  }
}
