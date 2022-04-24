import 'package:flutter/material.dart';
import 'package:fodman/podman/local_image.dart';

class ImageListPage extends StatelessWidget {
  const ImageListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var images = getImages();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image List'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: images.map((e) => Text(e.names!.join(','))).toList(),
      ),
    );
  }
}
