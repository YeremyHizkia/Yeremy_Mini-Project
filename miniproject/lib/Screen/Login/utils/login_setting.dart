import 'package:shared_preferences/shared_preferences.dart';

const String userEmail = "user_email";
const String userPassword = "user_password";

class UserManager {
  Future<void> saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userEmail, email);
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmail);
  }

  Future<void> hapusEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(userEmail);
  }

  Future<void> savePassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userPassword, password);
  }

  Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userPassword);
  }
}
