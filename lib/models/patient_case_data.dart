class PatientCaseData {
  final int? diseaseId;
  final DateTime? dateOnSet;
  final DateTime? dateAdmission;
  final String? caseClassification;
  final int? patientId;
  final int? formId;

  PatientCaseData({
    this.diseaseId,
    this.dateOnSet,
    this.dateAdmission,
    this.caseClassification,
    this.patientId,
    this.formId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['diseaseId'] = diseaseId;
    data['dateOnSet'] = dateOnSet;
    data['dateAdmission'] = dateAdmission;
    data['caseClassification'] = caseClassification;
    data['patientId'] = patientId;
    data['formId'] = formId;
    return data;
  }

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['diseaseId'] = diseaseId;
    data['dateOnSet'] = dateOnSet;
    data['caseClassification'] = caseClassification;
    data['patientId'] = patientId;
    data['formId'] = formId;
    return data;
  }
}
