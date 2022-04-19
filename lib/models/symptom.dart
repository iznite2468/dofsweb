class Symptom {
  int? symptomId;
  int? diseaseId;
  String? symptom;
  String? symptomDescription;
  int? delStatus;
  String? diseaseName;
  String? description;

  Symptom(
      {this.symptomId,
      this.diseaseId,
      this.symptom,
      this.symptomDescription,
      this.delStatus,
      this.diseaseName,
      this.description});

  Symptom.fromJson(Map<String, dynamic> json) {
    symptomId = json['symptom_id'];
    diseaseId = json['disease_id'];
    symptom = json['symptom'];
    symptomDescription = json['symptom_description'];
    delStatus = json['del_status'];
    diseaseName = json['disease_name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symptomId'] = symptomId;
    data['diseaseId'] = diseaseId;
    data['symptom'] = symptom;
    data['description'] = symptomDescription;
    return data;
  }

  static List<Symptom> fromList(List rawList) {
    var list = <Symptom>[];
    if (rawList.isEmpty) return list;

    for (var item in rawList) {
      list.add(Symptom.fromJson(item));
    }

    return list;
  }
}
