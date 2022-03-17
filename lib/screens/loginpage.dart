import 'package:dofsweb/controllers/auth_controller.dart';
import 'package:dofsweb/screens/adduser.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final auth = Get.put(AuthController());

  final txtUser = TextEditingController();
  final txtPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/logo.png'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black87,
                    ),
                  ),
                ),
                TextFormField(
                  controller: txtUser,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required Field';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10)
                      .copyWith(bottom: 30),
                  child: Obx(() => TextFormField(
                        controller: txtPass,
                        obscureText: !auth.showPassword.value,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              auth.showPassword.value =
                                  !auth.showPassword.value;
                            },
                            icon: auth.showPassword.value
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required Field';
                          }
                          return null;
                        },
                      )),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: 'Click ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => RegistrationPage(isFromLogin: true));
                          },
                        text: 'here',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ' to create an account for our ',
                      ),
                      TextSpan(
                        text: 'mobile app.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(top: 20),
                    child: Obx(() => auth.signingIn.value
                        ? SpinKitRing(
                            color: Colors.white,
                            size: 25,
                            lineWidth: 3,
                          )
                        : TextButton(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (!formKey.currentState!.validate()) return;

                              auth.signIn(txtUser.text, txtPass.text, context);
                            },
                          )),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[900],
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
