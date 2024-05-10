import 'package:flutter/material.dart';
import 'package:tugasapi/breed_list.dart';
import 'package:tugasapi/logout.dart';
import 'package:tugasapi/profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Utama'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BreedList()),
                );
              },
              child: const Text('List Anjing'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: const Text('profile'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogoutPage()),
                );
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
