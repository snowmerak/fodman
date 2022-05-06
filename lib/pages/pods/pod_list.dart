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
                                  ),
                                  children: [
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Text("Name"),
                                            ),
                                            TableCell(
                                              child: Text("ID"),
                                            ),
                                            TableCell(
                                              child: Text("Status"),
                                            ),
                                          ],
                                        ),
                                      ] +
                                      (controller.pods[index].containers
                                              ?.map(
                                                (e) => TableRow(
                                                  children: [
                                                    TableCell(
                                                      child: Text(
                                                          e["Names"] ?? ""),
                                                    ),
                                                    TableCell(
                                                      child: Text(
                                                          (e["Id"] as String?)
                                                                  ?.substring(
                                                                      0, 8) ??
                                                              ""),
                                                    ),
                                                    TableCell(
                                                      child: Text(
                                                          e["Status"] ?? ""),
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
                                  ),
                                  children: [
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Text("IP"),
                                            ),
                                            TableCell(
                                              child: Text("IPv6"),
                                            ),
                                            TableCell(
                                              child: Text("MacAddress"),
                                            ),
                                          ],
                                        ),
                                      ] +
                                      (controller.pods[index].containers
                                              ?.map(
                                                (e) => TableRow(
                                                  children: [
                                                    TableCell(
                                                      child: Text(
                                                          e["Names"] ?? ""),
                                                    ),
                                                    TableCell(
                                                      child: Text(
                                                          (e["Id"] as String?)
                                                                  ?.substring(
                                                                      0, 8) ??
                                                              ""),
                                                    ),
                                                    TableCell(
                                                      child: Text(
                                                          e["Status"] ?? ""),
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
