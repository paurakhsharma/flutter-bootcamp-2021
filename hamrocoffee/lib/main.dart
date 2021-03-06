import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hamrocoffee/screens/home_screen.dart';
import 'package:hamrocoffee/services/coffee_provider.dart';
import 'package:hamrocoffee/services/order_provider.dart';
import 'package:hamrocoffee/services/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CoffeeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hamro Coffee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff1f3933),
        primaryColor: const Color(0xff1f3933),
        appBarTheme: const AppBarTheme(
          color: Color(0xff1f3933),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
