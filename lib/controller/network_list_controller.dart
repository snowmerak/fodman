import 'package:fodman/podman/network.dart' as podman;
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class NetworkListController extends GetxController {
  List<podman.Network> networks = [];

  Future<void> loadNetworks() async {
    networks = await podman.getNetworks();
    update();
  }

  Future<Tuple2<String, String>> removeNetwork(String name) async {
    var result = await podman.removeNetwork(name);
    return result;
  }
}
