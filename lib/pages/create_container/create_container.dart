// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fodman/component/sliver_header.dart';
import 'package:fodman/controller/annotation_controller.dart';
import 'package:fodman/controller/host_ip_mapping_controller.dart';
import 'package:fodman/controller/local_image_controller.dart';
import 'package:get/get.dart';

const createContainerPage = '/create_container';

class CreateContainerPage extends StatelessWidget {
  const CreateContainerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localImageController = Get.put(LocalImageController());

    var hostIPMappingController = Get.put(HostIPMappingController());
    var annotationController = Get.put(AnnotationController());

    var containerName = "";
    var containerIPMapping = "";

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: TextField(
                onChanged: (value) => containerName = value,
                decoration: InputDecoration(
                  labelText: 'Container Name',
                ),
              ),
              floating: true,
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("Host to IP Mapping Table"),
              pinned: true,
              floating: true,
            ),
            GetBuilder<HostIPMappingController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          onChanged: (value) => controller.setAt(
                              index, value, controller.list[index].item2),
                          decoration: InputDecoration(
                            labelText: 'Host',
                          ),
                        ),
                      ),
                      Text(":"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          onChanged: (value) => controller.setAt(
                              index, controller.list[index].item1, value),
                          decoration: InputDecoration(
                            labelText: 'IP',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => controller.removeAt(index),
                      ),
                    ],
                  ),
                  childCount: controller.list.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    onPressed: () => hostIPMappingController.append(),
                    color: Colors.white,
                    icon: Icon(Icons.add),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("Annotation"),
              pinned: true,
              floating: true,
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            GetBuilder<AnnotationController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          onChanged: (value) => controller.setAt(
                              index, value, controller.list[index].item2),
                          decoration: InputDecoration(
                            labelText: 'Key',
                          ),
                        ),
                      ),
                      Text(":"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          onChanged: (value) => controller.setAt(
                              index, controller.list[index].item1, value),
                          decoration: InputDecoration(
                            labelText: 'Value',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => controller.removeAt(index),
                      ),
                    ],
                  ),
                  childCount: controller.list.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    onPressed: () => annotationController.append(),
                    color: Colors.white,
                    icon: Icon(Icons.add),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
