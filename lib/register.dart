import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasapi/login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();

  void _register() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String birthdate = _birthdateController.text;

    if (email.isEmpty || password.isEmpty || birthdate.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registrasi Gagal'),
            content: Text('Mohon lengkapi semua inputan.'),
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
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setString('birthdate', birthdate);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registrasi Berhasil'),
          content: Text('Akun Anda telah berhasil didaftarkan.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
              child: Text('Register'),
              onPressed: _register,
            ),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sudah punya akun?'),
                TextButton(
                  child: Text('Login!'),
                  onPressed: _goToLogin,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
