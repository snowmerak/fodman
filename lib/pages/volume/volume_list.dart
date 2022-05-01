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
                      Text("driver: ${controller.list[index].driver ?? ''}"),
                      Text("scope: ${controller.list[index].scope ?? ''}"),
                      Text(
                          "created at: ${controller.list[index].createdAt ?? ''}"),
                      Text(
                          "mount count: ${controller.list[index].mountCount ?? -1}"),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("labels: "),
                          Expanded(
                            child: Column(
                              children: (controller.list[index].labels ?? {})
                                  .entries
                                  .map(
                                    (e) => Text("${e.key}: ${e.value}"),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                      Text("")
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
