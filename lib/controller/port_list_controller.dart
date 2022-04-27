// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class PortListController extends GetxController {
  List<Tuple2<String, String>> ports = [];

  void append() {
    ports.add(Tuple2("", ""));
    update();
  }

  void setPortAt(int index, String key, String value) {
    ports[index] = Tuple2(key, value);
    update();
  }

  void removeAt(int index) {
    ports.removeAt(index);
    update();
  }
}
