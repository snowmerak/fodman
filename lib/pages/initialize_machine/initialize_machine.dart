// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fodman/component/sliver_header.dart';
import 'package:fodman/controller/initialize_machine_controllers/machine_spec_controller.dart';
import 'package:fodman/controller/initialize_machine_controllers/machine_volume_controller.dart';
import 'package:fodman/podman/local_machine.dart';
import 'package:get/get.dart';

const initializeMachinePage = "/initialize_machine";

class InitializeMachinePage extends StatelessWidget {
  const InitializeMachinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var machineName = "";

    var specController = Get.put(MachineSpecController());

    var volumeController = Get.put(MachineVolumeController());

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: TextField(
                decoration: InputDecoration(
                  labelText: "Machine Name",
                ),
                onChanged: (data) => machineName = data,
              ),
              pinned: true,
              floating: true,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("Specifications"),
            ),
            SliverToBoxAdapter(
              child: TextField(
                decoration: InputDecoration(
                  labelText: "number of CPU cores",
                ),
                onChanged: (data) {
                  if (data.isNotEmpty) {
                    specController.setCpus(int.parse(data));
                    return;
                  }
                  specController.setCpus(1);
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: TextField(
                decoration: InputDecoration(
                  labelText: "memory (MB)",
                ),
                onChanged: (data) {
                  if (data.isNotEmpty) {
                    specController.setMemory(int.parse(data));
                    return;
                  }
                  specController.setMemory(2048);
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: TextField(
                decoration: InputDecoration(
                  labelText: "disk space (GB)",
                ),
                onChanged: (data) {
                  if (data.isNotEmpty) {
                    specController.setDisks(int.parse(data));
                    return;
                  }
                  specController.setDisks(100);
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("Volumes"),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            GetBuilder<MachineVolumeController>(
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
                        icon: Icon(Icons.remove),
                        onPressed: () => controller.removeAt(index),
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
                    onPressed: () => volumeController.append(),
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
              delegate: SliverHeader("Initialize Machine"),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () async {
                  if (machineName.isEmpty) {
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Machine Name is empty"),
                        content: Text("Please enter a machine name"),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () => Get.back(),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  if (specController.cpus == 0) {
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("CPU is empty"),
                        content: Text("Please enter a number of CPU cores"),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () => Get.back(),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  if (specController.memory == 0) {
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Memory is empty"),
                        content: Text("Please enter a memory size"),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () => Get.back(),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  if (specController.disks == 0) {
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Disk is empty"),
                        content: Text("Please enter a disk size"),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () => Get.back(),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  showDialog(
                    context: Get.overlayContext!,
                    builder: (context) => AlertDialog(
                      title: Text("Initialize Machine"),
                      content: Text("Press 'OK' and wait for a while..."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                  var result = await initMachine(
                      machineName,
                      specController.cpus,
                      specController.memory,
                      specController.disks,
                      volumeController.volumes);
                  if (result.item1.isEmpty) {
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Error"),
                        content: Text(result.item2),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () => Get.back(),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  await showDialog(
                    context: Get.overlayContext!,
                    builder: (context) => AlertDialog(
                      title: Text("Success"),
                      content: Text("Machine is initialized"),
                      actions: [
                        TextButton(
                          child: Text("OK"),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                  );
                },
                child: Text("INITIALIZE"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
