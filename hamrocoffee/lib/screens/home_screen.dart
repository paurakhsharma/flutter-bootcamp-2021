import 'package:flutter/material.dart';
import 'package:hamrocoffee/models/coffee.dart';
import 'package:hamrocoffee/services/coffee_service.dart';

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final menu = <Coffee>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hamro Coffee'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: menu.length,
          itemBuilder: (context, index) {
            return Card(
              color: const Color(0xff1f3933),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        coffee: menu[index],
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Hero(
                      tag: menu[index].imageUrl,
                      child: Image.network(
                        menu[index].imageUrl,
                        height: 200,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              menu[index].name,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              menu[index].description,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    _loadMenu();
    super.initState();
  }

  void _loadMenu() async {
    final service = CoffeeService();
    final _menu = await service.getCoffees();
    setState(() {
      menu.addAll(_menu);
    });
  }
}
