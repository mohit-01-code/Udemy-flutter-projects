import 'package:flutter/material.dart';

class StatefullScreen extends StatefulWidget {
  @override
  State<StatefullScreen> createState() {
    return _StatefullScreenState();
  }
}

class _StatefullScreenState extends State<StatefullScreen> {
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
          setState(() {
            count++;
          });
          print(count);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
