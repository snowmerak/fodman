// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class MountListController extends GetxController {
  List<Tuple2<String, String>> volumes = [];
  List<Tuple2<String, String>> binds = [];

  void appendVolume() {
    volumes.add(Tuple2("", ""));
    update();
  }

  void appendBind() {
    binds.add(Tuple2("", ""));
    update();
  }

  void setVolumeAt(int index, String host, String container) {
    volumes[index] = Tuple2(host, container);
    update();
  }

  void setBindAt(int index, String host, String container) {
    binds[index] = Tuple2(host, container);
    update();
  }

  void removeVolumeAt(int index) {
    volumes.removeAt(index);
    update();
  }

  void removeBindAt(int index) {
    binds.removeAt(index);
    update();
  }
}
