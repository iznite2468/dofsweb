import 'package:dofsweb/blocs/disease/disease_bloc.dart';
import 'package:dofsweb/models/disease.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDiseasePage extends StatelessWidget {
  AddDiseasePage({Key? key}) : super(key: key);

  final txtDiseaseName = TextEditingController();
  final txtDescription = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<DiseaseBloc>(context).add(LoadDiseases());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              BlocProvider.of<DiseaseBloc>(context).add(LoadDiseases());
              Navigator.pop(context, true);
            },
          ),
          title: const Text('Add Disease'),
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required field';
                    }
                    return null;
                  },
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
                    if (state is DiseaseAdded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AddingDisease) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return TextButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;

                        final disease = Disease(
                          diseaseName: txtDiseaseName.text,
                          description: txtDescription.text,
                        );

                        BlocProvider.of<DiseaseBloc>(context)
                            .add(AddDisease(disease));
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
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.green),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
