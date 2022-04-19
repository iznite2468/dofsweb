import 'package:dofsweb/blocs/users/users_bloc.dart';
import 'package:dofsweb/models/user_data.dart';
import 'package:dofsweb/models/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditUserPage extends StatelessWidget {
  EditUserPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final txtFullName = TextEditingController();
  final txtUsername = TextEditingController();
  final txtCompleteAddress = TextEditingController();
  final txtContactNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as UserInfo;

    txtFullName.text = args.fullName();
    txtUsername.text = args.username!;
    txtCompleteAddress.text = args.completeAddress ?? '';
    txtContactNumber.text = args.contactNumber ?? '';

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        BlocProvider.of<UsersBloc>(context).add(LoadUsers());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              BlocProvider.of<UsersBloc>(context).add(LoadUsers());
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('Edit User'),
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
                  controller: txtFullName,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                    label: Text('Name'),
                  ),
                  enabled: false,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: txtUsername,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                    label: Text('Username'),
                  ),
                  enabled: false,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: txtCompleteAddress,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                    label: Text('Complete Address'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required field';
                    }
                    return null;
                  },
                  maxLines: 3,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: txtContactNumber,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                    label: Text('Contact Number'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required field';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                BlocConsumer<UsersBloc, UsersState>(
                  listener: (context, state) {
                    if (state is Error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                    if (state is UserInfoUpdated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is UpdatingUserInfo) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return TextButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;

                        final userData = UserData(
                          userAccessId: args.userAccessId,
                          completeAddress: txtCompleteAddress.text,
                          contactNumber: txtContactNumber.text,
                        );

                        context.read<UsersBloc>().add(UpdateUserInfo(userData));
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
      ),
    );
  }
}
