import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_provider/provider/count_provider.dart';
import 'package:provider/provider.dart';

class CountProviderScreen extends StatefulWidget {
  const CountProviderScreen({Key? key}) : super(key: key);

  @override
  State<CountProviderScreen> createState() => _CountProviderScreenState();
}

class _CountProviderScreenState extends State<CountProviderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final countProvider = Provider.of<CountProvider>(context, listen: false);
    Timer.periodic(Duration(seconds: 1), (timer) {
      countProvider.setSeconds();
    });
  }

  @override
  Widget build(BuildContext context) {
    final countProvider = Provider.of<CountProvider>(context, listen: false);
    print("building widget...");
    return Scaffold(
      appBar: AppBar(
        title: Text('Count Provider'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          countProvider.setCount();
        },
      ),
      body: Center(
        child: Consumer<CountProvider>(
          builder: (content, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Seconds ::: ${value.seconds}'),
                Text('Counts ::::::: ${value.count}'),
              ],
            );
          },
        ),
      ),
    );
  }
}
