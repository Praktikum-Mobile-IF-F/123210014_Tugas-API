import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasapi/home.dart';
import 'package:tugasapi/register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  void _login() async {
    String email = _emailController.text;
    String birthdate = _birthdateController.text;
    String password = _passwordController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');
    String? storedBirthdate = prefs.getString('birthdate');
    String? storedPassword = prefs.getString('password');

    if (email == storedEmail &&
        password == storedPassword &&
        birthdate == storedBirthdate) {
      prefs.setBool('isLoggedIn', true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Gagal'),
            content: Text('Email, tanggal lahir, atau password salah.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _goToRegister() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _birthdateController,
              decoration: InputDecoration(labelText: 'Tanggal Ultah'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              child: Text('Login'),
              onPressed: _login,
            ),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Belum punya akun?'),
                TextButton(
                  child: Text('Daftar di sini.'),
                  onPressed: _goToRegister,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
