class PatientInfo {
  int? patientInfoId;
  String? patientFname;
  String? patientMname;
  String? patientLname;
  String? sex;
  String? civilStatus;
  String? contactNumber;
  int? addressId;
  int? age;
  String? patientNo;

  PatientInfo(
      {this.patientInfoId,
      this.patientFname,
      this.patientMname,
      this.patientLname,
      this.sex,
      this.civilStatus,
      this.contactNumber,
      this.addressId,
      this.age,
      this.patientNo});

  PatientInfo.fromJson(Map<String, dynamic> json) {
    patientInfoId = json['patient_info_id'];
    patientFname = json['patient_fname'];
    patientMname = json['patient_mname'] ?? '';
    patientLname = json['patient_lname'];
    sex = json['sex'];
    civilStatus = json['civil_status'] ?? '';
    contactNumber = json['contact_number'] ?? '';
    addressId = json['address_id'];
    age = json['age'];
    patientNo = json['patient_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patient_info_id'] = patientInfoId;
    data['patient_fname'] = patientFname;
    data['patient_mname'] = patientMname;
    data['patient_lname'] = patientLname;
    data['sex'] = sex;
    data['civil_status'] = civilStatus;
    data['contact_number'] = contactNumber;
    data['address_id'] = addressId;
    data['age'] = age;
    data['patient_no'] = patientNo;
    return data;
  }

  static List<PatientInfo> fromList(List<dynamic> data) {
    var list = <PatientInfo>[];
    if (data.isEmpty) return list;

    for (var item in data) {
      list.add(PatientInfo.fromJson(item));
    }

    return list;
  }

  String fullName() {
    if (patientMname!.isNotEmpty) {
      return '$patientFname $patientMname $patientLname';
    } else {
      return '$patientFname $patientLname';
    }
  }
}
