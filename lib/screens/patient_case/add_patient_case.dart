import 'package:dofsweb/blocs/disease/disease_bloc.dart';
import 'package:dofsweb/models/patient_case_data.dart';
import 'package:dofsweb/notifiers/patient_case_notifier.dart';
import 'package:dofsweb/notifiers/patient_info_notifier.dart';
import 'package:dofsweb/screens/add_patient.dart';
import 'package:dofsweb/screens/disease/add_disease_page.dart';
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
        ),
        body: Padding(
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
                                    child: AddPatient(),
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
                                    create: (_) => DiseaseBloc(),
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
                TextFormField(
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
                                if (!_formKey.currentState!.validate()) return;
                                

                                final data = PatientCaseData(
                                  diseaseId: bloc.selectedDiseaseId,
                                  patientId: bloc.selectedPatientId,
                                  caseClassification:
                                      txtCaseClassification.text,
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
    );
  }
}
