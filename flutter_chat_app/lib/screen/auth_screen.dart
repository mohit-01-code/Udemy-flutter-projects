import 'dart:developer';

import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoginMode = true;
  String _enteredEmail = '';
  String _enteredPassword = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff334e6b),
          Color(0xff121212),
        ], end: Alignment.bottomCenter, begin: Alignment.topCenter)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/chat-app-logo.png'),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Email",
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Enter Email Address";
                            } else if (!_isValidEmail(value)) {
                              return "Enter Valid Email Address";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredEmail = value!;
                          },
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Password",
                          ),
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredPassword = value!;
                          },
                          obscureText: true,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                            onPressed: _submit,
                            child: Text(isLoginMode ? "Login Now" : "Sign Up")),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                isLoginMode = !isLoginMode;
                              });
                            },
                            child: Text(isLoginMode
                                ? "Create An Account"
                                : "Already have An Account"))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      log("SUBMIT_BUTTON_CLICKED ::: email: {$_enteredEmail}\tpassword: {$_enteredPassword}",
          name: "auth_screen");
    }
  }

  bool _isValidEmail(String value) {
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegex.hasMatch(value);
  }
}
