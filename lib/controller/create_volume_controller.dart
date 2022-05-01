// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:tuple/tuple.dart';
import 'package:fodman/podman/volume.dart' as podman;

class CreateVolumeController extends GetxController {
  List<Tuple2<String, String>> labels = [];

  void append() {
    labels.add(Tuple2("", ""));
    update();
  }

  void setAt(int index, String key, String value) {
    labels[index] = Tuple2(key, value);
    update();
  }

  void removeAt(int index) {
    labels.removeAt(index);
    update();
  }

  Future<Tuple2<String, String>> createVolume(
      String name, List<Tuple2<String, String>> labels) async {
    return await podman.createVolume(name, labels);
  }

  Future<Tuple2<String, String>> removeVolume(String name) async {
    return await podman.removeVolume(name);
  }
}
