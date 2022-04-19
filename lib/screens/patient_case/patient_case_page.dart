import 'package:dofsweb/blocs/patient_case/patient_case_bloc.dart';
import 'package:dofsweb/models/patient_case.dart';
import 'package:dofsweb/notifiers/patient_case_notifier.dart';
import 'package:dofsweb/screens/patient_case/edit_patient_case.dart';
import 'package:dofsweb/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'add_patient_case.dart';

class PatientCasePage extends StatelessWidget {
  const PatientCasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Cases'),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: BlocConsumer<PatientCaseBloc, PatientCaseState>(
        listener: (context, state) {
          if (state is Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          if (state is DeletingPatientCase) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) {
                  return WillPopScope(
                    onWillPop: () async => false,
                    child: AlertDialog(
                      content: Row(
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text('Deleting Patient Case...'),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
          if (state is PatientCaseDeleted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.read<PatientCaseBloc>().add(LoadPatientCases());
          }
        },
        builder: (context, state) {
          if (state is LoadingData) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DataLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        left: 15,
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: 'Total Patient Case: ',
                          children: [
                            TextSpan(
                              text: '${state.patientCase.length}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        right: 15,
                      ),
                      child: IconButton(
                        onPressed: () async {
                          final result = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                create: (_) => PatientCaseNotifier()
                                  ..initPatientInfo()
                                  ..initDiseases(),
                                child: AddPatientCasePage(),
                              ),
                            ),
                          );

                          if (result) {
                            context
                                .read<PatientCaseBloc>()
                                .add(LoadPatientCases());
                          }
                        },
                        icon: const Icon(Icons.person_add),
                        iconSize: 30,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: state.patientCase.length,
                    itemBuilder: (context, index) {
                      final data = state.patientCase[index];

                      final dateOnSet = DateFormat('yyyy-MM-dd')
                          .format(DateTime.tryParse(data.dateOnset!)!);
                      return Card(
                        elevation: 0.5,
                        child: ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title:
                                        const Text('Patient Case Information'),
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomListTile(
                                          leading: 'Patient No.',
                                          data: data.patientNo!,
                                        ),
                                        CustomListTile(
                                          leading: 'Name of Patient',
                                          data: data.fullName(),
                                        ),
                                        CustomListTile(
                                          leading: 'Disease',
                                          data: data.diseaseName!,
                                        ),
                                        CustomListTile(
                                          leading: 'Age',
                                          data: data.age!.toString(),
                                        ),
                                        CustomListTile(
                                          leading: 'Sex',
                                          data: data.sex!,
                                        ),
                                        CustomListTile(
                                          leading: 'Location',
                                          data: data.barangayName ?? 'None',
                                        ),
                                        CustomListTile(
                                          leading: 'Date Onset',
                                          data: dateOnSet,
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          removePatientCase(
                                            context,
                                            data.formId!,
                                            data.fullName(),
                                          );
                                        },
                                        child: const Text('Delete'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          editPatientCase(context, data);
                                        },
                                        child: const Text('Edit'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          onLongPress: () {
                            removePatientCase(
                              context,
                              data.formId!,
                              data.fullName(),
                            );
                          },
                          title: Text(data.fullName()),
                          subtitle: Text(data.diseaseName!),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Empty List'),
            );
          }
        },
      ),
    );
  }

  Future<void> editPatientCase(BuildContext context, PatientCase data) async {
    Navigator.pop(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => PatientCaseNotifier()
            ..initDiseases(
              isEdit: true,
              diseaseId: data.diseaseId,
            ),
          child: BlocProvider.value(
            value: context.read<PatientCaseBloc>(),
            child: EditPatientCasePage(),
          ),
        ),
        settings: RouteSettings(arguments: data),
      ),
    );
  }

  void removePatientCase(
    BuildContext context,
    int formId,
    String patientName,
  ) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(patientName),
            content: const Text(
              'Are you sure you want to remove this patient case?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context
                      .read<PatientCaseBloc>()
                      .add(DeletePatientCase(formId));
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        });
  }
}
