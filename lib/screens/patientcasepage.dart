import 'package:dofsweb/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PatientCasePage extends StatelessWidget {
  PatientCasePage({Key? key}) : super(key: key);

  final home = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Cases'),
        elevation: 1,
      ),
      body: Obx(() => home.loadingCases.value
          ? SpinKitRing(
              color: Colors.blue,
              size: 40,
              lineWidth: 3,
            )
          : home.patientCases.isEmpty
              ? Center(
                  child: Text('No Patient Case Found'),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    home.loadingCases.value = true;
                    home.fetchPatientCases();
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      showBottomBorder: true,
                      headingTextStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      columns: [
                        DataColumn(label: Text('Patient Name')),
                        DataColumn(label: Text('Barangay')),
                        DataColumn(label: Text('Disease Name')),
                        DataColumn(label: Text('Description')),
                        DataColumn(label: Text('Date Admission')),
                        DataColumn(label: Text('Date Onset')),
                        DataColumn(label: Text('Case Classification')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: home.patientCases.map(
                        (element) {
                          return DataRow(
                            cells: [
                              DataCell(Text(element.fullName())),
                              DataCell(Text(element.barangayName!)),
                              DataCell(Text(element.diseaseName!)),
                              DataCell(SizedBox(
                                width: 600,
                                child: Text(element.diseaseDescription!),
                              )),
                              DataCell(
                                Text(DateFormat().add_yMEd().add_jm().format(
                                    DateTime.tryParse(
                                        element.dateAdmission!)!)),
                              ),
                              DataCell(
                                Text(DateFormat().add_yMEd().add_jm().format(
                                    DateTime.tryParse(element.dateOnset!)!)),
                              ),
                              DataCell(Text(element.caseClassification!)),
                              DataCell(
                                TextButton(
                                  child: Text('View'),
                                  onPressed: () {},
                                ),
                              )
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  ),
                )),
    );
  }
}
