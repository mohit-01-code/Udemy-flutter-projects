import 'package:flutter/material.dart';
import 'package:shopping_list/data/grocery_data.dart';
import 'package:shopping_list/screen/new_item_screen.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Groceries",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.background),
        ),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: Icon(Icons.add,
                color: Theme.of(context).colorScheme.background),
          ),
        ],
      ),
      body: Column(
        children: groceryItems.map((grocery) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            title: Text(grocery.name),
            trailing: Text(grocery.quantity.toString()),
            leading: Container(
              height: 20,
              width: 20,
              color: grocery.category.color,
            ),
          );
        }).toList(),
      ),
    );
  }

  void _addItem() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => NewItemScreen()));
  }
}
