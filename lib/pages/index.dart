// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fodman/component/sliver_header.dart';
import 'package:fodman/pages/containers/container_list.dart';
import 'package:fodman/pages/create_container/create_container.dart';
import 'package:fodman/pages/initialize_machine/initialize_machine.dart';
import 'package:fodman/pages/local_image/local_image_list.dart';
import 'package:fodman/pages/local_machine/local_machine_list.dart';
import 'package:fodman/pages/remote_image/remote_image_list.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var backgroundColor = MaterialStateProperty.all(Colors.grey[700]);

    const machines = <Tuple3<String, String, IconData>>[
      Tuple3(
          "Initialize Machine", initializeMachinePage, Icons.create_new_folder),
      Tuple3("Local Machines", localMachineListPage, Icons.list),
    ];
    const containers = <Tuple3<String, String, IconData>>[
      Tuple3("Create Container", createContainerPage, Icons.add),
      Tuple3("Container List", containerListPage, Icons.list),
    ];
    const images = <Tuple3<String, String, IconData>>[
      Tuple3("Local Images", localImageListPage, Icons.list),
      Tuple3("Search Image", remoteImageListPage, Icons.search),
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
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.32,
                                0,
                                MediaQuery.of(context).size.width * 0.32,
                                0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(e.item3),
                                Text(e.item1),
                              ],
                            ),
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
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.32,
                                0,
                                MediaQuery.of(context).size.width * 0.32,
                                0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(e.item3),
                                Text(e.item1),
                              ],
                            ),
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
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.32,
                                0,
                                MediaQuery.of(context).size.width * 0.32,
                                0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(e.item3),
                                Text(e.item1),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
