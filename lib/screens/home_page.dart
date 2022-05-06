import 'package:dofsweb/blocs/disease/disease_bloc.dart' as disease;
import 'package:dofsweb/blocs/home/home_bloc.dart';
import 'package:dofsweb/blocs/login/login_bloc.dart';
import 'package:dofsweb/blocs/patient_case/patient_case_bloc.dart'
    as patient_case;
import 'package:dofsweb/blocs/remedy/remedy_bloc.dart' as remedy;
import 'package:dofsweb/blocs/symptoms/symptoms_bloc.dart' as symptoms;
import 'package:dofsweb/blocs/users/users_bloc.dart' as users;
import 'package:dofsweb/models/pivot_by_disease.dart';
import 'package:dofsweb/models/user_preferences.dart';
import 'package:dofsweb/screens/disease/diseases_page.dart';
import 'package:dofsweb/widgets/pivot_chart.dart';
import 'package:dofsweb/screens/remedy/remedy.dart';
import 'package:dofsweb/screens/reports/reports.dart';
import 'package:dofsweb/screens/symptoms/symptoms.dart';
import 'package:dofsweb/screens/users/users_page.dart';
import 'package:dofsweb/widgets/pivot_chart_by_disease.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'login_page.dart';
import 'patient_case/patient_case_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as UserPreferences;

    return Scaffold(
      key: _key,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.black,
          iconSize: 35,
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/bell.svg',
              color: Colors.black,
              height: 35,
              width: 35,
            ),
          ),
          const SizedBox(width: 30),
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/retarded_mail.svg',
              color: Colors.black,
              height: 30,
              width: 30,
            ),
          ),
          const SizedBox(width: 30),
          const Center(
            child: Text(
              'ADMIN',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          PopupMenuButton(
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black,
            ),
            iconSize: 35,
            onSelected: (value) {
              if (value == 2) {
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
              }
            },
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  value: 1,
                  child: Text('Hello, ${data.username}!'),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Sign out'),
                ),
              ];
            },
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 15.0),
          //   child: Center(
          //     child: Text(
          //       'Hello, ${data.username}!',
          //       style: const TextStyle(
          //         color: Colors.white,
          //         fontSize: 16,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF7691ED),
        child: ListView(
          children: [
            SizedBox(
              height: 270,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 150,
                    width: 200,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      color: Colors.grey.shade300,
                      child: Image.asset('assets/logo.png'),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Doctor DOFS Admin',
                    style: TextStyle(
                      color: Color(0xFF193566),
                      fontSize: 18.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {},
              title: const Text(
                'Home',
                style: TextStyle(
                  color: Color(0xFF193566),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: SvgPicture.asset(
                'assets/home.svg',
                color: Colors.black,
                height: 27,
                width: 27,
              ),
            ),
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
              title: const Text(
                'Patient Cases',
                style: TextStyle(
                  color: Color(0xFF193566),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: SvgPicture.asset(
                'assets/add_person.svg',
                color: Colors.black,
                height: 27,
                width: 27,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) =>
                          symptoms.SymptomsBloc()..add(symptoms.LoadSymptoms()),
                      child: SymptomsPage(),
                    ),
                  ),
                );
              },
              title: const Text(
                'Symptoms',
                style: TextStyle(
                  color: Color(0xFF193566),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: SvgPicture.asset(
                'assets/stethoscope.svg',
                color: Colors.black,
                height: 27,
                width: 27,
              ),
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
              title: const Text(
                'Remedy',
                style: TextStyle(
                  color: Color(0xFF193566),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: SvgPicture.asset(
                'assets/medicine.svg',
                color: Colors.black,
                height: 27,
                width: 27,
              ),
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
              title: const Text(
                'Diseases',
                style: TextStyle(
                  color: Color(0xFF193566),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: SvgPicture.asset(
                'assets/monitor.svg',
                color: Colors.black,
                height: 27,
                width: 27,
              ),
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
              title: const Text(
                'Users',
                style: TextStyle(
                  color: Color(0xFF193566),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: SvgPicture.asset(
                'assets/person2.svg',
                color: Colors.black,
                height: 27,
                width: 27,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<HomeBloc>(context),
                      child: ReportsPage(),
                    ),
                  ),
                );
              },
              title: const Text(
                'Report',
                style: TextStyle(
                  color: Color(0xFF193566),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: SvgPicture.asset(
                'assets/tombstone2.svg',
                color: Colors.black,
                height: 27,
                width: 27,
              ),
            ),
            // ListTile(
            //   onTap: () {
            //     showDialog(
            //         context: context,
            //         builder: (_) {
            //           return AlertDialog(
            //             title: const Text('Confirm Signout'),
            //             actions: [
            //               TextButton(
            //                 onPressed: () {
            //                   Navigator.of(context).pop();
            //                 },
            //                 child: const Text('No'),
            //               ),
            //               TextButton(
            //                 onPressed: () {
            //                   context.read<HomeBloc>().add(LogoutUser());
            //                   Navigator.pop(context);
            //                 },
            //                 child: const Text('Yes'),
            //               ),
            //             ],
            //           );
            //         });
            //   },
            //   title: const Text('Sign Out'),
            //   leading: const Icon(Icons.logout),
            // ),
          ],
        ),
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Home/Dashboard',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(30).copyWith(
                          left: 80,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HELLO, ${data.username!.toUpperCase()}',
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF193566),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Welcome to DOCTOR DOFS.',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF193566),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.asset(
                        'assets/doctor.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(width: 100),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              // Expanded(
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Container(color: Colors.red),
              //       ),
              //       const SizedBox(width: 10),
              //       Expanded(
              //         child: Column(
              //           children: [
              //             Expanded(
              //               child: Container(
              //                 color: Colors.green,
              //               ),
              //             ),
              //             const SizedBox(height: 10),
              //             Expanded(
              //               child: Container(color: Colors.yellow),
              //             )
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // )
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 500,
                                child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      child: Text('Dengue'),
                                      value: 'Dengue',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Rabies'),
                                      value: 'Rabies',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Tuberculosis'),
                                      value: 'Tuberculosis',
                                    ),
                                  ],
                                  onChanged: (String? value) {
                                    context
                                        .read<HomeBloc>()
                                        .add(LoadPivotResult(value!));
                                  },
                                  value: 'Dengue',
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: BlocBuilder<HomeBloc, HomeState>(
                                builder: (context, state) {
                                  if (state is LoadingPivotResult) {
                                    return const SpinKitRing(
                                      color: Colors.black,
                                      size: 30,
                                      lineWidth: 3,
                                    );
                                  }

                                  // if (state is PivotResultLoaded) {
                                  //   return PivotChart(
                                  //     pivotResult: state.pivotResult,
                                  //   );
                                  // }
                                  if (state is PivotResultLoaded) {
                                    final pivotResult = state.pivotResult;
                                    return PivotChartByDisease(
                                      pivotResult: pivotResult,
                                    );
                                  } else {
                                    return const Center(
                                      child: Text('Something went wrong!'),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CalendarDatePicker(
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now()
                                    .subtract(const Duration(seconds: 2200)),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 999999)),
                                onDateChanged: (value) {},
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.only(top: 20, left: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'TRENDS',
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  DataTable(
                                    columns: const [
                                      DataColumn(
                                        label: Text(
                                          'Disease',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Chances',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: const [
                                      DataRow(
                                        cells: [
                                          DataCell(Text('Dengue')),
                                          DataCell(Text('60%')),
                                        ],
                                      ),
                                      DataRow(
                                        cells: [
                                          DataCell(Text('Rabies')),
                                          DataCell(Text('40%')),
                                        ],
                                      ),
                                      DataRow(
                                        cells: [
                                          DataCell(Text('Dengue')),
                                          DataCell(Text('10%')),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      // body: BlocConsumer<HomeBloc, HomeState>(
      //   listener: (context, state) {
      //     if (state is Error) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           content: Text(state.message),
      //         ),
      //       );
      //     }
      //     if (state is SigningOut) {
      //       showDialog(
      //           context: context,
      //           builder: (context) {
      //             return AlertDialog(
      //               content: Row(
      //                 children: const [
      //                   CircularProgressIndicator(),
      //                   Expanded(
      //                     child: Text('Signing Out...'),
      //                   )
      //                 ],
      //               ),
      //             );
      //           });
      //     }
      //     if (state is SignedOut) {
      //       Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => BlocProvider(
      //             create: (context) => LoginBloc(),
      //             child: LoginPage(),
      //           ),
      //         ),
      //         (route) => false,
      //       );
      //     }
      //   },
      //   builder: (context, state) {
      //     if (state is LoadingPivotResult) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else if (state is PivotResultLoaded) {
      //       return Padding(
      //         padding: const EdgeInsets.all(20),
      //         child: SfCartesianChart(
      //           primaryXAxis: CategoryAxis(),
      //           title: ChartTitle(text: 'Forecasting'),
      //           legend: Legend(isVisible: true),
      //           tooltipBehavior: TooltipBehavior(enable: true),
      //           enableAxisAnimation: true,
      //           series: <ChartSeries<PivotResult, String>>[
      //             LineSeries(
      //               width: 4,
      //               dataSource: state.pivotResult,
      //               xValueMapper: (PivotResult result, _) =>
      //                   DateFormat('MM-dd-yyyy')
      //                       .format(DateTime.tryParse(result.quarter!)!)
      //                       .toString(),
      //               yValueMapper: (PivotResult result, _) =>
      //                   result.tuberculosis!,
      //               legendIconType: LegendIconType.diamond,
      //               dataLabelSettings: const DataLabelSettings(isVisible: true),
      //               legendItemText: 'TUBERCULOSIS',
      //             ),
      //             LineSeries(
      //               width: 4,
      //               dataSource: state.pivotResult,
      //               xValueMapper: (PivotResult result, _) =>
      //                   DateFormat('MM-dd-yyyy')
      //                       .format(DateTime.tryParse(result.quarter!)!)
      //                       .toString(),
      //               yValueMapper: (PivotResult result, _) => result.rabies!,
      //               legendIconType: LegendIconType.diamond,
      //               dataLabelSettings: const DataLabelSettings(isVisible: true),
      //               legendItemText: 'RABIES',
      //             ),
      //             LineSeries(
      //               width: 4,
      //               dataSource: state.pivotResult,
      //               xValueMapper: (PivotResult result, _) =>
      //                   DateFormat('MM-dd-yyyy')
      //                       .format(DateTime.tryParse(result.quarter!)!)
      //                       .toString(),
      //               yValueMapper: (PivotResult result, _) => result.dengue!,
      //               legendIconType: LegendIconType.diamond,
      //               dataLabelSettings: const DataLabelSettings(isVisible: true),
      //               legendItemText: 'DENGUE',
      //             ),
      //           ],
      //         ),
      //       );
      //     } else {
      //       return const Center(
      //         child: Text('Empty Pivot Results'),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
