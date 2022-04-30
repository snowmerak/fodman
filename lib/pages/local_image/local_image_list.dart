// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('Local Images'),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            GetBuilder<LocalImageController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var img = controller.images[controller.imagesKeys[index]];
                    return ListTile(
                      title: Text(controller.imagesKeys[index]),
                      subtitle: Text(img?.id ?? ""),
                      onTap: () {
                        controller.selectedImage = img;
                        Get.toNamed(localImageDetailPage);
                      },
                    );
                  },
                  childCount: controller.imagesKeys.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
