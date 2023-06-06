import 'package:flutter/material.dart';
import 'package:shopping_list/model/grocery_item.dart';
import 'package:shopping_list/screen/new_item_screen.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});
  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  List<GroceryItem> groceryItemList = [];
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
      body: (groceryItemList.isNotEmpty)
          ? Column(
              children: groceryItemList.map((grocery) {
                return Dismissible(
                  key: ValueKey(grocery.id),
                  onDismissed: (direction) {
                    setState(() {
                      groceryItemList.remove(grocery);
                    });
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    title: Text(grocery.name),
                    trailing: Text(grocery.quantity.toString()),
                    leading: Container(
                      height: 20,
                      width: 20,
                      color: grocery.category.color,
                    ),
                  ),
                );
              }).toList(),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Oops...No Item to Display",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text("Please Add New Item"),
                ],
              ),
            ),
    );
  }

  void _addItem() async {
    final groceryItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItemScreen(),
      ),
    );
    if (groceryItem != null) {
      setState(() {
        groceryItemList.add(groceryItem);
      });
    }
  }
}
