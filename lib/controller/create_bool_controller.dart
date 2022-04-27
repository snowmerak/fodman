import 'package:get/get.dart';

class CreateOptionController extends GetxController {
  Map<String, bool> options = {
    "--rm": false,
    "--read-only": false,
    "--replace": false,
    "-t": false,
    "-i": false,
  };

  String autoRemove = "--rm";
  String readonly = "--read-only";
  String replace = "--replace";
  String tty = "-t";
  String interactive = "-i";

  List<String> keys = [
    "Auto Remove",
    "Readonly",
    "Replace",
    "TTY",
    "Interactive"
  ];

  void setOption(String key, bool value) {
    options[key] = value;
    update();
  }
}
