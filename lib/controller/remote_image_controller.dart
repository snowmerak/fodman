// ignore_for_file: prefer_const_constructors

import 'package:fodman/podman/remote_image.dart' as podman;
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class RemoteImageController extends GetxController {
  List<podman.RemoteImage> images = [];
  String? errorTitle;
  String? errorMessage;

  Future<void> loadImages(String name) async {
    podman.searchImage(name).then((resp) {
      images = resp;
      update();
    }).onError((error, stackTrace) {
      errorTitle = error.toString();
      errorMessage = stackTrace.toString();
      update();
    });
  }

  Future<Tuple2<String, String>> pullImage(String name, String tag) async {
    var result = await podman.pullImage(name, tag);
    return result;
  }
}
