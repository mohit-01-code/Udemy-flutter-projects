import 'package:flutter/foundation.dart';
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

  void login(String email, String password) async {
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
      } else {
        print("Login Failed");
        setIsLoading(false);
      }
    } catch (e) {
      print(e.toString());
      print("Exception Occur");
      setIsLoading(false);
    }
  }
}
