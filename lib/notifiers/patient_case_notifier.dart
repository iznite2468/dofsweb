import 'package:dofsweb/models/disease.dart';
import 'package:dofsweb/models/patient_case_data.dart';
import 'package:dofsweb/models/patient_info.dart';
import 'package:dofsweb/services/service_api.dart';
import 'package:flutter/material.dart';

class PatientCaseNotifier extends ChangeNotifier {
  final _api = ServiceApi();

  bool _dispose = false;
  bool _loadingPatientInfo = false;
  bool _loadingDiseases = false;
  bool _addingPatientCase = false;

  var patientInfo = <PatientInfo>[];
  var diseases = <Disease>[];

  late int _selectedPatientId;
  late int _selectedDiseaseId;
  late String _selectedCaseClassification;

  bool get loadingPatientInfo => _loadingPatientInfo;
  bool get loadingDiseases => _loadingDiseases;
  bool get addingPatientCase => _addingPatientCase;

  int get selectedPatientId => _selectedPatientId;
  int get selectedDiseaseId => _selectedDiseaseId;
  String get selectedCaseClassification => _selectedCaseClassification;

  set selectedPatientId(value) {
    _selectedPatientId = value;
    notifyListeners();
  }

  set selectedDiseaseId(value) {
    _selectedDiseaseId = value;
    notifyListeners();
  }

  set selectedCaseClassification(value) {
    _selectedCaseClassification = value;
    notifyListeners();
  }

  List<DropdownMenuItem<String>> rabiesDengueClassification = const [
    DropdownMenuItem<String>(
      child: Text('Suspected'),
      value: 'suspected',
    ),
    DropdownMenuItem<String>(
      child: Text('Probable'),
      value: 'probable',
    ),
    DropdownMenuItem<String>(
      child: Text('Confirmed'),
      value: 'confirmed',
    ),
  ];

  List<DropdownMenuItem<String>> tbClassification = const [
    DropdownMenuItem<String>(
      child: Text('Pulmonary'),
      value: 'pulmonary',
    ),
    DropdownMenuItem<String>(
      child: Text('Extra Pulmonary'),
      value: 'extra_pulmonary',
    ),
  ];

  void initPatientInfo() async {
    _loadingPatientInfo = true;
    final result = await _api.getPatients();
    if (result.data['success']) {
      patientInfo = PatientInfo.fromList(result.data['payload']);
      patientInfo.sort((a, b) => b.patientInfoId!.compareTo(a.patientInfoId!));
      _selectedPatientId = patientInfo.first.patientInfoId!;
      _loadingPatientInfo = false;
    } else {
      _loadingPatientInfo = false;
    }
    notifyListeners();
  }

  void initDiseases({bool isEdit = false, int? diseaseId}) async {
    _loadingDiseases = true;
    final result = await _api.getDiseases();
    if (result.data['success']) {
      diseases = Disease.fromList(result.data['payload']);

      if (isEdit) {
        if (diseases
            .where((element) => element.diseaseId == diseaseId)
            .isEmpty) {
          _selectedDiseaseId = diseases.first.diseaseId!;
          selectCaseClassification(_selectedDiseaseId);
        } else {
          _selectedDiseaseId = diseaseId!;
          selectCaseClassification(_selectedDiseaseId);
        }
      } else {
        _selectedDiseaseId = diseases.first.diseaseId!;
        selectCaseClassification(_selectedDiseaseId);
      }

      _loadingDiseases = false;
    } else {
      _loadingDiseases = false;
    }
    notifyListeners();
  }

  void addPatientCase(PatientCaseData data, BuildContext context) async {
    setAddingPatientCase(true);
    final result = await _api.addPatientCase(data);
    if (result.data['success']) {
      setAddingPatientCase(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.data['message']),
        ),
      );
    } else {
      setAddingPatientCase(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.data.toString()),
        ),
      );
    }
    notifyListeners();
  }

  void setLoadingPatientInfo(bool value) {
    _loadingPatientInfo = value;
    notifyListeners();
  }

  void setLoadingDisease(bool value) {
    _loadingDiseases = value;
    notifyListeners();
  }

  void setAddingPatientCase(bool value) {
    _addingPatientCase = value;
    notifyListeners();
  }

  void selectCaseClassification(int diseaesId) {
    switch (_selectedDiseaseId) {
      case 1:
        _selectedCaseClassification = rabiesDengueClassification.first.value!;
        break;
      case 2:
        _selectedCaseClassification = rabiesDengueClassification.first.value!;
        break;
      case 3:
        _selectedCaseClassification = tbClassification.first.value!;
        break;
    }
  }

  @override
  void notifyListeners() {
    if (!_dispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _dispose = true;
    super.dispose();
  }
}
