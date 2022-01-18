import 'package:flutter/material.dart';
import 'package:hamrocoffee/models/coffee.dart';
import 'package:hamrocoffee/services/coffee_service.dart';

class CoffeeProvider extends ChangeNotifier {
  CoffeeProvider() {
    final service = CoffeeService();
    service.getCoffees().then((coffees) {
      menu = coffees;
      notifyListeners();
    });
  }
  List<Coffee> menu = [];
}
