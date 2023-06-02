import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/login_provider.dart';
import 'login_screen.dart';

class MobileLoginScreen extends StatelessWidget {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  MobileLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(mq.width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailTextController,
              decoration: const InputDecoration(
                hintText: "enter email",
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: loginProvider.isVisible,
              controller: _passwordTextController,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (loginProvider.isVisible)
                        loginProvider.setIsVisible(false);
                      else
                        loginProvider.setIsVisible(true);
                    },
                    icon: const Icon(Icons.remove_red_eye),
                  ),
                  hintText: "enter password"),
            ),
            const SizedBox(height: 40),
            InkWell(
              onTap: () {
                print("\"${_emailTextController.text.toString()}\"");
                print("\"${_passwordTextController.text.toString()}\"");
                loginProvider.login(_emailTextController.text.toString(),
                    _passwordTextController.text.toString(), context);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Center(
                  child: loginProvider.isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('LOGIN'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
