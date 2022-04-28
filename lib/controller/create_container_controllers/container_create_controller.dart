import 'package:fodman/podman/create_container.dart' as podman;
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class ContainerCreateController extends GetxController {
  List<String> result = [];

  void setResult(List<String> value) {
    result = value;
    update();
  }

  Future<Tuple2<String, String>> runContainer(List<String> args) async {
    var result = await podman.runContainer(args);
    return Tuple2(result.item1, result.item2);
  }
}
