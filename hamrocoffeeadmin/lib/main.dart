import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hamro Coffee Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff1f3933),
        primaryColor: const Color(0xff1f3933),
        appBarTheme: const AppBarTheme(
          color: Color(0xff1f3933),
        ),
      ),
      home: MainScreen(),
    );
  }
}
