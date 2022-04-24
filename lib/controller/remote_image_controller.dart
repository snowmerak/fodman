// ignore_for_file: prefer_const_constructors

import 'package:fodman/podman/remote_image.dart';
import 'package:get/get.dart';

class RemoteImageController extends GetxController {
  List<RemoteImage> images = [];
  String? errorTitle;
  String? errorMessage;

  Future<void> loadImages(String name) async {
    searchImage(name).then((resp) {
      images = resp;
      update();
    }).onError((error, stackTrace) {
      errorTitle = error.toString();
      errorMessage = stackTrace.toString();
      update();
    });
  }
}
