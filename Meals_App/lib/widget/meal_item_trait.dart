import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  MealItemTrait({
    super.key,
    required this.lable,
    required this.icon,
  });

  final String lable;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        SizedBox(width: 4),
        Text(
          lable,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
