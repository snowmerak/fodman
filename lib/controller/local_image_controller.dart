// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fodman/podman/local_image.dart';
import 'package:get/get.dart';

class LocalImageController extends GetxController {
  Map<String, LocalImage> images = {};
  List<String> imagesKeys = [];
  LocalImage? selectedImage;
  String? errorTitle;
  String? errorMessage;

  Future<void> loadImages() async {
    getImages().then((resp) {
      images = {};
      for (var img in resp) {
        var withOutTag = img.names!.first.split(":").first;
        images[withOutTag] = img;
      }
      imagesKeys = images.keys.toList();
      update();
    }).onError((error, stackTrace) {
      errorTitle = error.toString();
      errorMessage = stackTrace.toString();
      update();
    });
  }
}
