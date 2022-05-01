// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:io';

import 'package:fodman/podman/config.dart';
import 'package:tuple/tuple.dart';

class Volume {
  String? name;
  String? driver;
  String? mountpoint;
  String? createdAt;
  Map<String, String>? labels;
  String? scope;
  int? mountCount;
  bool? needsCopyUp;
  bool? needsChown;

  Volume(
      {this.name,
      this.driver,
      this.mountpoint,
      this.createdAt,
      this.labels,
      this.scope,
      this.mountCount,
      this.needsCopyUp,
      this.needsChown});

  Volume.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    driver = json['Driver'];
    mountpoint = json['Mountpoint'];
    createdAt = json['CreatedAt'];
    labels = json['Labels'].cast<String, String>() ?? {};
    scope = json['Scope'];
    mountCount = json['MountCount'];
    needsCopyUp = json['NeedsCopyUp'];
    needsChown = json['NeedsChown'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Driver'] = driver;
    data['Mountpoint'] = mountpoint;
    data['CreatedAt'] = createdAt;
    data['Labels'] = labels;
    data['Scope'] = scope;
    data['MountCount'] = mountCount;
    data['NeedsCopyUp'] = needsCopyUp;
    data['NeedsChown'] = needsChown;
    return data;
  }
}

Future<Tuple2<String, String>> createVolume(
    String name, List<Tuple2<String, String>> labels) async {
  var args = <String>[];
  labels.forEach((element) {
    args.add('--label');
    args.add('${element.item1}=${element.item2}');
  });
  var result = await Process.run(
      podmanExec, ['volume', 'create', name, '--log-level', 'error', ...args],
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  return Tuple2(result.stdout.toString(), result.stderr.toString());
}

Future<Tuple2<String, String>> removeVolume(String name) async {
  var result = await Process.run(
      podmanExec, ['volume', 'rm', name, '--log-level', 'error'],
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  return Tuple2(result.stdout.toString(), result.stderr.toString());
}

Future<List<Volume>> getVolumes() async {
  var result = await Process.run(
      podmanExec, ["volume", "ls", "--format", "json", "--log-level", "error"],
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  return (json.decode(result.stdout) as List<dynamic>)
      .map((e) => Volume.fromJson(e))
      .toList();
}
