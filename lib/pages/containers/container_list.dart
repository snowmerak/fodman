// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fodman/controller/container_list_controller.dart';
import 'package:get/get.dart';

const containerListPage = "/container_list";

class ContainerListPage extends StatelessWidget {
  const ContainerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var containerListController = Get.put(ContainerListController());
    containerListController.loadContainers();

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Container List"),
              pinned: true,
              floating: true,
            ),
            GetBuilder<ContainerListController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ExpansionTile(
                    title: Text(controller.list[index].id ?? "no id"),
                    subtitle: Text(controller.list[index].image ?? "no image"),
                    children: [
                      Table(
                        columnWidths: {
                          0: FlexColumnWidth(1.0),
                          1: FlexColumnWidth(4.0),
                        },
                        border: TableBorder(
                          horizontalInside: BorderSide(
                            width: 1.0,
                            color: Colors.white12,
                          ),
                        ),
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Name"),
                              ),
                              TableCell(
                                child: Text(
                                    controller.list[index].names?.join("\n") ??
                                        "no id"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("State"),
                              ),
                              TableCell(
                                child: Text(
                                    controller.list[index].state ?? "no state"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Status"),
                              ),
                              TableCell(
                                child: Text(controller.list[index].status ??
                                    "no status"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Command"),
                              ),
                              TableCell(
                                child: Text(
                                    controller.list[index].command?.join(" ") ??
                                        "no command"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Ports"),
                              ),
                              TableCell(
                                child: Table(
                                  border: TableBorder(
                                    horizontalInside: BorderSide(
                                      width: 1.0,
                                      color: Colors.white12,
                                    ),
                                  ),
                                  children: [
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Text("Host IP"),
                                            ),
                                            TableCell(
                                              child: Text("Container Port"),
                                            ),
                                            TableCell(
                                              child: Text("Host Port"),
                                            ),
                                            TableCell(
                                              child: Text("Range"),
                                            ),
                                            TableCell(
                                              child: Text("Protocol"),
                                            ),
                                          ],
                                        )
                                      ] +
                                      (controller.list[index].ports
                                              ?.map(
                                                (e) => TableRow(
                                                  children: e.entries
                                                      .map(
                                                        (e) => TableCell(
                                                          child: Text(
                                                              "${e.value}"),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              )
                                              .toList() ??
                                          []),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Mounts"),
                              ),
                              TableCell(
                                child: Text(
                                    controller.list[index].mounts?.join("\n") ??
                                        "no mounts"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Networks"),
                              ),
                              TableCell(
                                child: Text(controller.list[index].networks
                                        ?.join("\n") ??
                                    "no networks"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Pod"),
                              ),
                              TableCell(
                                child: Text(
                                    controller.list[index].pod ?? "no pod"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Pod Name"),
                              ),
                              TableCell(
                                child: Text(controller.list[index].podName ??
                                    "no podName"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Created At"),
                              ),
                              TableCell(
                                child: Text(controller.list[index].createdAt ??
                                    "no createdAt"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Started At"),
                              ),
                              TableCell(
                                child: Text(controller.list[index].startedAt
                                        ?.toString() ??
                                    "no startedAt"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Exited"),
                              ),
                              TableCell(
                                child: Text(
                                    controller.list[index].exited?.toString() ??
                                        "no exited"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Exit Code"),
                              ),
                              TableCell(
                                child: Text(controller.list[index].exitCode
                                        ?.toString() ??
                                    "no exitCode"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Auto Remove"),
                              ),
                              TableCell(
                                child: Text(controller.list[index].autoRemove
                                        ?.toString() ??
                                    "no autoRemove"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("PID"),
                              ),
                              TableCell(
                                child: Text(
                                    controller.list[index].pid?.toString() ??
                                        "no pid"),
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
                                  title: Text("Start Container"),
                                  content: Text("Wait a minute..."),
                                ),
                              );
                              var result =
                                  await containerListController.startContainer(
                                      controller.list[index].id ?? "");
                              if (result.item1.isEmpty) {
                                showDialog(
                                  context: Get.overlayContext!,
                                  builder: (context) => AlertDialog(
                                    title: Text("Error"),
                                    content: Text(result.item2),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text("OK"),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: Get.overlayContext!,
                                  builder: (context) => AlertDialog(
                                    title: Text("Success"),
                                    content: Text(result.item1),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text("OK"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Text("Start",
                                style: TextStyle(color: Colors.green)),
                          ),
                          TextButton(
                            onPressed: () async {
                              showDialog(
                                context: Get.overlayContext!,
                                builder: (context) => AlertDialog(
                                  title: Text("Stop Container"),
                                  content: Text("Wait a minute..."),
                                ),
                              );
                              var result =
                                  await containerListController.stopContainer(
                                      controller.list[index].id ?? "");
                              if (result.item1.isEmpty) {
                                showDialog(
                                  context: Get.overlayContext!,
                                  builder: (context) => AlertDialog(
                                    title: Text("Error"),
                                    content: Text(result.item2),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text("OK"),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: Get.overlayContext!,
                                  builder: (context) => AlertDialog(
                                    title: Text("Success"),
                                    content: Text(result.item1),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text("OK"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Text("Stop",
                                style: TextStyle(color: Colors.orange)),
                          ),
                          VerticalDivider(),
                          TextButton(
                            onPressed: () async {
                              var result = await controller.unpauseContainer(
                                  controller.list[index].id ?? "");
                              if (result.item1.isEmpty) {
                                showDialog(
                                  context: Get.overlayContext!,
                                  builder: (context) => AlertDialog(
                                    title: Text("Error"),
                                    content: Text(result.item2),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text("OK"),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: Get.overlayContext!,
                                  builder: (context) => AlertDialog(
                                    title: Text("Success"),
                                    content: Text(result.item1),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text("OK"),
                                      )
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "Unpause",
                              style: TextStyle(color: Colors.cyan),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              var result = await controller.pauseContainer(
                                  controller.list[index].id ?? "");
                              if (result.item1.isEmpty) {
                                showDialog(
                                  context: Get.overlayContext!,
                                  builder: (context) => AlertDialog(
                                    title: Text("Error"),
                                    content: Text(result.item2),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text("OK"),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: Get.overlayContext!,
                                  builder: (context) => AlertDialog(
                                    title: Text("Success"),
                                    content: Text(result.item1),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text("OK"),
                                      )
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "Pause",
                              style: TextStyle(color: Colors.lime),
                            ),
                          ),
                          VerticalDivider(),
                          TextButton(
                            onPressed: () async {
                              showDialog(
                                context: Get.overlayContext!,
                                builder: (context) => AlertDialog(
                                  title: Text("Remove Container"),
                                  content: Text("Wait a minute..."),
                                ),
                              );
                              var result =
                                  await containerListController.removeContainer(
                                      controller.list[index].id ?? "");
                              if (result.item1.isEmpty) {
                                showDialog(
                                  context: Get.overlayContext!,
                                  builder: (context) => AlertDialog(
                                    title: Text("Error"),
                                    content: Text(result.item2),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text("OK"),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: Get.overlayContext!,
                                  builder: (context) => AlertDialog(
                                    title: Text("Success"),
                                    content: Text(result.item1),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text("OK"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Text("Remove",
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  childCount: controller.list.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
