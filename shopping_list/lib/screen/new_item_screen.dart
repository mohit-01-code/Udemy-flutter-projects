import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';

import '../main.dart';
import '../model/grocery_item.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _formKey = GlobalKey<FormState>();

  String enteredName = '';

  int enteredQuantity = 1;

  Category enteredCategory = categories[Categories.vegetables]!;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Item",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.background),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Name"),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) return "Invalid Name Entered";
                  return null;
                },
                onSaved: (newValue) {
                  enteredName = newValue!;
                },
              ),
              SizedBox(
                height: mq.height * 0.01,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(label: Text("Quantity")),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0)
                          return "Invalid Quantity Entered";
                        return null;
                      },
                      onSaved: (newValue) {
                        enteredQuantity = int.parse(newValue!);
                      },
                    ),
                  ),
                  SizedBox(width: mq.width * 0.1),
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField(
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 16,
                                    width: 16,
                                    color: category.value.color,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(category.value.title),
                                ],
                              ),
                            ),
                          ),
                      ],
                      onChanged: (newValue) {
                        setState(() {
                          enteredCategory = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: mq.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      child: const Text("Reset")),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: Text(
                      "Add Item",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.background,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveItem() async {
    //this will automatic trigger validator according to form key of Form
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _formKey.currentState!.reset();

      final response = await http.post(FIREBASE_URL,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'name': enteredName,
            'quantity': enteredQuantity.toString(),
            'category': enteredCategory.title,
          }));

      log(response.body, name: "RESPONSE_BODY");
      log(response.statusCode.toString(), name: "RESPONSE_STATUS_CODE");
      if (!context.mounted) return;
      Navigator.of(context).pop();
    } else {
      log("Validation Failed");
    }
  }
}
