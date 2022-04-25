import 'package:tuple/tuple.dart';

class Option {
  Map<String, String>? options;
  List<String>? o;
  String? uid;
  String? gid;

  Option({
    this.options = const {},
    this.o = const [],
    this.uid = "0777",
    this.gid = "0777",
  });
}

class Volume {
  String? driver;
  Map<String, String> labels;

  Volume({
    this.driver = "local",
    this.labels = const {},
  });
}

Future<Tuple2<String, String>> createVolume(Volume volume) {
  return Future.value(Tuple2("", ""));
}
