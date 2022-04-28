// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class AnnotationController extends GetxController {
  List<Tuple2<String, String>> list = [];

  void append() {
    list.add(Tuple2("", ""));
    update();
  }

  void setAt(int index, String key, String value) {
    list[index] = Tuple2(key, value);
    update();
  }

  void removeAt(int index) {
    list.removeAt(index);
    update();
  }
}
