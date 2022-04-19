import 'package:dofsweb/blocs/disease/disease_bloc.dart';
import 'package:dofsweb/models/disease.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditDiseasePage extends StatelessWidget {
  EditDiseasePage({Key? key}) : super(key: key);

  final txtDiseaseName = TextEditingController();
  final txtDescription = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Disease;

    txtDiseaseName.text = args.diseaseName!;
    txtDescription.text = args.description!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            BlocProvider.of<DiseaseBloc>(context).add(LoadDiseases());
            Navigator.pop(context);
          },
        ),
        title: const Text('Edit Disease'),
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
                controller: txtDiseaseName,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                  label: Text('Disease Name'),
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
              ),
              const SizedBox(height: 15),
              BlocConsumer<DiseaseBloc, DiseaseState>(
                listener: (context, state) {
                  if (state is Error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                  if (state is DiseaseUpdated) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UpdatingDisease) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return TextButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;

                      final disease = Disease(
                        diseaseId: args.diseaseId,
                        diseaseName: txtDiseaseName.text,
                        description: txtDescription.text,
                      );

                      BlocProvider.of<DiseaseBloc>(context)
                          .add(UpdateDisease(disease));
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
