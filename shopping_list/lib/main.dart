import 'package:flutter/material.dart';
import 'package:shopping_list/screen/grocery_screen.dart';

void main() {
  runApp(const MyApp());
}

late Size mq;
final FIREBASE_URL = Uri.https(
    'udemy-shopping-app-38674-default-rtdb.firebaseio.com',
    'shopping-items.json');

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          surface: const Color.fromARGB(255, 42, 51, 59),
          seedColor: const Color.fromARGB(255, 147, 229, 250),
        ),
      ),
      home: const GroceryScreen(),
    );
  }
}
