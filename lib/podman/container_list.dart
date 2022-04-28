class Container {
  bool? autoRemove;
  List<String>? command;
  String? createdAt;
  bool? exited;
  int? exitedAt;
  int? exitCode;
  String? id;
  String? image;
  String? imageID;
  bool? isInfra;
  List<String>? labels;
  List<String>? mounts;
  List<String>? names;
  List<String>? networks;
  int? pid;
  String? pod;
  String? podName;
  List<int>? ports;
  int? startedAt;
  String? state;
  String? status;
  int? created;

  Container(
      {this.autoRemove,
      this.command,
      this.createdAt,
      this.exited,
      this.exitedAt,
      this.exitCode,
      this.id,
      this.image,
      this.imageID,
      this.isInfra,
      this.labels,
      this.mounts,
      this.names,
      this.networks,
      this.pid,
      this.pod,
      this.podName,
      this.ports,
      this.startedAt,
      this.state,
      this.status,
      this.created});

  Container.fromJson(Map<String, dynamic> json) {
    autoRemove = json['AutoRemove'];
    command = json['Command'].cast<String>();
    createdAt = json['CreatedAt'];
    exited = json['Exited'];
    exitedAt = json['ExitedAt'];
    exitCode = json['ExitCode'];
    id = json['Id'];
    image = json['Image'];
    imageID = json['ImageID'];
    isInfra = json['IsInfra'];
    labels = json['Labels'];
    mounts = json['Mounts'].cast<String>();
    names = json['Names'].cast<String>();
    networks = json['Networks'];
    pid = json['Pid'];
    pod = json['Pod'];
    podName = json['PodName'];
    ports = json['Ports'];
    startedAt = json['StartedAt'];
    state = json['State'];
    status = json['Status'];
    created = json['Created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AutoRemove'] = autoRemove;
    data['Command'] = command;
    data['CreatedAt'] = createdAt;
    data['Exited'] = exited;
    data['ExitedAt'] = exitedAt;
    data['ExitCode'] = exitCode;
    data['Id'] = id;
    data['Image'] = image;
    data['ImageID'] = imageID;
    data['IsInfra'] = isInfra;
    data['Labels'] = labels;
    data['Mounts'] = mounts;
    data['Names'] = names;
    if (networks != null) {
      data['Networks'] = networks ?? <String>[];
    }
    data['Pid'] = pid;
    data['Pod'] = pod;
    data['PodName'] = podName;
    data['Ports'] = ports;
    data['StartedAt'] = startedAt;
    data['State'] = state;
    data['Status'] = status;
    data['Created'] = created;
    return data;
  }
}
