// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fodman/pages/local_image/local_image_detail.dart';
import 'package:fodman/pages/local_image/local_image_list.dart';
import 'package:get/get.dart';

import 'pages/index.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "fodman",
      theme: ThemeData(
        fontFamily: "D2Coding",
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 1.35,
            ),
      ),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => IndexPage()),
        GetPage(name: localImageListPage, page: () => LocalImageListPage()),
        GetPage(name: localImageDetailPage, page: () => LocalImageDetailPage()),
      ],
    );
  }
}
