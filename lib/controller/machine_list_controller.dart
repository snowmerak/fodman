// ignore_for_file: prefer_const_constructors

import 'package:fodman/podman/local_machine.dart' as podman;
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class MachineListController extends GetxController {
  List<podman.Machine> machines = [];

  Future<void> loadMachines() async {
    machines = await podman.getMachines();
    update();
  }

  Future<Tuple2<String, String>> useMachine(String name) async {
    for (var machine in machines) {
      if (machine.name == name) {
        continue;
      }
      if (machine.running ?? false) {
        var result = await podman.stopMachine(machine.name ?? "");
        if (result.item2.isNotEmpty) {
          return Tuple2(result.item1, result.item2);
        }
      }
    }
    var startResult = await podman.startMachine(name);
    if (startResult.item1.isEmpty) {
      return Tuple2(startResult.item1, startResult.item2);
    }
    var connectionResult = await podman.setConnectionDefault(name);
    if (connectionResult.isNotEmpty) {
      return Tuple2("", connectionResult);
    }
    return Tuple2("", "");
  }

  Future<Tuple2<String, String>> removeMachine(String name) async {
    var result = await podman.removeMachine(name);
    return result;
  }
}
