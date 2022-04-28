// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class ContainerEnvironmentController extends GetxController {
  List<Tuple2<String, String>> envs = [];

  void append() {
    envs.add(Tuple2("", ""));
    update();
  }

  void setEnvAt(int index, String key, String value) {
    envs[index] = Tuple2(key, value);
    update();
  }

  void removeAt(int index) {
    envs.removeAt(index);
    update();
  }
}
