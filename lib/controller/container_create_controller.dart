import 'package:fodman/podman/create_container.dart' as podman;
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class ContainerCreateController extends GetxController {
  String result = "";

  void setResult(String value) {
    result = value;
    update();
  }

  Future<Tuple2<String, String>> runContainer(String arg) async {
    var result = await podman.runContainer(arg);
    return Tuple2(result.item1, result.item2);
  }
}
