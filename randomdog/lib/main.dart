import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:randomdog/view/details_screen.dart';

void main() => runApp(MyApp());

class DogImage {
  final String imageUrl;

  DogImage(this.imageUrl);
}

class DogController extends GetxController {
  var dogImages = <DogImage>[].obs;

  void fetchDogImages() async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random/10'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<String> imageUrls = List<String>.from(data['message']);
      dogImages.value = imageUrls.map((url) => DogImage(url)).toList();
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dog Images',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DogImagesScreen(),
    );
  }
}

class DogImagesScreen extends StatelessWidget {
  final DogController _dogController = Get.put(DogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dog Images'),
      ),
      body: Obx(
            () => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: _dogController.dogImages.length,
          itemBuilder: (context, index) {
            final dogImage = _dogController.dogImages[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(imageUrl: dogImage.imageUrl),
                  ),
                );
              },
              child: Image.network(dogImage.imageUrl),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _dogController.fetchDogImages,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
