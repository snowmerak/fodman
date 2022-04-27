import 'dart:io';

import 'package:tuple/tuple.dart';

Future<Tuple2<String, String>> runContainer(String arg) async {
  var result = await Process.run("podman", [arg]);
  return Tuple2(result.stdout.toString(), result.stderr.toString());
}
