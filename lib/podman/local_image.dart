import 'dart:convert';

import 'dart:io';

class LocalImage {
  String? id;
  String? parentId;
  List<String>? repoTags;
  List<String>? repoDigests;
  int? size;
  int? sharedSize;
  int? virtualSize;
  Labels? labels;
  int? containers;
  List<String>? names;
  String? digest;
  List<String>? history;
  int? created;
  String? createdAt;

  LocalImage(
      {this.id,
      this.parentId,
      this.repoTags,
      this.repoDigests,
      this.size,
      this.sharedSize,
      this.virtualSize,
      this.labels,
      this.containers,
      this.names,
      this.digest,
      this.history,
      this.created,
      this.createdAt});

  LocalImage.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    parentId = json['ParentId'];
    repoTags = json['RepoTags'];
    repoDigests = json['RepoDigests'].cast<String>();
    size = json['Size'];
    sharedSize = json['SharedSize'];
    virtualSize = json['VirtualSize'];
    labels = json['Labels'] != null ? Labels.fromJson(json['Labels']) : null;
    containers = json['Containers'];
    names = json['Names'].cast<String>();
    digest = json['Digest'];
    history = json['History'].cast<String>();
    created = json['Created'];
    createdAt = json['CreatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['ParentId'] = parentId;
    data['RepoTags'] = repoTags;
    data['RepoDigests'] = repoDigests;
    data['Size'] = size;
    data['SharedSize'] = sharedSize;
    data['VirtualSize'] = virtualSize;
    if (labels != null) {
      data['Labels'] = labels!.toJson();
    }
    data['Containers'] = containers;
    data['Names'] = names;
    data['Digest'] = digest;
    data['History'] = history;
    data['Created'] = created;
    data['CreatedAt'] = createdAt;
    return data;
  }
}

class Labels {
  String? maintainer;

  Labels({this.maintainer});

  Labels.fromJson(Map<String, dynamic> json) {
    maintainer = json['maintainer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maintainer'] = maintainer;
    return data;
  }
}

List<LocalImage> getImages() {
  var result = Process.runSync("podman", ["image", "list", "--format", "json"]);
  var data = (json.decode(result.stdout) as List<dynamic>).map((element) {
    return LocalImage.fromJson(element);
  }).toList();
  return data;
}
