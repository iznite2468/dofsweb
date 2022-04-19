import 'package:dofsweb/blocs/disease/disease_bloc.dart' as disease;
import 'package:dofsweb/blocs/home/home_bloc.dart';
import 'package:dofsweb/blocs/login/login_bloc.dart';
import 'package:dofsweb/blocs/patient_case/patient_case_bloc.dart'
    as patient_case;
import 'package:dofsweb/blocs/remedy/remedy_bloc.dart' as remedy;
import 'package:dofsweb/blocs/symptoms/symptoms_bloc.dart' as symptoms;
import 'package:dofsweb/blocs/users/users_bloc.dart' as users;
import 'package:dofsweb/models/pivot_result.dart';
import 'package:dofsweb/models/user_preferences.dart';
import 'package:dofsweb/screens/disease/diseases_page.dart';
import 'package:dofsweb/screens/remedy/remedy.dart';
import 'package:dofsweb/screens/symptoms/symptoms.dart';
import 'package:dofsweb/screens/users/users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'login_page.dart';
import 'patient_case/patient_case_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.microtask(() => context.read<HomeBloc>().add(LoadPivotResult()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as UserPreferences;

    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is SigningOut) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Row(
                    children: const [
                      CircularProgressIndicator(),
                      Expanded(
                        child: Text('Signing Out...'),
                      )
                    ],
                  ),
                );
              });
        }
        if (state is SignedOut) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => LoginBloc(),
                child: LoginPage(),
              ),
            ),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          elevation: 1,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Center(
                child: Text(
                  'Hello, ${data.username}!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                      right: 10,
                      top: 10,
                    ),
                    child: Text('Doctor DOFS Admin'),
                  ),
                ),
              ),
              // ListTile(
              //   onTap: () {},
              //   title: Text('Dashboard'),
              //   leading: Icon(Icons.home),
              // ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => patient_case.PatientCaseBloc()
                          ..add(patient_case.LoadPatientCases()),
                        child: const PatientCasePage(),
                      ),
                    ),
                  );
                },
                title: const Text('Patient Cases'),
                leading: const Icon(Icons.groups),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => symptoms.SymptomsBloc()
                          ..add(symptoms.LoadSymptoms()),
                        child: SymptomsPage(),
                      ),
                    ),
                  );
                },
                title: const Text('Symptoms'),
                leading: const Icon(Icons.question_mark_rounded),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) =>
                            remedy.RemedyBloc()..add(remedy.LoadRemedies()),
                        child: RemedyPage(),
                      ),
                    ),
                  );
                },
                title: const Text('Remedy'),
                leading: const Icon(Icons.bookmark_add),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => disease.DiseaseBloc(),
                        child: const DiseasePage(),
                      ),
                    ),
                  );
                },
                title: const Text('Diseases'),
                leading: const Icon(Icons.info),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => users.UsersBloc(),
                        child: const UsersPage(),
                      ),
                    ),
                  );
                },
                title: const Text('Users'),
                leading: const Icon(Icons.group),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text('Confirm Signout'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<HomeBloc>().add(LogoutUser());
                                Navigator.pop(context);
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        );
                      });
                },
                title: const Text('Sign Out'),
                leading: const Icon(Icons.logout),
              ),
            ],
          ),
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is Error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingPivotResult) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PivotResultLoaded) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(text: 'Forecasting'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  enableAxisAnimation: true,
                  series: <ChartSeries<PivotResult, String>>[
                    LineSeries(
                      width: 4,
                      dataSource: state.pivotResult,
                      xValueMapper: (PivotResult result, _) =>
                          DateFormat('MM-dd-yyyy')
                              .format(DateTime.tryParse(result.quarter!)!)
                              .toString(),
                      yValueMapper: (PivotResult result, _) =>
                          result.tuberculosis!,
                      legendIconType: LegendIconType.diamond,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      legendItemText: 'TUBERCULOSIS',
                    ),
                    LineSeries(
                      width: 4,
                      dataSource: state.pivotResult,
                      xValueMapper: (PivotResult result, _) =>
                          DateFormat('MM-dd-yyyy')
                              .format(DateTime.tryParse(result.quarter!)!)
                              .toString(),
                      yValueMapper: (PivotResult result, _) => result.rabies!,
                      legendIconType: LegendIconType.diamond,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      legendItemText: 'RABIES',
                    ),
                    LineSeries(
                      width: 4,
                      dataSource: state.pivotResult,
                      xValueMapper: (PivotResult result, _) =>
                          DateFormat('MM-dd-yyyy')
                              .format(DateTime.tryParse(result.quarter!)!)
                              .toString(),
                      yValueMapper: (PivotResult result, _) => result.dengue!,
                      legendIconType: LegendIconType.diamond,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      legendItemText: 'DENGUE',
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('Empty Pivot Results'),
              );
            }
          },
        ),
      ),
    );
  }
}
