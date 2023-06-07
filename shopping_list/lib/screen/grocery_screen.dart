import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/main.dart';
import 'package:shopping_list/model/grocery_item.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/screen/new_item_screen.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});
  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  List<GroceryItem> groceryItemList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getItems();
  }

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

                      _removeItem(grocery.id);
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

  void _getItems() async {
    List<GroceryItem> tempItemList = [];
    final response = await http.get(FIREBASE_URL);
    final Map<String, dynamic> data = jsonDecode(response.body);
    print(response.body);

    for (final item in data.entries) {
      tempItemList.add(
        GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: int.parse(item.value['quantity']),
            category: categories.entries
                .firstWhere(
                    (element) => element.value.title == item.value['category'])
                .value),
      );
    }
    setState(() {
      groceryItemList = tempItemList;
    });
  }

  void _addItem() async {
    final addedItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItemScreen(),
      ),
    );
    setState(() {
      if (addedItem != null) groceryItemList.add(addedItem);
    });
  }

  void _removeItem(String id) async {
    final url = Uri.https(
        'udemy-shopping-app-38674-default-rtdb.firebaseio.com',
        'shopping-items/$id.json');
    final response = await http.delete(url);
    print("Deleted item::: ${response.body}");
  }
}
