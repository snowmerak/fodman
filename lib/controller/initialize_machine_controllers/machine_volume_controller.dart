// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class MachineVolumeController extends GetxController {
  List<Tuple2<String, String>> volumes = [];

  void append() {
    volumes.add(Tuple2("", ""));
    update();
  }

  void setVolumeAt(int index, String src, String dst) {
    volumes[index] = Tuple2(src, dst);
    update();
  }

  void removeAt(int index) {
    volumes.removeAt(index);
    update();
  }
}
