import 'dart:convert';
import 'dart:io';

class RemoteTag {
  String? name;
  List<String>? tags;

  RemoteTag({this.name, this.tags});

  RemoteTag.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    tags = json['Tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Tags'] = tags;
    return data;
  }
}

Future<List<RemoteTag>> searchTags(String image) async {
  var result = Process.runSync(
      "podman",
      [
        "search",
        image,
        "--list-tags",
        "--format",
        "json",
        "--log-level",
        "error"
      ],
      workingDirectory: Platform.environment["HOME"],
      runInShell: true);
  var data = (json.decode(result.stdout) as List<dynamic>).map((element) {
    return RemoteTag.fromJson(element);
  }).toList();
  return data;
}
