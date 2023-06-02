import 'package:flutter/material.dart';
import 'package:flutter_provider/screen/login/web_login.dart';

import 'mobile_login.dart';

late Size mq;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    if (mq.width >= 800) return WebLoginScreen();
    return MobileLoginScreen();
  }
}
