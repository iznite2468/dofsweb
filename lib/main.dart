import 'package:dofsweb/bindings/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/auth_binding.dart';
import 'bindings/splash_binding.dart';
import 'screens/homepage.dart';
import 'screens/loginpage.dart';
import 'screens/registrationpage.dart';
import 'screens/splashpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Doctor DOFS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashPage(),
          binding: SplashBinding(),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
          bindings: [
            AuthBinding(),
            HomeBinding(),
          ],
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/register',
          page: () => RegistrationPage(),
          binding: AuthBinding(),
        ),
      ],
    );
  }
}
