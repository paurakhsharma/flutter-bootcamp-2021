import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hamrocoffeeadmin/models/coffee.dart';
import 'package:hamrocoffeeadmin/screens/add_edit_screen.dart';
import 'package:hamrocoffeeadmin/services/coffee_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final coffees = <Coffee>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hamro Coffee - Admin'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: coffees.length,
          itemBuilder: (context, index) {
            final id = coffees[index].id;
            final coffee = coffees[index];
            return ListTile(
              title: Text(
                coffee.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              trailing: InkWell(
                onTap: () {
                  final coffeesRef =
                      FirebaseFirestore.instance.collection('coffees');

                  coffeesRef.doc(id).delete();
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddEditScreen(coffee: coffee),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadCoffees();
  }

  _loadCoffees() async {
    final service = CoffeeService();
    final _coffees = await service.getCoffees();
    setState(() {
      coffees.addAll(_coffees);
    });
  }
}
