// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fodman/controller/machine_list_controller.dart';
import 'package:get/get.dart';

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
                      Table(
                        columnWidths: {
                          0: FlexColumnWidth(1.0),
                          1: FlexColumnWidth(4.0),
                        },
                        border: TableBorder(
                          horizontalInside:
                              BorderSide(color: Colors.white12, width: 1.0),
                        ),
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("CPUs"),
                              ),
                              TableCell(
                                child: Text(controller.machines[index].cPUs
                                        ?.toRadixString(10) ??
                                    ""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Memory"),
                              ),
                              TableCell(
                                child: Text(
                                    "${int.parse(controller.machines[index].memory ?? '0') / 1e+9} GB"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Disk"),
                              ),
                              TableCell(
                                child: Text(
                                    "${int.parse(controller.machines[index].diskSize ?? '0') / 1e+9} GB"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Is Default"),
                              ),
                              TableCell(
                                child: Text(
                                    (controller.machines[index].defaults ??
                                            false)
                                        ? "Yes"
                                        : "No"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Is Running"),
                              ),
                              TableCell(
                                child: Text(
                                    (controller.machines[index].running ??
                                            false)
                                        ? "Yes"
                                        : "No"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Last Up"),
                              ),
                              TableCell(
                                child: Text(
                                    controller.machines[index].lastUp ?? ""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Created At"),
                              ),
                              TableCell(
                                child: Text(
                                    controller.machines[index].created ?? ""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("VM type"),
                              ),
                              TableCell(
                                child: Text(
                                    controller.machines[index].vMType ?? ""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Remote Username"),
                              ),
                              TableCell(
                                child: Text(
                                    controller.machines[index].remoteUsername ??
                                        ""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Stream"),
                              ),
                              TableCell(
                                child: Text(
                                    controller.machines[index].stream ?? ""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Identity Path"),
                              ),
                              TableCell(
                                child: Text(
                                    controller.machines[index].identityPath ??
                                        ""),
                              ),
                            ],
                          ),
                        ],
                      ),
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
