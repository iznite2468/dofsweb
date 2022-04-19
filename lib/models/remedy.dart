class Remedy {
  int? remedyId;
  int? diseaseId;
  String? remedy;
  String? remedyDescription;
  int? delStatus;
  String? diseaseName;
  String? description;

  Remedy(
      {this.remedyId,
      this.diseaseId,
      this.remedy,
      this.remedyDescription,
      this.delStatus,
      this.diseaseName,
      this.description});

  Remedy.fromJson(Map<String, dynamic> json) {
    remedyId = json['remedy_id'];
    diseaseId = json['disease_id'];
    remedy = json['remedy'];
    remedyDescription = json['remedy_description'];
    delStatus = json['del_status'];
    diseaseName = json['disease_name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['remedyId'] = remedyId;
    data['diseaseId'] = diseaseId;
    data['remedy'] = remedy;
    data['description'] = remedyDescription;
    return data;
  }

  static List<Remedy> fromList(List rawList) {
    var list = <Remedy>[];
    if (rawList.isEmpty) return list;

    for (var item in rawList) {
      list.add(Remedy.fromJson(item));
    }

    return list;
  }
}
