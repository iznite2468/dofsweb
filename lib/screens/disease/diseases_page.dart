import 'package:dofsweb/blocs/disease/disease_bloc.dart';
import 'package:dofsweb/screens/disease/add_disease_page.dart';
import 'package:dofsweb/screens/disease/edit_disease_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiseasePage extends StatefulWidget {
  const DiseasePage({Key? key}) : super(key: key);

  @override
  State<DiseasePage> createState() => _DiseasePageState();
}

class _DiseasePageState extends State<DiseasePage> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<DiseaseBloc>().add(LoadDiseases()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diseases'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<DiseaseBloc>(context),
                    child: AddDiseasePage(),
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
      body: BlocConsumer<DiseaseBloc, DiseaseState>(
        listener: (context, state) {
          if (state is Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          if (state is DeletingDisease) {
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
                            child: Text('Deleting Disease...'),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
          if (state is DiseaseDeleted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.read<DiseaseBloc>().add(LoadDiseases());
          }
        },
        builder: (context, state) {
          if (state is LoadingData) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DataLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: state.diseases.length,
              itemBuilder: (_, index) {
                final data = state.diseases[index];
                return Card(
                  elevation: 0.5,
                  child: ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text(
                                data.diseaseName!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              content: RichText(
                                text: TextSpan(
                                  text: 'Description\n\n',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: data.description,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    removeDisease(
                                      context,
                                      data.diseaseName!,
                                      data.diseaseId!,
                                    );
                                  },
                                  child: const Text('Delete'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                          value: BlocProvider.of<DiseaseBloc>(
                                              context),
                                          child: EditDiseasePage(),
                                        ),
                                        settings: RouteSettings(
                                          arguments: data,
                                        ),
                                      ),
                                    );
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
                      removeDisease(
                        context,
                        data.diseaseName!,
                        data.diseaseId!,
                      );
                    },
                    title: Text(data.diseaseName!),
                    subtitle: Text(data.description!),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                );
              },
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

  Future<void> removeDisease(
    BuildContext context,
    String diseaseName,
    int diseaseId,
  ) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(diseaseName),
            content: const Text(
              'Are you sure you want to delete this disease?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<DiseaseBloc>().add(DeleteDisease(diseaseId));
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
            ],
          );
        });
  }
}
