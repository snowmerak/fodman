import 'package:fodman/podman/local_image.dart';
import 'package:get/get.dart';

class LocalImageController extends GetxController {
  Map<String, LocalImage> images = {};
  List<String> imagesKeys = [];
  LocalImage? selectedImage;

  Future<void> loadImages() async {
    var resp = getImages();
    images = {};
    for (var img in resp) {
      var withOutTag = img.names!.first.split(":").first;
      images[withOutTag] = img;
    }
    imagesKeys = images.keys.toList();
    update();
  }
}
