class Disease {
  int? diseaseId;
  String? diseaseName;
  String? description;

  Disease({this.diseaseId, this.diseaseName, this.description});

  Disease.fromJson(Map<String, dynamic> json) {
    diseaseId = json['disease_id'];
    diseaseName = json['disease_name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['disease_id'] = diseaseId;
    data['disease_name'] = diseaseName;
    data['description'] = description;
    return data;
  }

  static List<Disease> fromList(List rawList) {
    var list = <Disease>[];
    if (rawList.isEmpty) return list;

    for (var item in rawList) {
      list.add(Disease.fromJson(item));
    }

    return list;
  }
}
