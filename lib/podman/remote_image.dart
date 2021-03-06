import 'dart:convert';
import 'dart:io';

import 'package:fodman/podman/config.dart';
import 'package:tuple/tuple.dart';

class RemoteImage {
  String? index;
  String? name;
  String? description;
  int? stars;
  String? official;
  String? automated;
  String? tag;

  RemoteImage(
      {this.index,
      this.name,
      this.description,
      this.stars,
      this.official,
      this.automated,
      this.tag});

  RemoteImage.fromJson(Map<String, dynamic> json) {
    index = json['Index'];
    name = json['Name'];
    description = json['Description'];
    stars = json['Stars'];
    official = json['Official'];
    automated = json['Automated'];
    tag = json['Tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Index'] = index;
    data['Name'] = name;
    data['Description'] = description;
    data['Stars'] = stars;
    data['Official'] = official;
    data['Automated'] = automated;
    data['Tag'] = tag;
    return data;
  }
}

Future<List<RemoteImage>> searchImage(String keyword) async {
  var result = await Process.run(podmanExec,
      ["search", keyword, "--format", "json", "--log-level", "error"],
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  var data = (json.decode(result.stdout) as List<dynamic>).map((element) {
    return RemoteImage.fromJson(element);
  }).toList();
  data.sort((a, b) => (a.name ?? "").compareTo(b.name ?? ""));
  return data;
}

Future<Tuple2<String, String>> pullImage(String name, String tag) async {
  var result = await Process.run(
      podmanExec, ["image", "pull", "$name:$tag", "--log-level", "error"],
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  return Tuple2(result.stdout.toString(), result.stderr.toString());
}
