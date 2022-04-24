// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fodman/controller/remote_image_controller.dart';
import 'package:get/get.dart';

const remoteImageListPage = '/remote_image_list';

class RemoteImageListPage extends StatelessWidget {
  const RemoteImageListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RemoteImageController());
    var inputData = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Search'),
      ),
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
              ),
              onChanged: (data) {
                inputData = data;
              },
              onSubmitted: (data) {
                controller.loadImages(data);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Searched for: $data'),
                    );
                  },
                );
              },
            ),
            Expanded(
              child: GetBuilder<RemoteImageController>(
                builder: (controller) => ListView.builder(
                  itemCount: controller.images.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(controller.images[index].name ?? "null"),
                      subtitle: Text(controller.images[index].tag ?? ""),
                      onTap: () {},
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
