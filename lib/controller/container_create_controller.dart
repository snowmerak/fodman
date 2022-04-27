import 'package:get/get.dart';

class ContainerCreateController extends GetxController {
  String result = "";

  void setResult(String value) {
    result = value;
    update();
  }
}
