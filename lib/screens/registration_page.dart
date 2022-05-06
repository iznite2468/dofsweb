import 'package:dofsweb/blocs/register/register_bloc.dart';
import 'package:dofsweb/helpers/constants.dart';
import 'package:dofsweb/models/user_data.dart';
import 'package:dofsweb/notifiers/auth_notifier.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

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
    final bloc = Provider.of<AuthNotifier>(context);
    return Scaffold(
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/LOGIN.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 400,
                      width: 400,
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'DOCTOR DOFS',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        color: Color(0XFF193566),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      '(DIAGNOSTICAL OUTBREAK FORECAST SYSTEM)',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: Color(0XFF193566),
                      ),
                    ),
                    const SizedBox(height: 250),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 200.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'USER ACCESS',
                        style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'USERNAME',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 500,
                        child: TextFormField(
                          controller: txtUser,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
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
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'PASSWORD',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 500,
                        child: TextFormField(
                          controller: txtPass,
                          obscureText: !bloc.showPassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: () {
                                bloc.showPassword = !bloc.showPassword;
                              },
                              icon: bloc.showPassword
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
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
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'CONFIRM PASSWORD',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 500,
                        child: TextFormField(
                          controller: txtConPass,
                          obscureText: !bloc.showConfirmPassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: () {
                                bloc.showConfirmPassword =
                                    !bloc.showConfirmPassword;
                              },
                              icon: bloc.showConfirmPassword
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
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
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'USER INFORMATION',
                        style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 500,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'FIRST NAME',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      controller: txtFname,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: InputBorder.none,
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
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'MIDDLE NAME',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      controller: txtMname,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'LAST NAME',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      controller: txtLname,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: InputBorder.none,
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
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'COMPLETE ADDRESS',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 500,
                        child: TextFormField(
                          controller: txtCompleteAddress,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required Field';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: 500,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'E-MAIL ADDRESS',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: 250,
                                    child: TextFormField(
                                      controller: txtEmail,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: InputBorder.none,
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
                                ],
                              ),
                            ),
                            const SizedBox(width: 25),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'PHONE NUMBER',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: 250,
                                    child: TextFormField(
                                      controller: txtContactNum,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: InputBorder.none,
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
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'By signing up, you agree to our ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = () {},
                              text: 'terms and condition.',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: 500,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                child: const Text(
                                  'BACK TO LOGIN',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFF0F1322),
                                  padding: const EdgeInsets.all(15),
                                ),
                              ),
                            ),
                            const SizedBox(width: 25),
                            Expanded(
                              child: BlocConsumer<RegisterBloc, RegisterState>(
                                listener: (context, state) {
                                  if (state is Success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(state.message),
                                      ),
                                    );
                                  }
                                  if (state is Error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(state.message),
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is SigningUp) {
                                    return const SpinKitRing(
                                      color: Colors.white,
                                      size: 25,
                                      lineWidth: 3,
                                    );
                                  }
                                  return TextButton(
                                    onPressed: () {
                                      if (!formKey.currentState!.validate()) {
                                        return;
                                      }

                                      final data = UserData(
                                        username: txtUser.text,
                                        password: txtPass.text,
                                        fname: txtFname.text,
                                        mname: txtMname.text,
                                        lname: txtLname.text,
                                        completeAddress:
                                            txtCompleteAddress.text,
                                        email: txtEmail.text,
                                        contactNumber: txtContactNum.text,
                                      );

                                      context
                                          .read<RegisterBloc>()
                                          .add(RegisterUser(data));
                                    },
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.all(15),
                                      backgroundColor: const Color(0xFF7691ec),
                                    ),
                                    child: const Text(
                                      'CREATE',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // body: SingleChildScrollView(
        //   scrollDirection: Axis.vertical,
        //   child: Form(
        //     key: formKey,
        //     autovalidateMode: AutovalidateMode.onUserInteraction,
        //     child: Container(
        //       margin: const EdgeInsets.symmetric(horizontal: 600),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.stretch,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           const SizedBox(height: 20),
        //           SizedBox(
        //             height: 150,
        //             width: 150,
        //             child: Image.asset('assets/logo.png'),
        //           ),
        //           const Padding(
        //             padding: EdgeInsets.symmetric(vertical: 30.0),
        //             child: Text(
        //               'Create Account',
        //               textAlign: TextAlign.center,
        //               style: TextStyle(
        //                 fontSize: 25,
        //                 color: Colors.black87,
        //               ),
        //             ),
        //           ),
        //           const Text(
        //             'User Access',
        //             style: TextStyle(
        //               fontWeight: FontWeight.w600,
        //             ),
        //           ),
        //           const SizedBox(height: 15),
        //           TextFormField(
        //             controller: txtUser,
        //             decoration: const InputDecoration(
        //               labelText: 'Username',
        //             ),
        //             validator: (value) {
        //               if (value!.isEmpty) {
        //                 return 'Required Field';
        //               }
        //               if (value.length < 4) {
        //                 return 'Username must be four (4) characters and above.';
        //               }
        //               return null;
        //             },
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.symmetric(vertical: 10),
        //             child: TextFormField(
        //               controller: txtPass,
        //               obscureText: !bloc.showPassword,
        //               decoration: InputDecoration(
        //                 labelText: 'Password',
        //                 suffixIcon: IconButton(
        //                   onPressed: () {
        //                     bloc.showPassword = !bloc.showPassword;
        //                   },
        //                   icon: bloc.showPassword
        //                       ? const Icon(Icons.visibility_off)
        //                       : const Icon(Icons.visibility),
        //                 ),
        //               ),
        //               validator: (value) {
        //                 if (value!.isEmpty) {
        //                   return 'Required Field';
        //                 }
        //                 if (value.length < 6) {
        //                   return 'Password must be six (6) characters and above.';
        //                 }
        //                 return null;
        //               },
        //             ),
        //           ),
        //           TextFormField(
        //             controller: txtConPass,
        //             obscureText: !bloc.showConfirmPassword,
        //             decoration: InputDecoration(
        //               labelText: 'Confirm Password',
        //               suffixIcon: IconButton(
        //                 onPressed: () {
        //                   bloc.showConfirmPassword = !bloc.showConfirmPassword;
        //                 },
        //                 icon: bloc.showConfirmPassword
        //                     ? const Icon(Icons.visibility_off)
        //                     : const Icon(Icons.visibility),
        //               ),
        //             ),
        //             validator: (value) {
        //               if (value!.isEmpty) {
        //                 return 'Required Field';
        //               }
        //               if (value != txtPass.text) {
        //                 return 'Password does not match';
        //               }
        //               return null;
        //             },
        //           ),
        //           const Padding(
        //             padding: EdgeInsets.symmetric(vertical: 15),
        //             child: Text(
        //               'User Information',
        //               style: TextStyle(
        //                 fontWeight: FontWeight.w600,
        //               ),
        //             ),
        //           ),
        //           Row(
        //             children: [
        //               Expanded(
        //                 child: TextFormField(
        //                   controller: txtFname,
        //                   decoration: const InputDecoration(
        //                     labelText: 'First Name',
        //                   ),
        //                   validator: (value) {
        //                     if (value!.isEmpty) {
        //                       return 'Required Field';
        //                     }
        //                     return null;
        //                   },
        //                 ),
        //               ),
        //               const SizedBox(width: 15),
        //               Expanded(
        //                 child: TextFormField(
        //                   controller: txtMname,
        //                   decoration: const InputDecoration(
        //                     labelText: 'Middle Name',
        //                   ),
        //                 ),
        //               ),
        //               const SizedBox(width: 15),
        //               Expanded(
        //                 child: TextFormField(
        //                   controller: txtLname,
        //                   decoration: const InputDecoration(
        //                     labelText: 'Last Name',
        //                   ),
        //                   validator: (value) {
        //                     if (value!.isEmpty) {
        //                       return 'Required Field';
        //                     }
        //                     return null;
        //                   },
        //                 ),
        //               ),
        //             ],
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.symmetric(vertical: 15),
        //             child: TextFormField(
        //               controller: txtCompleteAddress,
        //               maxLines: 2,
        //               decoration: const InputDecoration(
        //                 labelText: 'Complete Address',
        //               ),
        //               validator: (value) {
        //                 if (value!.isEmpty) {
        //                   return 'Required Field';
        //                 }
        //                 return null;
        //               },
        //             ),
        //           ),
        //           Row(
        //             children: [
        //               Expanded(
        //                 child: TextFormField(
        //                   controller: txtEmail,
        //                   decoration: const InputDecoration(
        //                     labelText: 'Email',
        //                   ),
        //                   validator: (value) {
        //                     if (value!.isEmpty) {
        //                       return 'Required Field';
        //                     }
        //                     if (!isEmail(value)) {
        //                       return 'Please enter a valid email address';
        //                     }
        //                     return null;
        //                   },
        //                 ),
        //               ),
        //               const SizedBox(width: 15),
        //               Expanded(
        //                 child: TextFormField(
        //                   controller: txtContactNum,
        //                   maxLength: 11,
        //                   decoration: const InputDecoration(
        //                     labelText: 'Contact Number',
        //                   ),
        //                   validator: (value) {
        //                     if (value!.isEmpty) {
        //                       return 'Required Field';
        //                     }
        //                     return null;
        //                   },
        //                 ),
        //               ),
        //             ],
        //           ),
        //           Align(
        //             alignment: Alignment.centerRight,
        //             child: Row(
        //               crossAxisAlignment: CrossAxisAlignment.end,
        //               mainAxisAlignment: MainAxisAlignment.end,
        //               children: [
        //                 Container(
        //                   width: 200,
        //                   padding: const EdgeInsets.all(5),
        //                   margin: const EdgeInsets.only(top: 25),
        //                   child: TextButton(
        //                     child: const Text(
        //                       'BACK TO LOGIN',
        //                       style: TextStyle(
        //                         fontSize: 18,
        //                         color: Colors.white,
        //                       ),
        //                     ),
        //                     onPressed: () {
        //                       Navigator.pop(context);
        //                     },
        //                   ),
        //                   decoration: BoxDecoration(
        //                     color: Colors.black87,
        //                     borderRadius: BorderRadius.circular(15),
        //                   ),
        //                 ),
        //                 const SizedBox(width: 20),
        //                 Container(
        //                   width: 200,
        //                   padding: const EdgeInsets.all(5),
        //                   margin: const EdgeInsets.only(top: 25),
        //                   child: TextButton(
        //                     child: BlocConsumer<RegisterBloc, RegisterState>(
        //                       listener: (context, state) {
        //                         if (state is Success) {
        //                           ScaffoldMessenger.of(context).showSnackBar(
        //                             SnackBar(
        //                               content: Text(state.message),
        //                             ),
        //                           );
        //                         }
        //                         if (state is Error) {
        //                           ScaffoldMessenger.of(context).showSnackBar(
        //                             SnackBar(
        //                               content: Text(state.message),
        //                             ),
        //                           );
        //                         }
        //                       },
        //                       builder: (context, state) {
        //                         if (state is SigningUp) {
        //                           return const SpinKitRing(
        //                             color: Colors.white,
        //                             size: 25,
        //                             lineWidth: 3,
        //                           );
        //                         } else {
        //                           return const Text(
        //                             'CREATE',
        //                             style: TextStyle(
        //                               fontSize: 18,
        //                               color: Colors.white,
        //                             ),
        //                           );
        //                         }
        //                       },
        //                     ),
        //                     onPressed: () {
        //                       if (!formKey.currentState!.validate()) return;

        //                       final data = UserData(
        //                         username: txtUser.text,
        //                         password: txtPass.text,
        //                         fname: txtFname.text,
        //                         mname: txtMname.text,
        //                         lname: txtLname.text,
        //                         completeAddress: txtCompleteAddress.text,
        //                         email: txtEmail.text,
        //                         contactNumber: txtContactNum.text,
        //                       );

        //                       context
        //                           .read<RegisterBloc>()
        //                           .add(RegisterUser(data));
        //                     },
        //                   ),
        //                   decoration: BoxDecoration(
        //                     color: Colors.lightBlue[900],
        //                     borderRadius: BorderRadius.circular(15),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
