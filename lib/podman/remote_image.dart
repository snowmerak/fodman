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
