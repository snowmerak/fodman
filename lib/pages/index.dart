import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Index'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Get.toNamed('/image_list');
            },
            child: const Text('Go to Image List')),
      ),
    );
  }
}
