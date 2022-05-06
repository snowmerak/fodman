import 'package:fodman/podman/pod.dart' as podman;
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class PodListController extends GetxController {
  List<podman.Pod> pods = [];

  Future<void> loadPods() async {
    pods = await podman.getPods();
    update();
  }

  Future<Tuple2<String, String>> removePod(String name) async {
    var result = await podman.removePod(name);
    return result;
  }
}
