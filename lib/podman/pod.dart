import 'dart:convert';
import 'dart:io';

import 'package:tuple/tuple.dart';

class Pod {
  String? cgroup;
  List<Map<String, dynamic>>? containers;
  String? created;
  String? id;
  String? infraId;
  String? name;
  String? namespace;
  List<String>? networks;
  String? status;
  Map<String, String>? labels;

  Pod(
      {this.cgroup,
      this.containers,
      this.created,
      this.id,
      this.infraId,
      this.name,
      this.namespace,
      this.networks,
      this.status,
      this.labels});

  Pod.fromJson(Map<String, dynamic> json) {
    cgroup = json['Cgroup'];
    containers = json['Containers']?.cast<Map<String, dynamic>>() ?? [];
    created = json['Created'];
    id = json['Id'];
    infraId = json['InfraId'];
    name = json['Name'];
    namespace = json['Namespace'];
    networks = json['Networks']?.cast<String>() ?? [];
    status = json['Status'];
    labels = json['Labels']?.cast<String, String>() ?? {};
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Cgroup'] = cgroup;
    data['Containers'] = containers;
    data['Created'] = created;
    data['Id'] = id;
    data['InfraId'] = infraId;
    data['Name'] = name;
    data['Namespace'] = namespace;
    if (networks != null) {
      data['Networks'] = networks!;
    }
    data['Status'] = status;
    if (labels != null) {
      data['Labels'] = labels!;
    }
    return data;
  }
}

Future<Tuple2<String, String>> createPod(
  String name, {
  List<Tuple2<String, String>> hosts = const [],
  double cpus = 0,
  List<Tuple2<String, String>> devices = const [],
  String? hostname,
  String? ip,
  String? ipv6,
  List<Tuple2<String, String>> labels = const [],
  String? macAddress,
  String networkMode = 'bridge',
  List<Tuple2<String, String>> ports = const [],
  List<Tuple2<String, String>> volumes = const [],
}) async {
  var args = <String>["pod", "create", "--log-level", "error"];
  if (hostname != null) {
    args.add("--hostname");
    args.add(hostname);
  }
  if (hosts.isNotEmpty) {
    args.add("--add-host");
    args.addAll(hosts.map((e) => "${e.item1}:${e.item2}"));
  }
  // if (cpus != 0) {
  //   args.add("--cpus");
  //   args.add("$cpus");
  // }
  if (devices.isNotEmpty) {
    args.add("--device");
    args.addAll(devices.map((e) => "${e.item1}:${e.item2}"));
  }
  if (ip != null) {
    args.add("--ip");
    args.add(ip);
  }
  if (ipv6 != null) {
    args.add("--ip6");
    args.add(ipv6);
  }
  if (macAddress != null) {
    args.add("--mac-address");
    args.add(macAddress);
  }
  if (networkMode != 'bridge') {
    args.add("--network");
    args.add(networkMode);
  }
  if (ports.isNotEmpty) {
    for (var element in ports) {
      args.add("--publish");
      args.add("${element.item1}:${element.item2}");
    }
  }
  if (volumes.isNotEmpty) {
    for (var element in volumes) {
      args.add("--volume");
      args.add("${element.item1}:${element.item2}");
    }
  }
  if (labels.isNotEmpty) {
    for (var element in labels) {
      args.add("--label");
      args.add("${element.item1}=${element.item2}");
    }
  }
  args.add("--name");
  args.add(name);
  var result = await Process.run("podman", args,
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  return Tuple2(result.stdout, result.stderr);
}

Future<List<Pod>> getPods() async {
  var args = <String>[
    "pod",
    "list",
    "--format",
    "json",
    "--log-level",
    "error"
  ];
  var result = await Process.run("podman", args,
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  return (json.decode(result.stdout) as List<dynamic>)
      .map((e) => Pod.fromJson(e))
      .toList();
}

Future<Tuple2<String, String>> removePod(String name) async {
  var args = ["pod", "rm", "--log-level", "error", name];
  var result = await Process.run("podman", args,
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  return Tuple2(result.stdout, result.stderr);
}
