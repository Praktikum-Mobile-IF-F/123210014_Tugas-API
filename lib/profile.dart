import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? email;
  String? birthdate;
  String? password;

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  void getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      birthdate = prefs.getString('birthdate');
      password = prefs.getString('password');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              email ?? '',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Tanggal Lahir:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              birthdate ?? '',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Password:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              password ?? '',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
