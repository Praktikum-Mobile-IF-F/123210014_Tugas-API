import 'package:flutter/material.dart';

import 'api_data_source.dart';

class BreedImage extends StatelessWidget {
  final String? breedName;

  const BreedImage({super.key, required this.breedName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dog Images'),
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.loadByBreed(breedName),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<String>? imageURLs =
                (snapshot.data?['message'] as List<dynamic>?)?.cast<String>();
            if (imageURLs != null) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: imageURLs.length,
                itemBuilder: (context, index) {
                  return GridTile(
                    child: Image.network(
                      imageURLs[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('No images available.'),
              );
            }
          }
        },
      ),
    );
  }
}
