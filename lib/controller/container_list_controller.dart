import 'package:fodman/podman/container_list.dart' as podman;
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class ContainerListController extends GetxController {
  List<podman.Container> list = [];

  Future<void> loadContainers() async {
    list = await podman.getContainers();
    update();
  }

  Future<Tuple2<String, String>> startContainer(String name) async {
    var result = await podman.startContainer(name);
    loadContainers();
    return result;
  }

  Future<Tuple2<String, String>> stopContainer(String name) async {
    var result = await podman.stopContainer(name);
    loadContainers();
    return result;
  }

  Future<Tuple2<String, String>> removeContainer(String name) async {
    var result = await podman.stopContainer(name);
    if (result.item1.isNotEmpty) {
      result = await podman.removeContainer(name);
      loadContainers();
    }
    return result;
  }
}
