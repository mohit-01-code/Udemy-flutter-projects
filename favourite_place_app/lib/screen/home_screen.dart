import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Favourite Place"),
      ),
      body: const Center(
        child: Text("Hello World"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Pressed Button");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
