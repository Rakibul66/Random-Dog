import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String imageUrl;

  DetailsScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Details'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            _showDownloadDialog(context);
          },
          child: Image.network(imageUrl),
        ),
      ),
    );
  }

  void _showDownloadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Download Image?'),
        content: Text('Do you want to download this image?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement image download logic here
              // You can use packages like `flutter_downloader` or `dio` for downloading
              Navigator.of(context).pop();
            },
            child: Text('Download'),
          ),
        ],
      ),
    );
  }
}
