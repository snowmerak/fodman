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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Names: "),
                          Text(controller.list[index].names?.join("\n") ??
                              "no name"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("State: "),
                          Text(controller.list[index].state?.toString() ??
                              "no state"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Status: "),
                          Text(controller.list[index].status?.toString() ??
                              "no status"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Command: "),
                          Text(controller.list[index].command?.join(" ") ??
                              "no command"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ports: "),
                          Text(controller.list[index].ports?.join("\n") ??
                              "no ports"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mounts: "),
                          Text(controller.list[index].mounts?.join("\n") ??
                              "no mounts"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Networks: "),
                          Text(controller.list[index].networks?.join("\n") ??
                              "no networks"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Labels: "),
                          Text(controller.list[index].labels?.entries
                                  .map((e) => "${e.key}: ${e.value}")
                                  .join("\n") ??
                              "no labels"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pod: "),
                          Text(controller.list[index].pod ?? "no pod"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("PodName: "),
                          Text(controller.list[index].podName ?? "no podName"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("CreatedAt: "),
                          Text(controller.list[index].createdAt?.toString() ??
                              "no createdAt"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("StartedAt: "),
                          Text(controller.list[index].startedAt?.toString() ??
                              "no startedAt"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Exited: "),
                          Text(controller.list[index].exited?.toString() ??
                              "no exited"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ExitCode: "),
                          Text(controller.list[index].exitCode?.toString() ??
                              "no exitCode"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("AutoRemove: "),
                          Text(controller.list[index].autoRemove?.toString() ??
                              "?"),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("PID: "),
                          Text(controller.list[index].pid?.toString() ??
                              "no pid"),
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
