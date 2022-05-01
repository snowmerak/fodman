// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fodman/component/sliver_header.dart';
import 'package:fodman/controller/create_volume_controller.dart';
import 'package:get/get.dart';

const createVolumePage = "/create_volume";

class CreateVolumePage extends StatelessWidget {
  const CreateVolumePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CreateVolumeController());

    var volumeName = "";

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: TextField(
                decoration: InputDecoration(
                  hintText: "Volume name",
                ),
                onChanged: (value) => volumeName = value,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("Labels"),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            GetBuilder<CreateVolumeController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Key",
                          ),
                          onChanged: (value) => controller.setAt(
                              index, value, controller.labels[index].item2),
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Value",
                          ),
                          onChanged: (value) => controller.setAt(
                              index, controller.labels[index].item1, value),
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.remove),
                        onPressed: () => controller.removeAt(index),
                      ),
                    ],
                  ),
                  childCount: controller.labels.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverToBoxAdapter(
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.add),
                  onPressed: controller.append,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("Create"),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverToBoxAdapter(
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.create),
                  onPressed: () async {
                    var result = await controller.createVolume(
                        volumeName, controller.labels);
                    if (result.item1.isEmpty) {
                      await showDialog(
                        context: Get.overlayContext!,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text(result.item2),
                            actions: [
                              TextButton(
                                child: Text("OK"),
                                onPressed: () => Get.back(),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      await showDialog(
                        context: Get.overlayContext!,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Success"),
                            content: Text("Volume created"),
                            actions: [
                              TextButton(
                                child: Text("OK"),
                                onPressed: () => Get.back(),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    Get.back();
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
