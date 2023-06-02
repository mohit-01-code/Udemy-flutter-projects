import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isVisible = true;
  void setIsLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void setIsVisible(bool val) {
    _isVisible = val;
    notifyListeners();
  }

  bool get isVisible => _isVisible;
  bool get isLoading => _isLoading;

  void login(String email, String password, BuildContext context) async {
    setIsLoading(true);
    try {
      Response response =
          await post(Uri.parse('https://reqres.in/api/login'), body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        print("Login Success");
        setIsLoading(false);
        myShowDialog(
            context, "Login Success", "You have Successfully logged in");
      } else {
        print("Login Failed");
        setIsLoading(false);
        myShowDialog(context, "Login Failed", "Plese checked the credentials");
      }
    } catch (e) {
      print(e.toString());
      print("Exception Occur");
      setIsLoading(false);
      myShowDialog(context, "Exception Occur", e.toString());
    }
  }

  void myShowDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text("OK"),
            )
          ],
        );
      },
    );
  }
}
