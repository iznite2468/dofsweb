import 'package:dofsweb/models/disease.dart';
import 'package:dofsweb/services/service_api.dart';
import 'package:flutter/material.dart';

class SymptomsRemedyNotifier extends ChangeNotifier {
  final _api = ServiceApi();

  var _diseases = <Disease>[];
  List<Disease> get diseases => _diseases;

  late int _selectedDisease;
  int get selectedDisease => _selectedDisease;
  set selectedDisease(value) {
    _selectedDisease = value;
    notifyListeners();
  }

  bool _loadingDiseases = false;
  bool get loadingDiseases => _loadingDiseases;

  void loadDiseases({bool isEdit = false, int? diseaseId}) async {
    _loadingDiseases = true;
    final response = await _api.getDiseases();
    if (response.data['success']) {
      _diseases = Disease.fromList(response.data['payload']);

      if (isEdit) {
        if (_diseases
            .where((element) => element.diseaseId == diseaseId)
            .isEmpty) {
          _selectedDisease = _diseases.first.diseaseId!;
        } else {
          _selectedDisease = diseaseId!;
        }
      } else {
        _selectedDisease = _diseases.first.diseaseId!;
      }
      _loadingDiseases = false;
    } else {
      _loadingDiseases = false;
    }
    notifyListeners();
  }

  void setLoadingDisease(bool value) {
    _loadingDiseases = value;
    notifyListeners();
  }
}
