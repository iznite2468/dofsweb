import 'package:dofsweb/models/barangay.dart';
import 'package:dofsweb/models/patient_info_data.dart';
import 'package:dofsweb/services/service_api.dart';
import 'package:flutter/material.dart';

class PatientInfoNotifier extends ChangeNotifier {
  final _api = ServiceApi();

  bool _loadingBarangays = false;
  bool _addingPatientInfo = false;

  List<Barangay> _barangays = [];
  late int _selectedBarangay;

  final List<String> _genders = ['Male', 'Female'];
  late String _selectedGender;

  final List<String> _civilStatuses = [
    'None',
    'Single',
    'Married',
    'Divorced',
    'Widowed'
  ];
  late String _selectedCivilStatus;

  bool get loadingBarangays => _loadingBarangays;
  bool get addingPatientInfo => _addingPatientInfo;

  int get selectedBarangay => _selectedBarangay;
  List<Barangay> get barangays => _barangays;

  List<String> get genders => _genders;
  String get selectedGender => _selectedGender;

  List<String> get civilStatuses => _civilStatuses;
  String get selectedCivilStatus => _selectedCivilStatus;

  set selectedBarangay(value) {
    _selectedBarangay = value;
    notifyListeners();
  }

  set selectedGender(value) {
    _selectedGender = value;
    notifyListeners();
  }

  set selectedCivilStatus(value) {
    _selectedCivilStatus = value;
    notifyListeners();
  }

  void loadData() async {
    _loadingBarangays = true;

    _selectedGender = _genders.first;
    _selectedCivilStatus = _civilStatuses.first;

    final result = await _api.getBarangays();

    if (result.data['success']) {
      _barangays = Barangay.fromList(result.data['payload']);
      _barangays.sort((a, b) => a.barangayName!.compareTo(b.barangayName!));
      _selectedBarangay = _barangays.first.barangayId!;
      _loadingBarangays = false;
    } else {
      _loadingBarangays = false;
    }

    notifyListeners();
  }

  void addPatient(PatientInfoData data, BuildContext context) async {
    setAddingPatientInfo(true);
    final result = await _api.addPatient(data);
    if (result.data['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.data['message'])),
      );
      setAddingPatientInfo(false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.data.toString())),
      );
      setAddingPatientInfo(false);
    }
  }

  void setAddingPatientInfo(bool value) {
    _addingPatientInfo = value;
    notifyListeners();
  }
}
