import 'package:flutter/material.dart';
import 'package:hamrocoffeeadmin/models/coffee.dart';

class DetailScreen extends StatelessWidget {
  final Coffee coffee;
  const DetailScreen({Key? key, required this.coffee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coffee.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Hero(
              tag: coffee.imageUrl,
              child: Image.asset(coffee.imageUrl),
            ),
            Text(
              coffee.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
