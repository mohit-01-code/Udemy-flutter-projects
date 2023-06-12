import 'package:favourite_place_app/provider/user_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Place"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                  controller: _titleTextController,
                  style: Theme.of(context).textTheme.titleMedium!),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                onPressed: _savePlace,
                label: const Text("Add Place"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _savePlace() {
    final enteredTitle = _titleTextController.text;
    if (enteredTitle.isEmpty) {
      return;
    }
    ref.read(userPlaceProvider.notifier).addPlace(enteredTitle);
    Navigator.of(context).pop();
  }
}
