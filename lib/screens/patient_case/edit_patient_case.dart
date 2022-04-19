import 'package:async/async.dart';
import 'package:dofsweb/blocs/disease/disease_bloc.dart' as disease;
import 'package:dofsweb/blocs/patient_case/patient_case_bloc.dart';
import 'package:dofsweb/models/patient_case.dart';
import 'package:dofsweb/models/patient_case_data.dart';
import 'package:dofsweb/notifiers/patient_case_notifier.dart';
import 'package:dofsweb/notifiers/patient_info_notifier.dart';
import 'package:dofsweb/screens/add_patient.dart';
import 'package:dofsweb/screens/disease/add_disease_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditPatientCasePage extends StatelessWidget {
  EditPatientCasePage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final txtPatientName = TextEditingController();
  final txtCaseClassification = TextEditingController();
  final txtDateOnset = TextEditingController();
  final txtDateAdmission = TextEditingController();

  final memoizer = AsyncMemoizer();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PatientCaseNotifier>(context);
    var patientCase = ModalRoute.of(context)!.settings.arguments as PatientCase;

    memoizer.runOnce(() {
      txtPatientName.text = patientCase.fullName();
      txtCaseClassification.text = patientCase.caseClassification!;
      txtDateOnset.text = DateFormat('yyyy-MM-dd')
          .format(DateTime.tryParse(patientCase.dateOnset!)!);
      if (patientCase.dateAdmission != null) {
        txtDateAdmission.text = DateFormat('yyyy-MM-dd')
            .format(DateTime.tryParse(patientCase.dateAdmission!)!);
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<PatientCaseBloc>().add(LoadPatientCases());
            Navigator.pop(context);
          },
        ),
        title: const Text('Update Patient Case'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                enabled: false,
                controller: txtPatientName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Patient",
                ),
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
              BlocConsumer<PatientCaseBloc, PatientCaseState>(
                listener: (context, state) {
                  if (state is Error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                  if (state is PatientCaseUpdated) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UpdatingPatientCase) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    );
                  }
                  return TextButton(
                    onPressed: bloc.loadingDiseases || bloc.loadingPatientInfo
                        ? null
                        : () {
                            if (!_formKey.currentState!.validate()) return;

                            final data = PatientCaseData(
                              formId: patientCase.formId,
                              diseaseId: bloc.selectedDiseaseId,
                              caseClassification: txtCaseClassification.text,
                              dateOnSet: DateTime.tryParse(txtDateOnset.text),
                              dateAdmission: txtDateAdmission.text.isEmpty
                                  ? null
                                  : DateTime.tryParse(
                                      txtDateAdmission.text,
                                    ),
                            );

                            context
                                .read<PatientCaseBloc>()
                                .add(UpdatePatientCase(data));
                          },
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'UPDATE',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
