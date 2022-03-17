import 'package:async/async.dart';
import 'package:dofsweb/controllers/home_controller.dart';
import 'package:dofsweb/helpers/constants.dart';
import 'package:dofsweb/models/user_data.dart';
import 'package:dofsweb/models/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class EditUserPage extends StatelessWidget {
  EditUserPage({Key? key}) : super(key: key);

  AsyncMemoizer memoizer = AsyncMemoizer();

  final home = Get.find<HomeController>();
  final formKey = GlobalKey<FormState>();

  final txtAddress = TextEditingController();
  final txtContactNum = TextEditingController();
  final txtEmail = TextEditingController();

  final user = Get.arguments as UserInfo;

  @override
  Widget build(BuildContext context) {
    memoizer.runOnce(() {
      txtAddress.text = user.completeAddress!;
      txtContactNum.text = user.contactNumber!;
      txtEmail.text = user.email!;
    });

    return WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit'),
          leading: IconButton(
            onPressed: () => Get.back(result: true),
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50.0,
                      bottom: 20,
                    ),
                    child: Text(
                      'User Info',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: txtAddress,
                    decoration: InputDecoration(
                      labelText: 'Complete Address',
                    ),
                    maxLines: 2,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Required Field';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
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
                  TextFormField(
                    controller: txtEmail,
                    keyboardType: TextInputType.emailAddress,
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
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(top: 20),
                    child: Obx(() => home.updatingUserInfo.value
                        ? SpinKitRing(
                            color: Colors.white,
                            size: 25,
                            lineWidth: 3,
                          )
                        : TextButton(
                            child: Text(
                              'UPDATE',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (!formKey.currentState!.validate()) return;

                              final data = UserData(
                                userAccessId: user.userAccessId,
                                completeAddress: txtAddress.text,
                                contactNumber: txtContactNum.text,
                                email: txtEmail.text,
                              );

                              home.updateUserInfo(data, context);
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
          ),
        ),
      ),
    );
  }
}
