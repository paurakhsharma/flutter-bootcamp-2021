import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hamrocoffee/models/coffee.dart';

class CoffeeService {
  Future<List<Coffee>> getCoffees() async {
    final coffeesRef = FirebaseFirestore.instance.collection('coffees');

    final coffeeDoc = await coffeesRef.get();

    return coffeeDoc.docs.map((doc) => Coffee.fromSnapshot(doc)).toList();
  }
}
