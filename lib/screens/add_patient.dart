import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:dofsweb/blocs/patient_case/patient_case_bloc.dart';
import 'package:dofsweb/models/patient_info_data.dart';
import 'package:dofsweb/notifiers/patient_info_notifier.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AddPatient extends StatelessWidget {
  AddPatient({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  //patient info
  final txtPatientNo = TextEditingController();
  final txtFname = TextEditingController();
  final txtMname = TextEditingController();
  final txtLname = TextEditingController();
  final txtContactNumber = TextEditingController();
  final txtAge = TextEditingController();

  //patient address
  final txtAddressLine1 = TextEditingController();
  //final txtCoordinates = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PatientInfoNotifier>(context);
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          title: const Text('Patient'),
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
                      if (list[i][j] != null) {
                        valids.add(list[i]);
                      }
                    }
                  }

                  valids = valids.toSet().toList();

                  var datas = <PatientInfoData>[];

                  for (var x in valids) {
                    var addressLine1 = x[0];
                    var brgyId = int.tryParse(x[1].toString());
                    var fname = x[2];
                    var mname = x[3];
                    var lname = x[4];
                    var sex = x[5];
                    var civilStatus = x[6];
                    var contactNumber = x[7];
                    var age = int.tryParse(x[8].toString());
                    var patientNo = x[x.length - 1].toString();

                    var data = PatientInfoData(
                      addressLine1: addressLine1,
                      barangayId: brgyId,
                      patientFname: fname,
                      patientMname: mname,
                      patientLname: lname,
                      sex: sex,
                      civilStatus: civilStatus,
                      contactNumber: contactNumber,
                      age: age,
                      patientNo: patientNo,
                    );

                    datas.add(data);
                  }

                  context.read<PatientCaseBloc>().add(AddPatients(datas));
                }
              },
              icon: const Icon(Icons.add_box),
              label: const Text('Import CSV File'),
            ),
          ],
        ),
        body: BlocListener<PatientCaseBloc, PatientCaseState>(
          listener: (context, state) {
            if (state is AddingPatients) {
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
            if (state is PatientsAdded) {
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
                  const Text('Information'),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: txtPatientNo,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Patient No.',
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: txtFname,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'First Name',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required Field';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextFormField(
                          controller: txtMname,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Middle Name',
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextFormField(
                          controller: txtLname,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Surname',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required Field';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Sex',
                          ),
                          value: bloc.selectedGender,
                          items: bloc.genders
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            bloc.selectedGender = value;
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextFormField(
                          controller: txtAge,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Age',
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: false,
                            signed: false,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required Field';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: txtContactNumber,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Contact Number',
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Civil Status',
                          ),
                          value: bloc.selectedCivilStatus,
                          items: bloc.civilStatuses
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            bloc.selectedCivilStatus = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text('Address'),
                  const SizedBox(height: 15),
                  bloc.loadingBarangays
                      ? const Text('Loading Barangays...')
                      : bloc.barangays.isEmpty
                          ? const Text('Empty Barangays')
                          : DropdownButtonFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Barangay',
                              ),
                              value: bloc.selectedBarangay,
                              items: bloc.barangays
                                  .map(
                                    (e) => DropdownMenuItem(
                                      child: Text(e.barangayName!),
                                      value: e.barangayId,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                bloc.selectedBarangay = value;
                              },
                            ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: TextFormField(
                  //         controller: txtCoordinates,
                  //         decoration: const InputDecoration(
                  //           border: OutlineInputBorder(),
                  //           labelText: 'Coordinates',
                  //           hintText: 'eg. 12345.6789, 9541.1235',
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 15),

                  //   ],
                  // ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: txtAddressLine1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address Line 1',
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 15),
                  bloc.addingPatientInfo
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                          ],
                        )
                      : TextButton(
                          onPressed: bloc.loadingBarangays
                              ? null
                              : () {
                                  if (!_formKey.currentState!.validate())
                                    return;

                                  final data = PatientInfoData(
                                    addressLine1: txtAddressLine1.text,
                                    //coordinates: [txtCoordinates.text].toString(),
                                    barangayId: bloc.selectedBarangay,
                                    patientFname: txtFname.text,
                                    patientMname: txtMname.text,
                                    patientLname: txtLname.text,
                                    sex: bloc.selectedGender == 'Male'
                                        ? 'M'
                                        : bloc.selectedGender == 'Female'
                                            ? 'F'
                                            : '',
                                    civilStatus: bloc.selectedCivilStatus,
                                    contactNumber: txtContactNumber.text,
                                    age: int.tryParse(txtAge.text),
                                    patientNo: txtPatientNo.text,
                                  );

                                  bloc.addPatient(data, context);
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
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
