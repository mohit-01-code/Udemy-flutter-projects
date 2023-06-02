import 'package:flutter/material.dart';
import 'package:flutter_provider/provider/login_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                    _passwordTextController.text.toString());
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.red,
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
