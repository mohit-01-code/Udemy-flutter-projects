import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({
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
        const SizedBox(width: 4),
        Text(
          lable,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
