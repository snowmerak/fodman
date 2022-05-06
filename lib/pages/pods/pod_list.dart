// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fodman/controller/pod_list_controller.dart';
import 'package:get/get.dart';

const podListPage = "/pods";

class PodListPage extends StatelessWidget {
  const PodListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PodListController());
    controller.loadPods();

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Pods"),
              pinned: true,
              floating: true,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            GetBuilder<PodListController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ExpansionTile(
                    title: Text(controller.pods[index].name ?? ""),
                    subtitle: Text(controller.pods[index].id ?? ""),
                    children: [
                      Table(
                        border: TableBorder(
                          horizontalInside: BorderSide(
                            color: Colors.white12,
                            width: 1.0,
                          ),
                        ),
                        columnWidths: const {
                          0: FlexColumnWidth(1.0),
                          1: FlexColumnWidth(4.0),
                        },
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("C-Group"),
                              ),
                              TableCell(
                                child:
                                    Text(controller.pods[index].cgroup ?? ""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Containers"),
                              ),
                              TableCell(
                                child: Table(
                                  border: TableBorder(
                                    horizontalInside: BorderSide(
                                      color: Colors.white12,
                                      width: 1.0,
                                    ),
                                    verticalInside: BorderSide(
                                      color: Colors.white12,
                                      width: 1.0,
                                    ),
                                  ),
                                  children: [
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Center(
                                                child: Text("Name"),
                                              ),
                                            ),
                                            TableCell(
                                              child: Center(
                                                child: Text("ID"),
                                              ),
                                            ),
                                            TableCell(
                                              child: Center(
                                                child: Text("Status"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ] +
                                      (controller.pods[index].containers
                                              ?.map(
                                                (e) => TableRow(
                                                  children: [
                                                    TableCell(
                                                      child: Center(
                                                        child: Text(
                                                            e["Names"] ?? ""),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Center(
                                                        child: Text(
                                                            (e["Id"] as String?)
                                                                    ?.substring(
                                                                        0, 8) ??
                                                                ""),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Center(
                                                        child: Text(
                                                            e["Status"] ?? ""),
                                                      ),
                                                    ),
                                                  ],
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
                                child: Text("Networks"),
                              ),
                              TableCell(
                                child: Table(
                                  border: TableBorder(
                                    horizontalInside: BorderSide(
                                      color: Colors.white12,
                                      width: 1.0,
                                    ),
                                    verticalInside: BorderSide(
                                      color: Colors.white12,
                                      width: 1.0,
                                    ),
                                  ),
                                  children: [
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Center(
                                                child: Text("Name"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ] +
                                      (controller.pods[index].networks
                                              ?.map(
                                                (e) => TableRow(
                                                  children: [
                                                    TableCell(
                                                      child: Center(
                                                        child: Text(e),
                                                      ),
                                                    ),
                                                  ],
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
                                child: Text("Labels"),
                              ),
                              TableCell(
                                child: Table(
                                  border: TableBorder(
                                    horizontalInside: BorderSide(
                                      color: Colors.white12,
                                      width: 1.0,
                                    ),
                                    verticalInside: BorderSide(
                                      color: Colors.white12,
                                      width: 1.0,
                                    ),
                                  ),
                                  children: [
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Center(
                                                child: Text("Key"),
                                              ),
                                            ),
                                            TableCell(
                                              child: Center(
                                                child: Text("Value"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ] +
                                      (controller.pods[index].labels?.entries
                                              .map(
                                                (e) => TableRow(
                                                  children: [
                                                    TableCell(
                                                      child: Center(
                                                        child: Text(e.key),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Center(
                                                        child: Text(e.value),
                                                      ),
                                                    ),
                                                  ],
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
                                child: Text("Created"),
                              ),
                              TableCell(
                                child:
                                    Text(controller.pods[index].created ?? ""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Status"),
                              ),
                              TableCell(
                                child:
                                    Text(controller.pods[index].status ?? ""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Infra ID"),
                              ),
                              TableCell(
                                child:
                                    Text(controller.pods[index].infraId ?? ""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Namespace"),
                              ),
                              TableCell(
                                child: Text(
                                    controller.pods[index].namespace ?? ""),
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
                              var result = await controller
                                  .removePod(controller.pods[index].id ?? "");
                              if (result.item1.isEmpty) {
                                await showDialog(
                                  context: Get.overlayContext!,
                                  builder: (context) => AlertDialog(
                                    title: Text("Error"),
                                    content: Text(result.item2),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () => Get.back(),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                await showDialog(
                                  context: Get.overlayContext!,
                                  builder: (context) => AlertDialog(
                                    title: Text("Success"),
                                    content: Text(result.item2),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () => Get.back(),
                                      )
                                    ],
                                  ),
                                );
                              }
                              controller.loadPods();
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
                  childCount: controller.pods.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
