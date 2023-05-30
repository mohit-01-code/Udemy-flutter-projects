import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter Provider'),
      ),
      body: Center(
        child: Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          count++;
          print(count);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
