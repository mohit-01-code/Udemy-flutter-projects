import 'package:flutter/material.dart';
import 'package:flutter_app/DiceRoller.dart';

const startAlign = Alignment.topCenter;
const endAlign = Alignment.bottomCenter;

class MyCustomWidget extends StatelessWidget {
  const MyCustomWidget(this.gradient1, this.gradient2, {super.key});

  final Color gradient1, gradient2;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [gradient1, gradient2],
          begin: startAlign,
          end: endAlign,
        ),
      ),
      child: Center(
        child: DiceRoller(),
      ),
    );
  }
}
