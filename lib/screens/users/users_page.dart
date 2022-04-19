import 'package:dofsweb/blocs/users/users_bloc.dart';
import 'package:dofsweb/screens/users/edit_user_page.dart';
import 'package:dofsweb/screens/users/user_reset_password.dart';
import 'package:dofsweb/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<UsersBloc>().add(LoadUsers()),
    );
    super.initState();
  }

  Widget buildStatus(String status) {
    Color color = Colors.black;
    switch (status) {
      case 'ACTIVE':
        color = Colors.green;
        break;
      case 'PENDING':
        color = Colors.blueGrey[700]!;
        break;
      case 'ARCHIVED':
        color = Colors.red[400]!;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13.5,
        ),
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registered Users'),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: BlocConsumer<UsersBloc, UsersState>(
        listener: (context, state) {
          if (state is Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          if (state is UpdatingStatus) {
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
                            child: Text('Updating Status...'),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
          if (state is StatusUpdated) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            BlocProvider.of<UsersBloc>(context).add(LoadUsers());
          }
        },
        builder: (context, state) {
          if (state is LoadingData) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DataLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final data = state.users[index];
                return Card(
                  elevation: 0.5,
                  child: ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Text('User Information'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomListTile(
                                    leading: 'Name',
                                    data: data.fullName(),
                                  ),
                                  CustomListTile(
                                    leading: 'Username',
                                    data: data.username!,
                                  ),
                                  CustomListTile(
                                    leading: 'Email',
                                    data: data.email!,
                                  ),
                                  CustomListTile(
                                    leading: 'Contact No.',
                                    data: data.contactNumber ?? 'None',
                                  ),
                                  ListTile(
                                    leading: const Text(
                                      'Status :',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    title: Container(
                                      padding: const EdgeInsets.all(9),
                                      decoration: BoxDecoration(
                                        color: data.status! == 'ACTIVE'
                                            ? Colors.green
                                            : data.status! == 'PENDING'
                                                ? Colors.blueGrey[800]
                                                : data.status! == 'ARCHIVED'
                                                    ? Colors.red
                                                    : Colors.amberAccent[100],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        data.status! == 'ACTIVE'
                                            ? 'VERIFIED'
                                            : data.status!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    dense: true,
                                  ),
                                  CustomListTile(
                                    leading: 'Address',
                                    data: data.completeAddress ?? 'None',
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Close'),
                                ),
                                TextButton(
                                  onPressed: data.status! == 'ACTIVE'
                                      ? null
                                      : () {
                                          Navigator.pop(context);
                                          BlocProvider.of<UsersBloc>(context)
                                              .add(UpdateStatus('ACTIVE',
                                                  data.userAccessId!));
                                        },
                                  child: const Text('Activate'),
                                ),
                                TextButton(
                                  onPressed: data.status! == 'ARCHIVED'
                                      ? null
                                      : () {
                                          Navigator.pop(context);
                                          BlocProvider.of<UsersBloc>(context)
                                              .add(UpdateStatus('ARCHIVED',
                                                  data.userAccessId!));
                                        },
                                  child: const Text('Archive'),
                                ),
                                TextButton(
                                  onPressed: data.status! == 'ARCHIVED'
                                      ? null
                                      : () {
                                          Navigator.pop(context);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  BlocProvider.value(
                                                value:
                                                    BlocProvider.of<UsersBloc>(
                                                  context,
                                                ),
                                                child: UserResetPassword(),
                                              ),
                                              settings: RouteSettings(
                                                arguments: data.userAccessId,
                                              ),
                                            ),
                                          );
                                        },
                                  child: const Text('Reset Password'),
                                ),
                                TextButton(
                                  onPressed: data.status! == 'ARCHIVED'
                                      ? null
                                      : () {
                                          Navigator.pop(context);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  BlocProvider.value(
                                                value:
                                                    BlocProvider.of<UsersBloc>(
                                                  context,
                                                ),
                                                child: EditUserPage(),
                                              ),
                                              settings: RouteSettings(
                                                arguments: data,
                                              ),
                                            ),
                                          );
                                        },
                                  child: const Text('Edit'),
                                ),
                              ],
                            );
                          });
                    },
                    title: Text(data.fullName()),
                    subtitle: Text(data.email!),
                    trailing: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: data.status! == 'ACTIVE'
                            ? Colors.green
                            : data.status! == 'PENDING'
                                ? Colors.blueGrey[800]
                                : data.status! == 'ARCHIVED'
                                    ? Colors.red
                                    : Colors.amberAccent[100],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        data.status! == 'ACTIVE' ? 'VERIFIED' : data.status!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
}
