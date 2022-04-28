// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fodman/pages/create_container/create_container.dart';
import 'package:fodman/pages/initialize_machine/initialize_machine.dart';
import 'package:fodman/pages/local_image/local_image_detail.dart';
import 'package:fodman/pages/local_image/local_image_list.dart';
import 'package:fodman/pages/local_machine/local_machine_list.dart';
import 'package:fodman/pages/remote_image/remote_image_list.dart';
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
              fontSizeFactor: 1.2,
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => IndexPage()),
        GetPage(name: localImageListPage, page: () => LocalImageListPage()),
        GetPage(name: localImageDetailPage, page: () => LocalImageDetailPage()),
        GetPage(name: remoteImageListPage, page: () => RemoteImageListPage()),
        GetPage(name: createContainerPage, page: () => CreateContainerPage()),
        GetPage(name: localMachineListPage, page: () => LocalMachineListPage()),
        GetPage(
            name: initializeMachinePage, page: () => InitializeMachinePage()),
      ],
    );
  }
}
