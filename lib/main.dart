// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fodman/pages/image_list.dart';
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
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => IndexPage()),
        GetPage(name: "/image_list", page: () => ImageListPage()),
      ],
    );
  }
}
