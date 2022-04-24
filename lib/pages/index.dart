// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fodman/pages/local_image/local_image_list.dart';
import 'package:fodman/pages/remote_image/remote_image_list.dart';
import 'package:get/get.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Index'),
      ),
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  "Container",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              width: 32.0,
            ),
            Column(
              children: [
                Text(
                  "Image",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12.0,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        colors[Random().nextInt(colors.length)]),
                  ),
                  child: const Text('Local Images'),
                  onPressed: () => Get.toNamed(localImageListPage),
                ),
                SizedBox(
                  height: 12.0,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        colors[Random().nextInt(colors.length)]),
                  ),
                  child: const Text('Search Image'),
                  onPressed: () => Get.toNamed(remoteImageListPage),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
