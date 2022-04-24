// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fodman/controller/local_image_controller.dart';
import 'package:get/get.dart';

const localImageDetailPage = '/local_image_detail';

class LocalImageDetailPage extends StatelessWidget {
  const LocalImageDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<LocalImageController>();
    var image = controller.selectedImage!;
    return Scaffold(
      appBar: AppBar(
        title: Text(image.names?.first.split(":").first ?? ""),
      ),
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Table(
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
                        child: Text('Names'),
                      ),
                      TableCell(
                        child: Column(
                          children: (image.names ?? []).map((e) {
                            return Row(
                              children: [
                                Text(e),
                                SizedBox(
                                  width: 16.0,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red),
                                  ),
                                  onPressed: () async {
                                    var result = await controller.rmImage(e);
                                    if (result.item1 != "") {
                                      await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Removed"),
                                            content: Text(result.item1),
                                          );
                                        },
                                      );
                                      controller.loadImages();
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Error"),
                                            content: Text(result.item2),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: Text("remove"),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('ID'),
                      ),
                      TableCell(
                        child: Text(image.id ?? ""),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Parent ID'),
                      ),
                      TableCell(
                        child: Text(image.parentId ?? ""),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Repo Digests'),
                      ),
                      TableCell(
                        child: Text(image.repoDigests?.join("\n") ?? ""),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('size'),
                      ),
                      TableCell(
                        child: Text(image.size?.toString() ?? ""),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Shared Size'),
                      ),
                      TableCell(
                        child: Text(image.sharedSize?.toString() ?? ""),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Virtual Size'),
                      ),
                      TableCell(
                        child: Text(image.virtualSize?.toString() ?? ""),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Labels'),
                      ),
                      TableCell(
                        child: Text(image.labels?.maintainer ?? ""),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Containers'),
                      ),
                      TableCell(
                        child: Text(image.containers?.toString() ?? ""),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Digest'),
                      ),
                      TableCell(
                        child: Text(image.digest!),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('History'),
                      ),
                      TableCell(
                        child: Text(image.history?.join("\n") ?? ""),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Created'),
                      ),
                      TableCell(
                        child: Text(image.created?.toString() ?? ""),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Created At'),
                      ),
                      TableCell(
                        child: Text(image.createdAt?.toString() ?? ""),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
