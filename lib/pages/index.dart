// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fodman/component/sliver_header.dart';
import 'package:fodman/pages/create_container/create_container.dart';
import 'package:fodman/pages/local_image/local_image_list.dart';
import 'package:fodman/pages/remote_image/remote_image_list.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colors = <Color>[
      Color.fromRGBO(58, 176, 230, 1.0),
      Color.fromRGBO(20, 39, 91, 1.0),
      Color.fromRGBO(89, 195, 225, 1.0),
      Color.fromRGBO(218, 135, 171, 1.0),
      Color.fromRGBO(182, 104, 154, 1.0),
      Color.fromRGBO(79, 184, 137, 1.0),
      Color.fromRGBO(29, 44, 107, 1.0),
      Color.fromRGBO(144, 46, 46, 1.0),
      Color.fromRGBO(21, 32, 63, 1.0),
    ];

    const machines = <Tuple2<String, String>>[];
    const containers = <Tuple2<String, String>>[
      Tuple2("Create Container", createContainerPage),
    ];
    const images = <Tuple2<String, String>>[
      Tuple2("Local Images", localImageListPage),
      Tuple2("Search Images", remoteImageListPage),
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
                              backgroundColor: MaterialStateProperty.all(
                                  colors[Random().nextInt(colors.length)])),
                          onPressed: () => Get.toNamed(e.item2),
                          child: Text(e.item1),
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
                              backgroundColor: MaterialStateProperty.all(
                                  colors[Random().nextInt(colors.length)])),
                          onPressed: () => Get.toNamed(e.item2),
                          child: Text(e.item1),
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
                              backgroundColor: MaterialStateProperty.all(
                                  colors[Random().nextInt(colors.length)])),
                          onPressed: () => Get.toNamed(e.item2),
                          child: Text(e.item1),
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
