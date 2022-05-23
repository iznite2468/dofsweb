import 'package:dofsweb/blocs/disease/disease_bloc.dart' as disease;
import 'package:dofsweb/blocs/remedy/remedy_bloc.dart';
import 'package:dofsweb/models/remedy.dart';
import 'package:dofsweb/notifiers/symptoms_remedy_notifier.dart';
import 'package:dofsweb/screens/disease/add_disease_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AddRemedyPage extends StatelessWidget {
  AddRemedyPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final txtRemedy = TextEditingController();
  final txtDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SymptomsRemedyNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            BlocProvider.of<RemedyBloc>(context).add(LoadRemedies());
            Navigator.pop(context, true);
          },
        ),
        title: const Text('Add Remedy'),
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
                    child: bloc.loadingDiseases
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                            ],
                          )
                        : bloc.diseases.isEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [Text('No Diseases')],
                              )
                            : DropdownButtonFormField(
                                items: bloc.diseases
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e.diseaseName!),
                                          value: e.diseaseId,
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  bloc.selectedDisease = value;
                                },
                                value: bloc.selectedDisease,
                              ),
                  ),
                  const SizedBox(width: 20),
                  TextButton.icon(
                    onPressed: bloc.loadingDiseases
                        ? null
                        : () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (_) => disease.DiseaseBloc(),
                                  child: AddDiseasePage(),
                                ),
                              ),
                            );
                            if (result) {
                              bloc.setLoadingDisease(true);
                              bloc.loadDiseases();
                            }
                          },
                    icon: const Icon(Icons.add_circle),
                    label: const Text('Add New Disease'),
                  )
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: txtRemedy,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                  label: Text('Remedy'),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Required field';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: txtDescription,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                  label: Text('Description'),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Required field';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              BlocConsumer<RemedyBloc, RemedyState>(
                listener: (context, state) {
                  if (state is Error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                  if (state is RemedyAdded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AddingRemedy) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return TextButton(
                    onPressed: bloc.loadingDiseases
                        ? null
                        : () {
                            if (!_formKey.currentState!.validate()) return;

                            final remedy = Remedy(
                              diseaseId: bloc.selectedDisease,
                              remedy: txtRemedy.text,
                              remedyDescription: txtDescription.text,
                            );

                            BlocProvider.of<RemedyBloc>(context)
                                .add(AddRemedy(remedy));
                          },
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'CREATE',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: TextButton.styleFrom(backgroundColor: Colors.green),
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
