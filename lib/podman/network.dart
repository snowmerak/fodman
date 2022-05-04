import 'dart:convert';
import 'dart:io';

import 'package:tuple/tuple.dart';

class Network {
  String? name;
  String? id;
  String? driver;
  String? networkInterface;
  String? created;
  List<Subnets>? subnets;
  bool? ipv6Enabled;
  bool? internal;
  bool? dnsEnabled;
  IpamOptions? ipamOptions;

  Network(
      {this.name,
      this.id,
      this.driver,
      this.networkInterface,
      this.created,
      this.subnets,
      this.ipv6Enabled,
      this.internal,
      this.dnsEnabled,
      this.ipamOptions});

  Network.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    driver = json['driver'];
    networkInterface = json['network_interface'];
    created = json['created'];
    if (json['subnets'] != null) {
      subnets = <Subnets>[];
      json['subnets'].forEach((v) {
        subnets!.add(Subnets.fromJson(v));
      });
    }
    ipv6Enabled = json['ipv6_enabled'];
    internal = json['internal'];
    dnsEnabled = json['dns_enabled'];
    ipamOptions = json['ipam_options'] != null
        ? IpamOptions.fromJson(json['ipam_options'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['driver'] = driver;
    data['network_interface'] = networkInterface;
    data['created'] = created;
    if (subnets != null) {
      data['subnets'] = subnets!.map((v) => v.toJson()).toList();
    }
    data['ipv6_enabled'] = ipv6Enabled;
    data['internal'] = internal;
    data['dns_enabled'] = dnsEnabled;
    if (ipamOptions != null) {
      data['ipam_options'] = ipamOptions!.toJson();
    }
    return data;
  }
}

class Subnets {
  String? subnet;
  String? gateway;

  Subnets({this.subnet, this.gateway});

  Subnets.fromJson(Map<String, dynamic> json) {
    subnet = json['subnet'];
    gateway = json['gateway'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subnet'] = subnet;
    data['gateway'] = gateway;
    return data;
  }
}

class IpamOptions {
  String? driver;

  IpamOptions({this.driver});

  IpamOptions.fromJson(Map<String, dynamic> json) {
    driver = json['driver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['driver'] = driver;
    return data;
  }
}

Future<List<Network>> getNetworks() async {
  var result = await Process.run(
      "podman", ["network", "ls", "--format", "json", "--log-level", "error"],
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  return (json.decode(result.stdout) as List<dynamic>)
      .map((e) => Network.fromJson(e))
      .toList();
}

Future<Tuple2<String, String>> removeNetwork(String name) async {
  var result = await Process.run(
      "podman", ["network", "rm", name, "--log-level", "error"],
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  return Tuple2(result.stdout, result.stderr);
}

Future<Tuple2<String, String>> createNetwork(String name,
    {bool disableDNS = false,
    String driver = "bridge",
    List<String> gateways = const [],
    List<String> subnets = const [],
    bool ipv6Enabled = false,
    bool internal = false,
    String ipamDriver = "host-local",
    List<Tuple2<String, String>> labels = const []}) async {
  var args = <String>[];
  args.add("network");
  args.add("create");
  args.add(name);
  args.add("--driver");
  args.add(driver);
  if (disableDNS) {
    args.add("--disable-dns");
  }
  if (ipv6Enabled) {
    args.add("--ipv6");
  }
  if (internal) {
    args.add("--internal");
  }
  for (var subnet in subnets) {
    args.add("--subnet");
    args.add(subnet);
  }
  for (var gateway in gateways) {
    args.add("--gateway");
    args.add(gateway);
  }
  for (var label in labels) {
    args.add("--label");
    args.add("${label.item1}=${label.item2}");
  }
  var result = await Process.run("podman", args,
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  return Tuple2(result.stdout, result.stderr);
}
