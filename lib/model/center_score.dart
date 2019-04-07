class Centers {
  List<Center> centers;

  Centers({this.centers});

  Centers.fromJson(Map<String, dynamic> json) {
    if (json['leaders'] != null) {
      centers = new List<Center>();
      json['leaders'].forEach((v) {
        centers.add(new Center.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.centers != null) {
      data['leaders'] = this.centers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Center {
  NameWrapper nameWrapper;
  int totalscores;

  Center({this.nameWrapper, this.totalscores});

  Center.fromJson(Map<String, dynamic> json) {
    nameWrapper = json['_id'] != null ? new NameWrapper.fromJson(json['_id']) : null;
    totalscores = json['totalscores'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nameWrapper != null) {
      data['_id'] = this.nameWrapper.toJson();
    }
    data['totalscores'] = this.totalscores;
    return data;
  }
}

class NameWrapper {
  String center;

  NameWrapper({this.center});

  NameWrapper.fromJson(Map<String, dynamic> json) {
    center = json['center'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['center'] = this.center;
    return data;
  }
}