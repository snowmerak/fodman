import 'package:get/get.dart';

class MemoryUnitController extends GetxController {
  var memoryUnit = "m";

  void setMemoryUnit(String unit) {
    memoryUnit = unit;
    update();
  }
}
