import 'dart:io';

import 'package:tuple/tuple.dart';

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
  if (cpus != 0) {
    args.add("--cpus");
    args.add("$cpus");
  }
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
    args.add("--publish");
    args.addAll(ports.map((e) => "${e.item1}:${e.item2}"));
  }
  if (volumes.isNotEmpty) {
    args.add("--volume");
    args.addAll(volumes.map((e) => "${e.item1}:${e.item2}"));
  }
  if (labels.isNotEmpty) {
    args.add("--label");
    args.addAll(labels.map((e) => "${e.item1}=${e.item2}"));
  }
  args.add(name);
  var result = await Process.run("podman", args,
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  return Tuple2(result.stdout, result.stderr);
}
