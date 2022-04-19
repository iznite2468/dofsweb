class PatientInfoData {
  final String? addressLine1;
  final String? coordinates;
  final int? barangayId;
  final String? patientFname;
  final String? patientMname;
  final String? patientLname;
  final String? sex;
  final String? civilStatus;
  final String? contactNumber;
  final int? age;
  final String? patientNo;
  final int? patientInfoId;
  final int? addressId;

  PatientInfoData({
    this.addressLine1,
    this.coordinates,
    this.barangayId,
    this.patientFname,
    this.patientMname,
    this.patientLname,
    this.sex,
    this.civilStatus,
    this.contactNumber,
    this.age,
    this.patientNo,
    this.patientInfoId,
    this.addressId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addressLine1'] = addressLine1;
    data['coordinates'] = coordinates;
    data['barangayId'] = barangayId;
    data['patientFname'] = patientFname;
    data['patientMname'] = patientMname;
    data['patientLname'] = patientLname;
    data['sex'] = sex;
    data['civilStatus'] = civilStatus;
    data['contactNumber'] = contactNumber;
    data['age'] = age;
    data['patientNo'] = patientNo;
    data['patientInfoId'] = patientInfoId;
    data['addressId'] = addressId;
    return data;
  }
}
