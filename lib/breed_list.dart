import 'package:flutter/material.dart';
import 'package:tugasapi/breed_image.dart';

import 'api_data_source.dart';

class BreedList extends StatelessWidget {
  const BreedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dog Breeds'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiDataSource.instance.loadAllBreeds(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            Map<String, dynamic> allBreeds = snapshot.data!;
            List<String> breeds = allBreeds.containsKey('message')
                ? allBreeds['message'].keys.toList()
                : [];

            return ListView.builder(
              itemCount: breeds.length,
              itemBuilder: (context, index) {
                String breed = breeds[index];
                return ListTile(
                  title: Text(breed),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BreedImage(
                                breedName: breed,
                              ))),
                );
              },
            );
          }
        },
      ),
    );
  }
}
