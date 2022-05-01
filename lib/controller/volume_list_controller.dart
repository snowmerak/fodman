import 'package:fodman/podman/volume.dart' as podman;
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class VolumeListController extends GetxController {
  List<podman.Volume> list = [];

  Future<void> loadVolumes() async {
    list = await podman.getVolumes();
    update();
  }

  Future<Tuple2<String, String>> removeVolume(String name) async {
    return await podman.removeVolume(name);
  }
}
