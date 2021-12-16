import 'package:flutter/material.dart';
import 'package:hamrocoffee/models/coffee.dart';

class DetailScreen extends StatelessWidget {
  final Coffee coffee;
  const DetailScreen({required this.coffee, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: coffee.imageUrl,
          child: Image.network(coffee.imageUrl),
        ),
      ),
    );
  }
}
