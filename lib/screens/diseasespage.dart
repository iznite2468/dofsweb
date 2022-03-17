import 'package:dofsweb/bindings/home_binding.dart';
import 'package:dofsweb/controllers/home_controller.dart';
import 'package:dofsweb/screens/editdiseasepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class DiseasesPage extends StatelessWidget {
  DiseasesPage({Key? key}) : super(key: key);

  final home = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        elevation: 1,
      ),
      body: Obx(() => home.loadingDiseases.value
          ? SpinKitRing(
              color: Colors.blue,
              size: 40,
              lineWidth: 3,
            )
          : home.diseases.isEmpty
              ? Center(
                  child: Text('No User Found'),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    home.loadingDiseases.value = true;
                    home.fetchDiseases();
                  },
                  child: DataTable(
                    showBottomBorder: true,
                    headingTextStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    columns: [
                      DataColumn(label: Text('Disease Name')),
                      DataColumn(label: Text('Description')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: home.diseases.map(
                      (element) {
                        return DataRow(
                          cells: [
                            DataCell(Text(element.diseaseName!)),
                            DataCell(Text(element.description!)),
                            DataCell(
                              TextButton(
                                child: Text('EDIT'),
                                onPressed: () async {
                                  final result = await Get.to(
                                    () => EditDiseasePage(),
                                    arguments: element,
                                    binding: HomeBinding(),
                                  );
                                  if (result) {
                                    home.loadingDiseases.value = true;
                                    home.fetchDiseases();
                                  }
                                },
                              ),
                            )
                          ],
                        );
                      },
                    ).toList(),
                  ),
                )),
    );
  }
}
