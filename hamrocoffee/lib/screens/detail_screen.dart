import 'package:flutter/material.dart';
import 'package:hamrocoffee/models/coffee.dart';
import 'package:hamrocoffee/models/order.dart';
import 'package:hamrocoffee/services/order_provider.dart';
import 'package:hamrocoffee/services/user_provider.dart';
import 'package:provider/src/provider.dart';

class DetailScreen extends StatefulWidget {
  final Coffee coffee;
  const DetailScreen({required this.coffee, Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final orderProvider = context.watch<OrderProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coffee.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: widget.coffee.imageUrl,
                child: Image.network(
                  widget.coffee.imageUrl,
                  height: 250,
                ),
              ),
              Text(
                widget.coffee.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                itemCount: widget.coffee.sizes.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final size = widget.coffee.sizes[index];
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: _selectedIndex == index ? Colors.white : null,
                        border: Border.all(),
                      ),
                      child: ListTile(
                        title: Text(
                          size.name,
                          style: TextStyle(
                            color: _selectedIndex == index
                                ? Colors.black
                                : Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        trailing: Text(
                          'Rs. ${size.price.toString()}',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: _selectedIndex == index
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
              userProvider.currentUser == null
                  ? SizedBox(
                      height: 50,
                      width: 250,
                      child: ElevatedButton(
                        child: const Text(
                          'Sign in with Google',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          userProvider.signInWithGoogle();
                        },
                      ),
                    )
                  : SizedBox(
                      height: 50,
                      width: 250,
                      child: ElevatedButton(
                        child: const Text(
                          'Order',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          final order = Order(
                            id: '',
                            coffeeId: widget.coffee.id,
                            userId: userProvider.currentUser!.id,
                            size: widget.coffee.sizes[_selectedIndex].name,
                            price: widget.coffee.sizes[_selectedIndex].price,
                          );
                          orderProvider.placeOrder(order);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Order placed successfully'),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
