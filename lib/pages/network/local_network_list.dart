// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fodman/controller/network_list_controller.dart';
import 'package:get/get.dart';

const localNetworkListPage = "/local_network_list";

class LocalNetworkListPage extends StatelessWidget {
  const LocalNetworkListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(NetworkListController());

    controller.loadNetworks();

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Local Networks"),
              floating: true,
              pinned: true,
            ),
            GetBuilder<NetworkListController>(
              builder: (controller) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ExpansionTile(
                    title: Text(controller.networks[index].name ?? ""),
                    subtitle: Text(controller.networks[index].id ?? ""),
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
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                              ),
                              TableCell(
                                child: Text(
                                    controller.networks[index].driver ?? ""),
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Network Interface"),
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                              ),
                              TableCell(
                                child: Text(controller
                                        .networks[index].networkInterface ??
                                    ""),
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Created"),
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                              ),
                              TableCell(
                                child: Text(
                                    controller.networks[index].created ?? ""),
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("IPv6 Enabled"),
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                              ),
                              TableCell(
                                child: Text(
                                    "${controller.networks[index].ipv6Enabled}"),
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Internal"),
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                              ),
                              TableCell(
                                child: Text(
                                    "${controller.networks[index].internal}"),
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Dns Enabled"),
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                              ),
                              TableCell(
                                child: Text(
                                    "${controller.networks[index].dnsEnabled}"),
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("IPAM Driver"),
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                              ),
                              TableCell(
                                child: Text(controller
                                        .networks[index].ipamOptions?.driver ??
                                    ""),
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text("Subnets"),
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                              ),
                              TableCell(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: controller.networks[index].subnets
                                          ?.map((e) => Text(
                                              "- subnet: ${e.subnet}\n   gateway: ${e.gateway}"))
                                          .toList() ??
                                      [],
                                ),
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
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
                              var result = await controller.removeNetwork(
                                controller.networks[index].id ?? "",
                              );
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
                                      ),
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
                                      ),
                                    ],
                                  ),
                                );
                              }
                              controller.loadNetworks();
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
                  childCount: controller.networks.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
