import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screen/chat_screen.dart';
import 'package:flutter_chat_app/widget/user_image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
  bool isLoading = false;
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    final w = mq.width;
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
                margin: (w > 500)
                    ? EdgeInsets.symmetric(horizontal: mq.width * 0.2)
                    : EdgeInsets.symmetric(horizontal: mq.width * 0.05),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!isLoginMode)
                          UserImagePicker(
                            onPickImage: (pickedImage) {
                              _selectedImage = pickedImage;
                            },
                          ),
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
                            onPressed: isLoading ? null : _submit,
                            child: isLoading
                                ? const SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                    ))
                                : Text(isLoginMode ? "Login Now" : "Sign Up")),
                        TextButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    _formKey.currentState!.reset();
                                    setState(() {
                                      isLoginMode = !isLoginMode;
                                    });
                                  },
                            child: isLoading
                                ? const SizedBox(
                                    height: 16,
                                    width: 16,
                                  )
                                : Text(isLoginMode
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

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid || !isLoginMode && _selectedImage == null) return;

    _formKey.currentState!.save();
    log("SUBMIT_BUTTON_CLICKED ::: email: {$_enteredEmail}\tpassword: {$_enteredPassword}",
        name: "auth_screen");

    if (isLoginMode) {
      //login Code here
      await _login();
    } else {
      //sign up code here
      await _signUp();
    }
  }

  Future<void> _login() async {
    try {
      setState(() {
        isLoading = true;
      });
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: _enteredEmail, password: _enteredPassword);
      setState(() {
        isLoading = false;
      });
      log("LOGIN_SUCCESSFULLY ::: userCredential: {${userCredential.toString()}",
          name: "auth_screen");
      onSuccessLogin();
    } on FirebaseAuthException catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
      log("LOGIN_FAILED ::: exception: {${error.toString()}",
          name: "auth_screen");
    }
  }

  Future<void> _signUp() async {
    try {
      setState(() {
        isLoading = true;
      });
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: _enteredEmail, password: _enteredPassword);
      setState(() {
        isLoading = false;
      });
      log("SIGNUP_SUCCESSFULLY ::: userCredential: {${userCredential.toString()}",
          name: "auth_screen");

      onSuccessSignUp();
    } on FirebaseAuthException catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
      log("SIGNUP_FAILED ::: exception: {${error.toString()}",
          name: "auth_screen");
    }
  }

  void onSuccessLogin() {
    showSuccessToast("Login Success! Welcome");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const ChatScreen()));
  }

  bool _isValidEmail(String value) {
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegex.hasMatch(value);
  }

  void onSuccessSignUp() {
    FirebaseAuth.instance.signOut();
    showSuccessToast("SignUp Success! Login Now");
    setState(() {
      isLoginMode = true;
      _formKey.currentState!.reset();
    });
  }

  void showSuccessToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color(0xff1ed760),
      textColor: Colors.white,
    );
  }
}
