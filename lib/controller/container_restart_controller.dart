import 'package:get/get.dart';

class ContainerRestartController extends GetxController {
  List<String> options = ["no", "on-failure", "always"];
  String selectedOption = "no";

  void setSelectedOption(String option) {
    selectedOption = option;
    update();
  }
}
