import 'package:fodman/podman/volume.dart' as podman;
import 'package:get/get.dart';

class VolumeListController extends GetxController {
  List<podman.Volume> list = [];

  Future<void> loadVolumes() async {
    list = await podman.getVolumes();
    update();
  }
}
