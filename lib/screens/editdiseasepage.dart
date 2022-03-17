import 'package:dofsweb/controllers/home_controller.dart';
import 'package:dofsweb/models/disease.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class EditDiseasePage extends StatelessWidget {
  EditDiseasePage({Key? key}) : super(key: key);

  final home = Get.find<HomeController>();
  final formKey = GlobalKey<FormState>();
  
  final txtDesc = TextEditingController();

  final disease = Get.arguments as Disease;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit"),
          leading: IconButton(
            onPressed: () => Get.back(result: true),
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 300),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${disease.diseaseName}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextFormField(
                    controller: txtDesc,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Disease Description',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Required Field';
                      }
                      return null;
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 20),
                    child: Obx(() => home.updatingDisease.value
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
                              final data = Disease(
                                diseaseId: disease.diseaseId,
                                description: txtDesc.text,
                              );
          
                              home.updateDisease(data, context);
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
