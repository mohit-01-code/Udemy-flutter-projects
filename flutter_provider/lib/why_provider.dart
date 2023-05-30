import 'dart:async';

import 'package:flutter/material.dart';

class WhyProvider extends StatefulWidget {
  const WhyProvider({Key? key}) : super(key: key);

  @override
  State<WhyProvider> createState() => _WhyProviderState();
}

class _WhyProviderState extends State<WhyProvider> {
  var count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        count++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Building Widget $count times.');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Why Provider'),
      ),
      body: Column(
        children: [
          Text(
              "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}"),
          Text(count.toString()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
