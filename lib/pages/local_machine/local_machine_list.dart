// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fodman/controller/machine_list_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

const localMachineListPage = "/local_machine_list";

class LocalMachineListPage extends StatelessWidget {
  const LocalMachineListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var machineListController = Get.put(MachineListController());

    machineListController.loadMachines();

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Local Machines"),
            ),
            GetBuilder<MachineListController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ExpansionTile(
                    title: Text(controller.machines[index].name ?? ""),
                    expandedAlignment: Alignment.topLeft,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("cpus: ${controller.machines[index].cPUs}"),
                      Text(
                          "memory: ${int.parse(controller.machines[index].memory ?? '0') / 1e+6} MB"),
                      Text(
                          "disk: ${int.parse(controller.machines[index].diskSize ?? '0') / 1e+9} GB"),
                      Text(
                          "is default: ${controller.machines[index].defaults}"),
                      Text("is running: ${controller.machines[index].running}"),
                      Text("lastup: ${controller.machines[index].lastUp}"),
                      Text("created: ${controller.machines[index].created}"),
                      Text("VM type: ${controller.machines[index].vMType}"),
                      Text(
                          "remote username: ${controller.machines[index].remoteUsername}"),
                      Text("stream: ${controller.machines[index].stream}"),
                      Text(
                          "identity Path: ${controller.machines[index].identityPath}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async {
                              showDialog(
                                context: Get.overlayContext!,
                                builder: (context) => AlertDialog(
                                  title: Text("Will change default machine"),
                                  content:
                                      Text("Press 'OK' and wait a minutes..."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text("OK")),
                                  ],
                                ),
                              );
                              var result = await controller.useMachine(
                                controller.machines[index].name ?? "",
                              );
                              if (result.item2.isNotEmpty) {
                                await showDialog(
                                  context: Get.overlayContext!,
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
                              } else {
                                await showDialog(
                                  context: Get.overlayContext!,
                                  builder: (context) => AlertDialog(
                                    title: Text("Success"),
                                    content: Text(
                                        "Machine is now used\n" + result.item1),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () => Get.back(),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              controller.loadMachines();
                            },
                            child: Text(
                              "USE",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              var result = await controller.removeMachine(
                                  controller.machines[index].name ?? "");
                              if (result.item2.isNotEmpty) {
                                await showDialog(
                                  context: Get.overlayContext!,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(result.item2),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: Text("OK"),
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
                                      content: Text("Machine is removed"),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: Text("OK"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                              controller.loadMachines();
                            },
                            child: Text(
                              "REMOVE",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  childCount: controller.machines.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
