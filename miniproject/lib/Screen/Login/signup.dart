import 'package:flutter/material.dart';
import 'package:miniproject/Screen/Login/login.dart';
import 'package:miniproject/Screen/Login/utils/login_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isEmailValid = true;

  void _register(BuildContext context) async {
    String enteredEmail = _emailController.text;
    String enteredPassword = _passwordController.text;
    UserManager userManager = UserManager();

    if (enteredEmail.isNotEmpty && enteredPassword.isNotEmpty) {
      await userManager.saveEmail(enteredEmail);
      await userManager.savePassword(enteredPassword);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } else {
      setState(() {
        _isEmailValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Daftar Akun',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Alamat Email',
                icon: Icon(Icons.email),
                errorText: !_isEmailValid ? 'Email tidak boleh kosong' : null,
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                icon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _register(context);
              },
              child: Text('Daftar'),
            ),
          ],
        ),
      ),
    );
  }
}
