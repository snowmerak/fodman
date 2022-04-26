// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fodman/controller/remote_image_controller.dart';
import 'package:fodman/podman/remote_tags.dart';
import 'package:get/get.dart';

const remoteImageListPage = '/remote_image_list';

class RemoteImageListPage extends StatelessWidget {
  const RemoteImageListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RemoteImageController());
    var inputData = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Search'),
      ),
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
              ),
              onChanged: (data) {
                inputData = data;
              },
              onSubmitted: (data) {
                controller.loadImages(data);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Searching for: $data'),
                    );
                  },
                );
              },
            ),
            Expanded(
              child: GetBuilder<RemoteImageController>(
                builder: (controller) => ListView.builder(
                  itemCount: controller.images.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(controller.images[index].name ?? "null"),
                      subtitle: Text(controller.images[index].tag ?? ""),
                      onTap: () async {
                        var img = controller.images[index];
                        var ok = false;
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  "Do you want to pull ${img.name ?? 'null'}?"),
                              actions: [
                                TextButton(
                                  child: Text("Yes"),
                                  onPressed: () {
                                    ok = true;
                                    Get.back();
                                  },
                                ),
                                TextButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    ok = false;
                                    Get.back();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        if (!ok) {
                          return;
                        }
                        var tags =
                            (await searchTags(img.name ?? "null")).first.tags ??
                                [];
                        if (!tags.contains("latest")) {
                          tags.insert(0, "latest");
                        }
                        var textFieldController = TextEditingController();
                        var selectedTag = "latest";
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title:
                                  Text("Select tag of ${img.name ?? 'null'}"),
                              content: Text(
                                  "input tag in the text field and press 'enter'."),
                              actions: [
                                DropdownButton<String>(
                                    value: selectedTag,
                                    items: tags
                                        .map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    onChanged: (data) {
                                      selectedTag = data ?? "latest";
                                      textFieldController.text = selectedTag;
                                    }),
                                TextField(
                                  controller: textFieldController,
                                  decoration: InputDecoration(
                                    hintText: 'tag',
                                  ),
                                  onChanged: (data) {
                                    selectedTag = data;
                                  },
                                  onSubmitted: (data) {
                                    selectedTag = data;
                                    Get.back();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Pulling ${img.name ?? 'null'}"),
                              content: Text("Keep calm and wait..."),
                            );
                          },
                        );
                        var pair = await controller.pullImage(
                            img.name ?? "null", selectedTag);
                        if (pair.item1 != "") {
                          showDialog(
                            context: Get.overlayContext!,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Pulled"),
                                content: Text("ID: ${pair.item1}"),
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: Get.overlayContext!,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Error Occurred"),
                                content: Text(pair.item2),
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
