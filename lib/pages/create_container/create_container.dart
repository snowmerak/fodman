// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fodman/component/sliver_header.dart';
import 'package:fodman/controller/annotation_controller.dart';
import 'package:fodman/controller/container_create_controller.dart';
import 'package:fodman/controller/container_environment_controller.dart';
import 'package:fodman/controller/container_restart_controller.dart';
import 'package:fodman/controller/create_bool_controller.dart';
import 'package:fodman/controller/host_ip_mapping_controller.dart';
import 'package:fodman/controller/local_image_controller.dart';
import 'package:fodman/controller/memory_unit_controller.dart';
import 'package:fodman/controller/mount_list_controller.dart';
import 'package:get/get.dart';

const createContainerPage = '/create_container';

class CreateContainerPage extends StatelessWidget {
  const CreateContainerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localImageController = Get.put(LocalImageController());
    if (localImageController.images.isEmpty) {
      localImageController.loadImages();
    }

    var imageNameController = TextEditingController();
    var hostIPMappingController = Get.put(HostIPMappingController());
    var annotationController = Get.put(AnnotationController());

    var containerName = "";

    var cpus = 0;
    var memory = 0;
    var memoryUnitController = Get.put(MemoryUnitController());

    var mountListController = Get.put(MountListController());

    var restartController = Get.put(ContainerRestartController());

    var optionController = Get.put(CreateOptionController());

    var resultController = Get.put(ContainerCreateController());

    var environmentController = Get.put(ContainerEnvironmentController());

    imageNameController.text = localImageController.selectedTag ?? "";
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
              delegate: SliverHeader('Select or Input Image Name'),
              floating: true,
            ),
            SliverToBoxAdapter(
              child: GetBuilder<LocalImageController>(
                builder: (controller) {
                  var localImages = <String>[];
                  for (var value in controller.images.values) {
                    localImages.addAll(value.names ?? <String>[]);
                  }
                  localImages.sort(((a, b) => a.compareTo(b)));

                  return DropdownButton<String>(
                    hint: Text('Select Image'),
                    items: localImages
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: (data) => imageNameController.text = data ?? "",
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: TextField(
                controller: imageNameController,
                decoration: InputDecoration(
                  labelText: 'Image Name',
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("Host to IP Mapping Table"),
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
                        color: Colors.red,
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
                        color: Colors.red,
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
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("Input Hardware Specification"),
              floating: true,
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverToBoxAdapter(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'CPUs',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                onChanged: (number) {
                  if (number.isEmpty) {
                    cpus = 0;
                    return;
                  }
                  cpus = int.parse(number).abs();
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Memory',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      onChanged: (number) {
                        if (number.isEmpty) {
                          memory = 0;
                          return;
                        }
                        memory = int.parse(number).abs();
                      },
                    ),
                  ),
                  GetBuilder<MemoryUnitController>(
                    builder: (controller) => DropdownButton<String>(
                      value: controller.memoryUnit,
                      items: <String>["b", "k", "m", "g"]
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (data) =>
                          controller.setMemoryUnit(data ?? "m"),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("Add Volumes"),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            GetBuilder<MountListController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          onChanged: (value) => controller.setVolumeAt(
                              index, value, controller.volumes[index].item2),
                          decoration: InputDecoration(
                            labelText: 'Host',
                          ),
                        ),
                      ),
                      Text(":"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          onChanged: (value) => controller.setVolumeAt(
                              index, controller.volumes[index].item1, value),
                          decoration: InputDecoration(
                            labelText: 'Container',
                          ),
                        ),
                      ),
                      IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.delete),
                        onPressed: () => controller.removeVolumeAt(index),
                      ),
                    ],
                  ),
                  childCount: controller.volumes.length,
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
                    onPressed: () => mountListController.appendVolume(),
                    color: Colors.white,
                    icon: Icon(Icons.add),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("Add Binds"),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            GetBuilder<MountListController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          onChanged: (value) => controller.setBindAt(
                              index, value, controller.binds[index].item2),
                          decoration: InputDecoration(
                            labelText: 'Host',
                          ),
                        ),
                      ),
                      Text(":"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          onChanged: (value) => controller.setBindAt(
                              index, controller.binds[index].item1, value),
                          decoration: InputDecoration(
                            labelText: 'Container',
                          ),
                        ),
                      ),
                      IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.delete),
                        onPressed: () => controller.removeBindAt(index),
                      ),
                    ],
                  ),
                  childCount: controller.binds.length,
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
                    onPressed: () => mountListController.appendBind(),
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
              delegate: SliverHeader("Add Env"),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            GetBuilder<ContainerEnvironmentController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          onChanged: (value) => controller.setEnvAt(
                              index, value, controller.envs[index].item2),
                          decoration: InputDecoration(
                            labelText: 'Key',
                          ),
                        ),
                      ),
                      Text("="),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          onChanged: (value) => controller.setEnvAt(
                              index, controller.envs[index].item1, value),
                          decoration: InputDecoration(
                            labelText: 'Value',
                          ),
                        ),
                      ),
                      IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.delete),
                        onPressed: () => controller.removeAt(index),
                      ),
                    ],
                  ),
                  childCount: controller.envs.length,
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
                    onPressed: () => environmentController.append(),
                    color: Colors.white,
                    icon: Icon(Icons.add),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("ETC"),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            GetBuilder<ContainerRestartController>(
              builder: (controller) => SliverToBoxAdapter(
                child: Row(
                  children: [
                    Text("Restart Policy: "),
                    DropdownButton<String>(
                      hint: Text("Restart Policy"),
                      value: controller.selectedOption,
                      items: controller.options
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (data) =>
                          controller.setSelectedOption(data ?? "no"),
                    ),
                  ],
                ),
              ),
            ),
            GetBuilder<CreateOptionController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Row(
                    children: [
                      Text("${controller.keys[index]}: "),
                      Switch(
                        value:
                            controller.options[controller.keys[index]] ?? false,
                        onChanged: (value) =>
                            controller.setOption(controller.keys[index], value),
                      ),
                    ],
                  ),
                  childCount: controller.keys.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("Create"),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverToBoxAdapter(
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.create),
                  color: Colors.white,
                ),
              ),
            ),
            GetBuilder<ContainerCreateController>(
              builder: (controller) => SliverToBoxAdapter(
                child: Row(
                  children: [
                    Text(controller.result),
                    TextButton(
                      onPressed: () => Clipboard.setData(
                          ClipboardData(text: controller.result)),
                      child: Text("COPY"),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12.0),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                child: Text("RUN"),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
