import 'package:dofsweb/blocs/users/users_bloc.dart';
import 'package:dofsweb/notifiers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class UserResetPassword extends StatelessWidget {
  UserResetPassword({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final txtNewPassword = TextEditingController();
  final txtConfirmNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userAccessId = ModalRoute.of(context)?.settings.arguments as int;
    final bloc = Provider.of<AuthNotifier>(context);

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
                  controller: txtNewPassword,
                  obscureText: !bloc.showNPassword,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    border: const OutlineInputBorder(),
                    label: const Text('New Password'),
                    suffixIcon: IconButton(
                      onPressed: () {
                        bloc.showNPassword = !bloc.showNPassword;
                      },
                      icon: bloc.showNPassword
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required Field';
                    }
                    if (value.trim().length < 6) {
                      return 'Password must be atleast six (6) characters above';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: txtConfirmNewPassword,
                  obscureText: !bloc.showNCPassword,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    border: const OutlineInputBorder(),
                    label: const Text('Confirm New Password'),
                    suffixIcon: IconButton(
                      onPressed: () {
                        bloc.showNCPassword = !bloc.showNCPassword;
                      },
                      icon: bloc.showNCPassword
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                  validator: (value) {
                    if (value != txtNewPassword.text) {
                      return 'Password does not match';
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
                    if (state is PasswordUpdated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message + '\nYou can close this screen now',
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is UpdatingPassword) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return TextButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;

                        BlocProvider.of<UsersBloc>(context).add(UpdatePassword(
                            txtConfirmNewPassword.text, userAccessId));
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
