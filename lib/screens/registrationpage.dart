import 'package:dofsweb/controllers/auth_controller.dart';
import 'package:dofsweb/helpers/constants.dart';
import 'package:dofsweb/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final auth = Get.put(AuthController());

  //user access
  final txtUser = TextEditingController();
  final txtPass = TextEditingController();
  final txtConPass = TextEditingController();

  //user info
  final txtFname = TextEditingController();
  final txtMname = TextEditingController();
  final txtLname = TextEditingController();
  final txtCompleteAddress = TextEditingController();
  final txtContactNum = TextEditingController();
  final txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/logo.png'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Text(
                    'Create Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Text(
                  'User Access',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: txtUser,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required Field';
                    }
                    if (value.length < 4) {
                      return 'Username must be four (4) characters and above.';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Obx(() => TextFormField(
                        controller: txtPass,
                        obscureText: !auth.showRPassword.value,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              auth.showRPassword.value =
                                  !auth.showRPassword.value;
                            },
                            icon: auth.showRPassword.value
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required Field';
                          }
                          if (value.length < 6) {
                            return 'Password must be six (6) characters and above.';
                          }
                          return null;
                        },
                      )),
                ),
                Obx(() => TextFormField(
                      controller: txtConPass,
                      obscureText: !auth.showRConPass.value,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            auth.showRConPass.value = !auth.showRConPass.value;
                          },
                          icon: auth.showRConPass.value
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required Field';
                        }
                        if (value != txtPass.text) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'User Information',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: txtFname,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required Field';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: TextFormField(
                        controller: txtMname,
                        decoration: InputDecoration(
                          labelText: 'Middle Name',
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: TextFormField(
                        controller: txtLname,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required Field';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: TextFormField(
                    controller: txtCompleteAddress,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Complete Address',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Required Field';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: txtEmail,
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required Field';
                          }
                          if (!isEmail(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: TextFormField(
                        controller: txtContactNum,
                        maxLength: 11,
                        decoration: InputDecoration(
                          labelText: 'Contact Number',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required Field';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 200,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(top: 25),
                        child: TextButton(
                          child: Text(
                            'BACK TO LOGIN',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: 200,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(top: 25),
                        child: Obx(() => auth.signingUp.value
                            ? SpinKitRing(
                                color: Colors.white,
                                size: 25,
                                lineWidth: 3,
                              )
                            : TextButton(
                                child: Text(
                                  'CREATE',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  if (!formKey.currentState!.validate()) return;

                                  final data = UserData(
                                    username: txtUser.text,
                                    password: txtPass.text,
                                    fname: txtFname.text,
                                    mname: txtMname.text,
                                    lname: txtLname.text,
                                    completeAddress: txtCompleteAddress.text,
                                    email: txtEmail.text,
                                    contactNumber: txtContactNum.text,
                                  );

                                  auth.signUp(data, context);
                                },
                              )),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[900],
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
