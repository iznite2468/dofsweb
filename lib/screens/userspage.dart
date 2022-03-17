import 'package:dofsweb/bindings/auth_binding.dart';
import 'package:dofsweb/bindings/home_binding.dart';
import 'package:dofsweb/controllers/home_controller.dart';
import 'package:dofsweb/screens/adduser.dart';
import 'package:dofsweb/screens/edituserpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class UsersPage extends StatelessWidget {
  UsersPage({Key? key}) : super(key: key);

  final home = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        elevation: 1,
        actions: [
          TextButton.icon(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () => Get.to(() => RegistrationPage(
                  isFromLogin: false,
                )),
            label: Text(
              "Add New",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() => home.loadingUsers.value
          ? SpinKitRing(
              color: Colors.blue,
              size: 40,
              lineWidth: 3,
            )
          : home.users.isEmpty
              ? Center(
                  child: Text('No User Found'),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    home.loadingUsers.value = true;
                    home.fetchUsers();
                  },
                  child: DataTable(
                    showBottomBorder: true,
                    headingTextStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    columns: [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Username')),
                      DataColumn(label: Text('Address')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Contact Number')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: home.users.map(
                      (element) {
                        print(element.status);
                        return DataRow(
                          cells: [
                            DataCell(Text(element.fullName())),
                            DataCell(Text(element.username!)),
                            DataCell(Text(element.completeAddress!)),
                            DataCell(Text(element.email!)),
                            DataCell(Text(element.contactNumber!)),
                            DataCell(
                              TextButton(
                                child: Text('Edit'),
                                onPressed: () async {
                                  final result = await Get.to(
                                    () => EditUserPage(),
                                    arguments: element,
                                    binding: HomeBinding(),
                                  );
                                  if (result) {
                                    home.loadingUsers.value = true;
                                    home.fetchUsers();
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
