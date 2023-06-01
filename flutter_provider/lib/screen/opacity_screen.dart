import 'package:flutter/material.dart';
import 'package:flutter_provider/provider/opacity_provider.dart';
import 'package:provider/provider.dart';

class OpacityScreen extends StatefulWidget {
  const OpacityScreen({Key? key}) : super(key: key);

  @override
  State<OpacityScreen> createState() => _OpacityScreenState();
}

class _OpacityScreenState extends State<OpacityScreen> {
  @override
  Widget build(BuildContext context) {
    final exampleOneProvider =
        Provider.of<OpacityProvider>(context, listen: false);
    print('build...');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example One'),
      ),
      body: Consumer<OpacityProvider>(
        builder: (content, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Slider(
                value: exampleOneProvider.opacityValue,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                onChanged: (newValue) {
                  exampleOneProvider.setOpacityValue(newValue);
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: 80,
                      color: Colors.red.withOpacity(value.opacityValue),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 80,
                      margin: const EdgeInsets.only(right: 20),
                      color: Colors.green.withOpacity(value.opacityValue),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
