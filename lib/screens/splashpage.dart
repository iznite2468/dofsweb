import 'package:dofsweb/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 500,
          width: 500,
          child: Image.asset('assets/logo.png'),
        ),
      ),
    );
  }
}
