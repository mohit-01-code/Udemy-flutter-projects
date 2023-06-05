import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';

import '../main.dart';

class NewItemScreen extends StatelessWidget {
  const NewItemScreen({super.key});

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
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Name"),
                ),
                validator: (value) {
                  return "demo...";
                },
              ),
              SizedBox(
                height: mq.height * 0.01,
              ),
              if (mq.width > 390)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(label: Text("Quantity")),
                      ),
                    ),
                    SizedBox(width: mq.width * 0.1),
                    Expanded(
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
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                )
              else
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(label: Text("Quantity")),
                    ),
                    SizedBox(width: mq.width * 0.1),
                    DropdownButtonFormField(
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
                      onChanged: (value) {},
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
