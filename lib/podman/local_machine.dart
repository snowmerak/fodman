import 'dart:convert';
import 'dart:io';

import 'package:channel/channel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class Machine {
  String? name;
  bool? defaults;
  String? created;
  bool? running;
  String? lastUp;
  String? stream;
  String? vMType;
  int? cPUs;
  String? memory;
  String? diskSize;
  int? port;
  String? remoteUsername;
  String? identityPath;

  Machine(
      {this.name,
      this.defaults,
      this.created,
      this.running,
      this.lastUp,
      this.stream,
      this.vMType,
      this.cPUs,
      this.memory,
      this.diskSize,
      this.port,
      this.remoteUsername,
      this.identityPath});

  Machine.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    defaults = json['Default'];
    created = json['Created'];
    running = json['Running'];
    lastUp = json['LastUp'];
    stream = json['Stream'];
    vMType = json['VMType'];
    cPUs = json['CPUs'];
    memory = json['Memory'];
    diskSize = json['DiskSize'];
    port = json['Port'];
    remoteUsername = json['RemoteUsername'];
    identityPath = json['IdentityPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Default'] = defaults;
    data['Created'] = created;
    data['Running'] = running;
    data['LastUp'] = lastUp;
    data['Stream'] = stream;
    data['VMType'] = vMType;
    data['CPUs'] = cPUs;
    data['Memory'] = memory;
    data['DiskSize'] = diskSize;
    data['Port'] = port;
    data['RemoteUsername'] = remoteUsername;
    data['IdentityPath'] = identityPath;
    return data;
  }
}

Future<List<Machine>> getMachines() async {
  var result = await Process.run(
      "podman", ["machine", "list", "--format", "json"],
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  return (json.decode(result.stdout) as List<dynamic>)
      .map((e) => Machine.fromJson(e))
      .toList();
}

Future<String> setConnectionDefault(String machineName) async {
  var result = await Process.run(
      "podman", ["system", "connection", "default", machineName],
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  return result.stderr.toString();
}

Future<Tuple2<String, String>> startMachine(String machineName) async {
  var result = await Process.start("podman", ["machine", "start", machineName],
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  var stdoutBuffer = StringBuffer();
  var stderrBuffer = StringBuffer();
  result.stdout.transform(utf8.decoder).listen((data) {
    stdoutBuffer.write(data);
  });
  result.stderr.transform(utf8.decoder).listen((data) {
    stderrBuffer.write(data);
  });
  await result.exitCode;
  return Tuple2(stdoutBuffer.toString(), stderrBuffer.toString());
}

Future<Tuple2<String, String>> stopMachine(String machineName) async {
  var result = await Process.run("podman", ["machine", "stop", machineName],
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  return Tuple2(result.stdout.toString(), result.stderr.toString());
}

Future<Tuple2<String, String>> removeMachine(String machineName) async {
  var result = await Process.start("podman", ["machine", "rm", machineName],
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  result.stdin.writeln("y");
  var channel = Channel<int>();
  var stdoutBuffer = <int>[];
  var stderrBuffer = <int>[];
  result.stdout
      .listen(
    (event) => stdoutBuffer.addAll(event),
  )
      .onDone(() {
    channel.send(1);
  });
  result.stderr
      .listen(
    (event) => stderrBuffer.addAll(event),
  )
      .onDone(() {
    channel.send(2);
  });
  await result.exitCode;
  await channel.receive();
  await channel.receive();
  return Tuple2(
      String.fromCharCodes(stdoutBuffer), String.fromCharCodes(stderrBuffer));
}

Future<Tuple2<String, String>> initMachine(String name, int cpus, int memory,
    int disks, List<Tuple2<String, String>> volumes) async {
  var args = [
    "machine",
    "init",
    name,
    "--cpus",
    cpus.toString(),
    "--memory",
    memory.toString(),
    "--disk-size",
    disks.toString(),
  ];
  for (var volume in volumes) {
    args.add("--volume");
    args.add(volume.item1);
    args.add(volume.item2);
  }
  var result = await Process.run("podman", args,
      workingDirectory: Platform.environment["HOME"], runInShell: true);
  return Tuple2(result.stdout.toString(), result.stderr.toString());
}
