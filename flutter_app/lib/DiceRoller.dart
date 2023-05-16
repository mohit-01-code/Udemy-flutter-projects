import 'dart:math';

import 'package:flutter/material.dart';

class DiceRoller extends StatefulWidget {
  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  String activeDice = 'assets/images/dice-2.png';

  @override
  void initState() {
    super.initState();
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          activeDice,
          width: 200,
        ),
        Container(
          height: 40,
        ),
        ElevatedButton(
          onPressed: () {
            evaluateDice();
          },
          child: const Text("Roll Dice"),
        ),
      ],
    );
  }

  void evaluateDice() {
    var random = Random();
    var randomNumber = random.nextInt(6) + 1;
    activeDice = 'assets/images/dice-${randomNumber}.png';
    setState(() {});

    print(randomNumber);
  }
}
