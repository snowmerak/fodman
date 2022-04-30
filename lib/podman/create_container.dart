import 'dart:io';

import 'package:tuple/tuple.dart';

import 'config.dart';

Future<Tuple2<String, String>> runContainer(List<String> args) async {
  args = ["--log-level", "error", ...args];
  var result = await Process.run(podmanExec, args,
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  return Tuple2(result.stdout.toString(), result.stderr.toString());
}
