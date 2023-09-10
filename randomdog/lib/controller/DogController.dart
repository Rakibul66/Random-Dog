import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/DogImage.dart';

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
