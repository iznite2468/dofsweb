import 'package:dofsweb/blocs/remedy/remedy_bloc.dart';
import 'package:dofsweb/models/remedy.dart';
import 'package:dofsweb/notifiers/symptoms_remedy_notifier.dart';
import 'package:dofsweb/screens/remedy/add_remedy.dart';
import 'package:dofsweb/screens/remedy/edit_remedy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class RemedyPage extends StatelessWidget {
  RemedyPage({Key? key}) : super(key: key);

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text('Remedy'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider(
                    create: (_) => SymptomsRemedyNotifier()..loadDiseases(),
                    child: BlocProvider.value(
                      value: BlocProvider.of<RemedyBloc>(context),
                      child: AddRemedyPage(),
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
      body: BlocConsumer<RemedyBloc, RemedyState>(
        listener: (context, state) {
          if (state is Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is DeletingRemedy) {
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
                            child: Text('Deleting Remedy...'),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
          if (state is RemedyDeleted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.read<RemedyBloc>().add(LoadRemedies());
          }
        },
        builder: (context, state) {
          if (state is LoadingRemedies) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RemediesLoaded) {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: state.remedies.length,
                itemBuilder: (_, index) {
                  final data = state.remedies[index];
                  return Card(
                    elevation: 0.5,
                    child: ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text(
                                  data.remedy!,
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
                                            text: data.remedyDescription,
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
                                        data.remedy!,
                                        data.remedyId!,
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
                          data.remedy!,
                          data.remedyId!,
                        );
                      },
                      title: Text(data.remedy!),
                      subtitle: Text(data.remedyDescription!),
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
    String remedy,
    int remedyId,
  ) async {
    await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(remedy),
            content: const Text(
              'Are you sure you want to delete this remedy?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<RemedyBloc>().add(DeleteRemedy(remedyId));
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

  void editSymptom(BuildContext context, Remedy data) {
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
            value: BlocProvider.of<RemedyBloc>(context),
            child: EditRemedyPage(),
          ),
        ),
        settings: RouteSettings(arguments: data),
      ),
    );
  }
}
