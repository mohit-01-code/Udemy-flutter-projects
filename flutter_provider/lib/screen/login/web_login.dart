import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/login_provider.dart';
import 'login_screen.dart';

class WebLoginScreen extends StatelessWidget {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  WebLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Material(
          elevation: 15,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: mq.height * 0.7,
            width: mq.width * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
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
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    child: Center(
                      child: loginProvider.isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'LOGIN',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
