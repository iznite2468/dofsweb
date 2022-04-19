import 'package:dofsweb/blocs/symptoms/symptoms_bloc.dart';
import 'package:dofsweb/models/symptom.dart';
import 'package:dofsweb/notifiers/symptoms_remedy_notifier.dart';
import 'package:dofsweb/screens/symptoms/add_symptom.dart';
import 'package:dofsweb/screens/symptoms/edit_symptoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SymptomsPage extends StatelessWidget {
  SymptomsPage({Key? key}) : super(key: key);

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text('Symptoms'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider(
                    create: (_) => SymptomsRemedyNotifier()..loadDiseases(),
                    child: BlocProvider.value(
                      value: BlocProvider.of<SymptomsBloc>(context),
                      child: AddSymptomPage(),
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: const Text(
              'Add New',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<SymptomsBloc, SymptomsState>(
        listener: (context, state) {
          if (state is Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is DeletingSymptom) {
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
                            child: Text('Deleting Symptoms...'),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
          if (state is SymptomDeleted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.read<SymptomsBloc>().add(LoadSymptoms());
          }
        },
        builder: (context, state) {
          if (state is LoadingSymptoms) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SymptomsLoaded) {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: state.symptoms.length,
                itemBuilder: (_, index) {
                  final data = state.symptoms[index];
                  return Card(
                    elevation: 0.5,
                    child: ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text(
                                  data.symptom!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                content: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Disease: ',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: data.diseaseName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Description\n\n',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: data.symptomDescription,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      removeSymptom(
                                        context,
                                        data.symptom!,
                                        data.symptomId!,
                                      );
                                    },
                                    child: const Text('Delete'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      editSymptom(context, data);
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
                        removeSymptom(
                          context,
                          data.symptom!,
                          data.symptomId!,
                        );
                      },
                      title: Text(data.symptom!),
                      subtitle: Text(data.symptomDescription!),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  );
                });
          } else {
            return const Center(
              child: Text('No Symptoms'),
            );
          }
        },
      ),
    );
  }

  Future<void> removeSymptom(
    BuildContext context,
    String symptom,
    int symptomId,
  ) async {
    await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(symptom),
            content: const Text(
              'Are you sure you want to delete this symptom?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<SymptomsBloc>().add(DeleteSymptom(symptomId));
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

  void editSymptom(BuildContext context, Symptom data) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => SymptomsRemedyNotifier()
            ..loadDiseases(
              isEdit: true,
              diseaseId: data.diseaseId,
            ),
          child: BlocProvider.value(
            value: BlocProvider.of<SymptomsBloc>(context),
            child: EditSymptomPage(),
          ),
        ),
        settings: RouteSettings(arguments: data),
      ),
    );
  }
}
