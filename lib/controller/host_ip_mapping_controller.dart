// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class HostIPMappingController extends GetxController {
  List<Tuple2<String, String>> list = [Tuple2("", "")];

  void append() {
    list.add(Tuple2("", ""));
    update();
  }

  void setAt(int index, String host, String ip) {
    list[index] = Tuple2(host, ip);
    update();
  }

  void removeAt(int index) {
    list.removeAt(index);
    update();
  }
}
