import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hamrocoffeeadmin/models/order.dart';

class OrderService {
  Future<List<Order>> getOrders() async {
    final ordersRef = FirebaseFirestore.instance.collection('orders');

    final orderDoc = await ordersRef.get();

    return orderDoc.docs.map((doc) => Order.fromSnapshot(doc)).toList();
  }
}
