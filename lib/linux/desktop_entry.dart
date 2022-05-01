// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:tuple/tuple.dart';

Future<Tuple2<String, String>> createDesktopEntry() async {
  var cur = Directory.current.path + "/fodman";
  var content = [
    "[Desktop Entry]",
    "Encoding=UTF-8",
    "Version=1.0",
    "Type=Application",
    "Terminal=false",
    "Exec=$cur",
    "",
  ].join("\n");
  var dst = (Platform.environment["HOME"] ?? "/usr/local/bin") +
      "/.local/share/applications/fodman.desktop";
  try {
    var file = File(dst);
    await file.writeAsString(content, flush: true);
  } catch (e) {
    return Tuple2("", e.toString());
  }
  var result = await Process.run("chmod", ["+x", dst]);
  return Tuple2(result.stdout, result.stderr);
}
