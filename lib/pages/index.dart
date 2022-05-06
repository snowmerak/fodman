// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fodman/component/sliver_header.dart';
import 'package:fodman/linux/desktop_entry.dart';
import 'package:fodman/pages/containers/container_list.dart';
import 'package:fodman/pages/create_container/create_container.dart';
import 'package:fodman/pages/initialize_machine/initialize_machine.dart';
import 'package:fodman/pages/local_image/local_image_list.dart';
import 'package:fodman/pages/local_machine/local_machine_list.dart';
import 'package:fodman/pages/network/create_network.dart';
import 'package:fodman/pages/network/local_network_list.dart';
import 'package:fodman/pages/pods/create_pod.dart';
import 'package:fodman/pages/remote_image/remote_image_list.dart';
import 'package:fodman/pages/volume/create_volume.dart';
import 'package:fodman/pages/volume/volume_list.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var backgroundColor = MaterialStateProperty.all(Colors.grey[700]);

    const machines = <Tuple3<String, String, IconData>>[
      Tuple3("Local Machines", localMachineListPage, Icons.list),
      Tuple3(
          "Initialize Machine", initializeMachinePage, Icons.create_new_folder),
    ];
    const pods = <Tuple3<String, String, IconData>>[
      Tuple3("Create Pod", createPodPage, Icons.add),
    ];
    const containers = <Tuple3<String, String, IconData>>[
      Tuple3("Container List", containerListPage, Icons.list),
      Tuple3("Create Container", createContainerPage, Icons.add),
    ];
    const images = <Tuple3<String, String, IconData>>[
      Tuple3("Local Images", localImageListPage, Icons.list),
      Tuple3("Search Image", remoteImageListPage, Icons.search),
    ];
    const volumes = <Tuple3<String, String, IconData>>[
      Tuple3("Volume List", volumeListPage, Icons.list),
      Tuple3("Create Volume", createVolumePage, Icons.add),
    ];
    const networks = <Tuple3<String, String, IconData>>[
      Tuple3("Network List", localNetworkListPage, Icons.list),
      Tuple3("Create Network", createNetworkPage, Icons.add),
    ];

    var linuxWidgets = [
      SliverToBoxAdapter(
        child: SizedBox(
          height: 12.0,
        ),
      ),
      SliverPersistentHeader(
        delegate: SliverHeader("linux"),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 12.0,
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: backgroundColor,
            ),
            onPressed: () async {
              var result = await createDesktopEntry();
              if (result.item2.isNotEmpty) {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("error"),
                    content: Text(result.item2),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text("ok"),
                      ),
                    ],
                  ),
                );
              } else {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("success"),
                    content: Text(result.item2),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text("created"),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.35, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.create),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text("Create Desktop Entry"),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    ];

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Fodman"),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("machines"),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                machines
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: backgroundColor,
                          ),
                          onPressed: () => Get.toNamed(e.item2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Row(
                                  children: [
                                    Icon(e.item3),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Text(e.item1),
                                  ],
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("pods"),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                pods
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: backgroundColor,
                          ),
                          onPressed: () => Get.toNamed(e.item2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Row(
                                  children: [
                                    Icon(e.item3),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Text(e.item1),
                                  ],
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("containers"),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                containers
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: backgroundColor,
                          ),
                          onPressed: () => Get.toNamed(e.item2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Row(
                                  children: [
                                    Icon(e.item3),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Text(e.item1),
                                  ],
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("images"),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                images
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: backgroundColor,
                          ),
                          onPressed: () => Get.toNamed(e.item2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Row(
                                  children: [
                                    Icon(e.item3),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Text(e.item1),
                                  ],
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("volumes"),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                volumes
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: backgroundColor,
                          ),
                          onPressed: () => Get.toNamed(e.item2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Row(
                                  children: [
                                    Icon(e.item3),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Text(e.item1),
                                  ],
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeader("networks"),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12.0,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                networks
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: backgroundColor,
                          ),
                          onPressed: () => Get.toNamed(e.item2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Row(
                                  children: [
                                    Icon(e.item3),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Text(e.item1),
                                  ],
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            ...(Platform.isLinux ? linuxWidgets : []),
          ],
        ),
      ),
    );
  }
}
