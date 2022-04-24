import 'package:flutter/material.dart';
import 'package:fodman/controller/local_image_controller.dart';
import 'package:fodman/pages/local_image/local_image_detail.dart';
import 'package:get/get.dart';

const localImageListPage = '/local_image_list';

class LocalImageListPage extends StatelessWidget {
  const LocalImageListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LocalImageController());
    controller.loadImages();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image List'),
      ),
      body: GetBuilder<LocalImageController>(
        builder: (imgs) => Center(
          child: ListView.builder(
            itemCount: imgs.images.length,
            itemBuilder: (context, index) {
              var key = imgs.imagesKeys[index];
              var img = imgs.images[key]!;
              return ListTile(
                title: Text(key),
                subtitle: Text(img.id!),
                onTap: () {
                  controller.selectedImage = img;
                  Get.toNamed(localImageDetailPage);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
