import 'package:flutter/material.dart';

class ValueNotifierScreen extends StatelessWidget {
  ValueNotifierScreen({super.key});
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    print("build...");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Value Notifier'),
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: _counter,
          builder: (context, value, child) {
            return Text(_counter.value.toString());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _counter.value++;
        },
      ),
    );
  }
}
