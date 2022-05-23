import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:dofsweb/blocs/disease/disease_bloc.dart' as disease;
import 'package:dofsweb/blocs/patient_case/patient_case_bloc.dart';
import 'package:dofsweb/helpers/constants.dart';
import 'package:dofsweb/models/patient_case_data.dart';
import 'package:dofsweb/notifiers/patient_case_notifier.dart';
import 'package:dofsweb/notifiers/patient_info_notifier.dart';
import 'package:dofsweb/screens/add_patient.dart';
import 'package:dofsweb/screens/disease/add_disease_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddPatientCasePage extends StatelessWidget {
  AddPatientCasePage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final txtCaseClassification = TextEditingController();
  final txtDateOnset = TextEditingController();
  final txtDateAdmission = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PatientCaseNotifier>(context);

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          title: const Text('Add Patient Case'),
          actions: [
            TextButton.icon(
              onPressed: () async {
                var result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['csv'],
                );

                if (result != null) {
                  var decoded = utf8.decode(result.files.first.bytes!);

                  var list = const CsvToListConverter().convert(decoded);

                  List valids = [];

                  for (var i = 0; i < list.length; i++) {
                    for (var j = 0; j < list[i].length; j++) {
                      //print(list[i][j]);
                      if (list[i][j] != null) {
                        valids.add(list[i]);
                      }
                    }
                  }

                  valids = valids.toSet().toList();

                  //m d y
                  //y m d

                  var datas = <PatientCaseData>[];
                  for (var x in valids) {
                    var data = PatientCaseData(
                      diseaseId: x[0],
                      dateOnSet: DateTime.tryParse(x[1]), //dateOnSet,
                      dateAdmission: DateTime.tryParse(x[2]), //dateAdmission,
                      caseClassification: x[3],
                      patientId: x[x.length - 1],
                    );
                    datas.add(data);
                  }

                  context.read<PatientCaseBloc>().add(AddPatientCases(datas));
                }
              },
              icon: const Icon(Icons.add_box),
              label: const Text('Import CSV File'),
            ),
          ],
        ),
        body: BlocListener<PatientCaseBloc, PatientCaseState>(
          listener: (context, state) {
            if (state is AddingPatientCases) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) {
                    return WillPopScope(
                      onWillPop: () async => false,
                      child: AlertDialog(
                        content: Row(
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(state.message),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            if (state is PatientCasesAdded) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is Error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: bloc.loadingPatientInfo
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CircularProgressIndicator(),
                                ],
                              )
                            : DropdownButtonFormField(
                                items: bloc.patientInfo
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e.fullName()),
                                          value: e.patientInfoId,
                                        ))
                                    .toList(),
                                value: bloc.selectedPatientId,
                                onChanged: (value) {
                                  bloc.selectedPatientId = value;
                                },
                              ),
                      ),
                      const SizedBox(width: 20),
                      TextButton.icon(
                        onPressed: bloc.loadingPatientInfo
                            ? null
                            : () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ChangeNotifierProvider(
                                      create: (_) =>
                                          PatientInfoNotifier()..loadData(),
                                      child: BlocProvider.value(
                                        value: context.read<PatientCaseBloc>(),
                                        child: AddPatient(),
                                      ),
                                    ),
                                  ),
                                );
                                if (result) {
                                  bloc.setLoadingPatientInfo(true);
                                  bloc.initPatientInfo();
                                }
                              },
                        icon: const Icon(Icons.add_circle),
                        label: const Text('Add New Patient'),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: bloc.loadingDiseases
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CircularProgressIndicator(),
                                ],
                              )
                            : DropdownButtonFormField(
                                items: bloc.diseases
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e.diseaseName!),
                                          value: e.diseaseId,
                                        ))
                                    .toList(),
                                value: bloc.selectedDiseaseId,
                                onChanged: (value) {
                                  bloc.selectedDiseaseId = value;
                                  bloc.selectCaseClassification(
                                      bloc.selectedDiseaseId);
                                },
                              ),
                      ),
                      const SizedBox(width: 20),
                      TextButton.icon(
                        onPressed: bloc.loadingDiseases
                            ? null
                            : () async {
                                final result = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                      create: (_) => disease.DiseaseBloc(),
                                      child: AddDiseasePage(),
                                    ),
                                  ),
                                );

                                if (result) {
                                  bloc.setLoadingDisease(true);
                                  bloc.initDiseases();
                                }
                              },
                        icon: const Icon(Icons.add_circle),
                        label: const Text('Add New Disease'),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  bloc.loadingDiseases
                      ? Container()
                      : bloc.selectedDiseaseId == 1 ||
                              bloc.selectedDiseaseId == 2
                          ? DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(),
                              ),
                              items: bloc.rabiesDengueClassification,
                              value: bloc.selectedCaseClassification,
                              onChanged: (value) {
                                bloc.selectedCaseClassification = value;
                              },
                            )
                          : bloc.selectedDiseaseId == 3
                              ? DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder(),
                                  ),
                                  items: bloc.tbClassification,
                                  value: bloc.selectedCaseClassification,
                                  onChanged: (value) {
                                    bloc.selectedCaseClassification = value;
                                  },
                                )
                              : TextFormField(
                                  controller: txtCaseClassification,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required Field';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Case Classification",
                                  ),
                                ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: txtDateOnset,
                    readOnly: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Required Field';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Date Onset",
                      suffixIcon: TextButton.icon(
                        onPressed: () async {
                          final result = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now().subtract(
                              const Duration(days: 5000),
                            ),
                            lastDate: DateTime.now(),
                          );
                          if (result != null) {
                            txtDateOnset.text =
                                DateFormat('yyyy-MM-dd').format(result);
                          }
                        },
                        icon: const Icon(Icons.calendar_month),
                        label: const Text('Select Date'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: txtDateAdmission,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Date Admission",
                      suffixIcon: TextButton.icon(
                        onPressed: () async {
                          final result = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now().subtract(
                              const Duration(days: 5000),
                            ),
                            lastDate: DateTime.now(),
                          );
                          if (result != null) {
                            txtDateAdmission.text =
                                DateFormat('yyyy-MM-dd').format(result);
                          }
                        },
                        icon: const Icon(Icons.calendar_month),
                        label: const Text('Select Date'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  bloc.addingPatientCase
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                          ],
                        )
                      : TextButton(
                          onPressed: bloc.loadingDiseases ||
                                  bloc.loadingPatientInfo
                              ? null
                              : () {
                                  if (!_formKey.currentState!.validate())
                                    return;

                                  final data = PatientCaseData(
                                    diseaseId: bloc.selectedDiseaseId,
                                    patientId: bloc.selectedPatientId,
                                    caseClassification:
                                        bloc.selectedCaseClassification,
                                    dateOnSet:
                                        DateTime.tryParse(txtDateOnset.text),
                                    dateAdmission: txtDateAdmission.text.isEmpty
                                        ? null
                                        : DateTime.tryParse(
                                            txtDateAdmission.text,
                                          ),
                                  );

                                  bloc.addPatientCase(data, context);
                                },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidDisease(int diseaseId) {
    return diseaseId == 1 || diseaseId == 2 || diseaseId == 3;
  }
}
