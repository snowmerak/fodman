// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fodman/controller/volume_list_controller.dart';
import 'package:get/get.dart';

const volumeListPage = "/volume_list";

class VolumeListPage extends StatelessWidget {
  const VolumeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(VolumeListController());

    controller.loadVolumes();

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('Volume List'),
              pinned: true,
              floating: true,
            ),
            GetBuilder<VolumeListController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    expandedAlignment: Alignment.topLeft,
                    title: Text(controller.list[index].name ?? ""),
                    subtitle: Text(controller.list[index].mountpoint ?? ""),
                    children: [
                      Table(
                        columnWidths: {
                          0: FlexColumnWidth(1.0),
                          1: FlexColumnWidth(4.0),
                        },
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
                                child: Text("Driver"),
                              ),
                              TableCell(
                                child:
                                    Text(controller.list[index].driver ?? ""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Scope"),
                              ),
                              TableCell(
                                child: Text(controller.list[index].scope ?? ""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Create At"),
                              ),
                              TableCell(
                                child: Text(
                                    controller.list[index].createdAt ?? ""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Mount Count"),
                              ),
                              TableCell(
                                child: Text(controller.list[index].mountCount
                                        ?.toRadixString(10) ??
                                    ""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Labels"),
                              ),
                              TableCell(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      (controller.list[index].labels ?? {})
                                          .entries
                                          .map(
                                            (e) => Text("${e.key}: ${e.value}"),
                                          )
                                          .toList(),
                                ),
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
                              var result = await controller.removeVolume(
                                  controller.list[index].name ?? "");
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
                                    content: Text("Volume removed"),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () => Get.back(),
                                      )
                                    ],
                                  ),
                                );
                              }
                              controller.loadVolumes();
                            },
                            child: Text(
                              "REMOVE",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }, childCount: controller.list.length),
              ),
            )
          ],
        ),
      ),
    );
  }
}
