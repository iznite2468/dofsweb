import 'package:dofsweb/models/patient_info_data.dart';
import 'package:dofsweb/notifiers/patient_info_notifier.dart';
import 'package:flutter/material.dart';
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
  final txtCoordinates = TextEditingController();

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
        ),
        body: Padding(
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
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: txtCoordinates,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Coordinates',
                          hintText: 'eg. 12345.6789, 9541.1235',
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
                      child: bloc.loadingBarangays
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
                    ),
                  ],
                ),
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
                                if (!_formKey.currentState!.validate()) return;

                                final data = PatientInfoData(
                                  addressLine1: txtAddressLine1.text,
                                  coordinates: [txtCoordinates.text].toString(),
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
    );
  }
}
