import 'package:fodman/podman/pod.dart' as podman;
import 'package:get/get.dart';

class PodListController extends GetxController {
  List<podman.Pod> pods = [];

  Future<void> loadPods() async {
    pods = await podman.getPods();
    update();
  }
}
