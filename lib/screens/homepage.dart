import 'package:dofsweb/bindings/home_binding.dart';
import 'package:dofsweb/controllers/auth_controller.dart';
import 'package:dofsweb/controllers/home_controller.dart';
import 'package:dofsweb/models/user_preferences.dart';
import 'package:dofsweb/screens/diseasespage.dart';
import 'package:dofsweb/screens/patientcasepage.dart';
import 'package:dofsweb/screens/userspage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final auth = Get.find<AuthController>();
  final home = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        elevation: 1,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    right: 10,
                    top: 10,
                  ),
                  child: Text('Hello USER123'),
                ),
              ),
            ),
            // ListTile(
            //   onTap: () {},
            //   title: Text('Dashboard'),
            //   leading: Icon(Icons.home),
            // ),
            ListTile(
              onTap: () => Get.to(
                () => UsersPage(),
                binding: HomeBinding(),
              ),
              title: Text('Users'),
              leading: Icon(Icons.group),
            ),
            ListTile(
              onTap: () {},
              title: Text('Symptoms'),
              leading: Icon(Icons.question_answer),
            ),
            ListTile(
              onTap: () => Get.to(
                () => DiseasesPage(),
                binding: HomeBinding(),
              ),
              title: Text('Diseases'),
              leading: Icon(Icons.info),
            ),
            ListTile(
              onTap: () => Get.to(
                () => PatientCasePage(),
                binding: HomeBinding(),
              ),
              title: Text('Patient Cases'),
              leading: Icon(Icons.groups),
            ),
            ListTile(
              onTap: () => auth.signOut(),
              title: Text('Sign Out'),
              leading: Icon(Icons.logout),
            ),
          ],
        ),
      ),
      body: Container(),
    );
  }
}
