import 'package:get/get.dart';

class MachineSpecController extends GetxController {
  int cpus = 1;
  int memory = 2048;
  int disks = 100;

  void setCpus(int value) {
    cpus = value;
    update();
  }

  void setMemory(int value) {
    memory = value;
    update();
  }

  void setDisks(int value) {
    disks = value;
    update();
  }
}
