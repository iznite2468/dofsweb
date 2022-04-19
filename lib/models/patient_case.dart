class PatientCase {
  int? formId;
  int? diseaseId;
  String? diseaseName;
  String? diseaseDescription;
  String? dateAdmission;
  String? dateOnset;
  String? caseClassification;
  int? delStatus;
  int? patientId;
  String? patientFname;
  String? patientMname;
  String? patientLname;
  String? sex;
  int? age;
  String? civilStatus;
  String? contactNumber;
  int? addressId;
  String? patientNo;
  String? addressLine1;
  String? coordinates;
  int? barangayId;
  String? barangayName;
  int? population;

  PatientCase(
      {this.formId,
      this.diseaseId,
      this.diseaseName,
      this.diseaseDescription,
      this.dateAdmission,
      this.dateOnset,
      this.caseClassification,
      this.delStatus,
      this.patientId,
      this.patientFname,
      this.patientMname,
      this.patientLname,
      this.sex,
      this.age,
      this.civilStatus,
      this.contactNumber,
      this.addressId,
      this.patientNo,
      this.addressLine1,
      this.coordinates,
      this.barangayId,
      this.barangayName,
      this.population});

  PatientCase.fromJson(Map<String, dynamic> json) {
    formId = json['form_id'];
    diseaseId = json['disease_id'];
    diseaseName = json['disease_name'];
    diseaseDescription = json['disease_description'];
    dateAdmission = json['date_admission'];
    dateOnset = json['date_onset'];
    caseClassification = json['case_classification'];
    delStatus = json['del_status'];
    patientId = json['patient_id'];
    patientFname = json['patient_fname'];
    patientMname = json['patient_mname'];
    patientLname = json['patient_lname'];
    sex = json['sex'];
    age = json['age'];
    civilStatus = json['civil_status'];
    contactNumber = json['contact_number'];
    addressId = json['address_id'];
    patientNo = json['patient_no'];
    addressLine1 = json['address_line1'];
    coordinates = json['coordinates'];
    barangayId = json['barangay_id'];
    barangayName = json['barangay_name'];
    population = json['population'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['form_id'] = formId;
    data['disease_id'] = diseaseId;
    data['disease_name'] = diseaseName;
    data['disease_description'] = diseaseDescription;
    data['date_admission'] = dateAdmission;
    data['date_onset'] = dateOnset;
    data['case_classification'] = caseClassification;
    data['del_status'] = delStatus;
    data['patient_id'] = patientId;
    data['patient_fname'] = patientFname;
    data['patient_mname'] = patientMname;
    data['patient_lname'] = patientLname;
    data['sex'] = sex;
    data['age'] = age;
    data['civil_status'] = civilStatus;
    data['contact_number'] = contactNumber;
    data['address_id'] = addressId;
    data['patient_no'] = patientNo;
    data['address_line1'] = addressLine1;
    data['coordinates'] = coordinates;
    data['barangay_id'] = barangayId;
    data['barangay_name'] = barangayName;
    data['population'] = population;
    return data;
  }

  static List<PatientCase> fromList(List<dynamic> data) {
    var list = <PatientCase>[];
    if (data.isEmpty) return list;

    for (var item in data) {
      list.add(PatientCase.fromJson(item));
    }

    return list;
  }

  String fullName() {
    if (patientMname != null) {
      return '$patientFname $patientMname $patientLname';
    } else {
      return '$patientFname $patientLname';
    }
  }
}
