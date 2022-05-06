import 'package:dofsweb/blocs/home/home_bloc.dart';
import 'package:dofsweb/blocs/login/login_bloc.dart';
import 'package:dofsweb/blocs/register/register_bloc.dart';
import 'package:dofsweb/notifiers/auth_notifier.dart';
import 'package:dofsweb/screens/registration_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  final txtUser = TextEditingController();
  final txtPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'LOG IN',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        'USERNAME',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
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
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'PASSWORD',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 500,
                        child: Consumer<AuthNotifier>(
                          builder: (context, bloc, child) {
                            return TextFormField(
                              controller: txtPass,
                              obscureText: !bloc.showLPassword,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    bloc.showLPassword = !bloc.showLPassword;
                                  },
                                  icon: bloc.showLPassword
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Required Field';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Click ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) => RegisterBloc(),
                                        child: RegistrationPage(),
                                      ),
                                    ),
                                  );
                                },
                              text: 'HERE',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: ' to create an account for our ',
                            ),
                            const TextSpan(
                              text: 'MOBILE APP.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 35),
                      Padding(
                        padding: const EdgeInsets.only(right: 235.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 300,
                            child: BlocConsumer<LoginBloc, LoginState>(
                              listener: (context, state) {
                                if (state is HasUser) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) => HomeBloc()
                                          ..add(LoadPivotResult('Dengue')),
                                        child: HomePage(),
                                      ),
                                      settings: RouteSettings(
                                        arguments: state.data,
                                      ),
                                    ),
                                  );
                                }
                                if (state is NoUser) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.message),
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is LoggingIn) {
                                  return const SpinKitRing(
                                    color: Colors.white,
                                    size: 25,
                                    lineWidth: 3,
                                  );
                                } else {
                                  return TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.all(15),
                                      backgroundColor: const Color(0xFF7691ec),
                                    ),
                                    child: const Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (!formKey.currentState!.validate()) {
                                        return;
                                      }

                                      context.read<LoginBloc>().add(LoginUser(
                                          txtUser.text, txtPass.text));
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 170),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // child: Form(
          //   key: formKey,
          //   autovalidateMode: AutovalidateMode.onUserInteraction,
          //   child: Center(
          //     child: Container(
          //       margin: const EdgeInsets.symmetric(horizontal: 600),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.stretch,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           SizedBox(
          //             height: 150,
          //             width: 150,
          //             child: Image.asset('assets/logo.png'),
          //           ),
          //           const Padding(
          //             padding: EdgeInsets.symmetric(vertical: 30.0),
          //             child: Text(
          //               'Sign In',
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                 fontSize: 25,
          //                 color: Colors.black87,
          //               ),
          //             ),
          //           ),
          //           TextFormField(
          //             controller: txtUser,
          //             decoration: const InputDecoration(
          //               labelText: 'Username',
          //             ),
          //             validator: (value) {
          //               if (value!.isEmpty) {
          //                 return 'Required Field';
          //               }
          //               return null;
          //             },
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.symmetric(vertical: 10)
          //                 .copyWith(bottom: 30),
          //             child: Consumer<AuthNotifier>(
          //               builder: (context, bloc, child) {
          //                 return TextFormField(
          //                   controller: txtPass,
          //                   obscureText: !bloc.showLPassword,
          //                   decoration: InputDecoration(
          //                     labelText: 'Password',
          //                     suffixIcon: IconButton(
          //                       onPressed: () {
          //                         bloc.showLPassword = !bloc.showLPassword;
          //                       },
          //                       icon: bloc.showLPassword
          //                           ? const Icon(Icons.visibility_off)
          //                           : const Icon(Icons.visibility),
          //                     ),
          //                   ),
          //                   validator: (value) {
          //                     if (value!.isEmpty) {
          //                       return 'Required Field';
          //                     }
          //                     return null;
          //                   },
          //                 );
          //               },
          //             ),
          //           ),
          //           RichText(
          //             textAlign: TextAlign.start,
          //             text: TextSpan(
          //               text: 'Click ',
          //               style: const TextStyle(
          //                 color: Colors.black,
          //                 fontSize: 16,
          //               ),
          //               children: [
          //                 TextSpan(
          //                   recognizer: TapGestureRecognizer()
          //                     ..onTap = () {
          //                       Navigator.of(context).push(
          //                         MaterialPageRoute(
          //                           builder: (context) => BlocProvider(
          //                             create: (context) => RegisterBloc(),
          //                             child: RegistrationPage(),
          //                           ),
          //                         ),
          //                       );
          //                     },
          //                   text: 'here',
          //                   style: const TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     decoration: TextDecoration.underline,
          //                   ),
          //                 ),
          //                 const TextSpan(
          //                   text: ' to create an account for our ',
          //                 ),
          //                 const TextSpan(
          //                   text: 'mobile app.',
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Align(
          //             alignment: Alignment.centerRight,
          //             child: Container(
          //               width: 200,
          //               padding: const EdgeInsets.all(5),
          //               margin: const EdgeInsets.only(top: 20),
          //               child: BlocConsumer<LoginBloc, LoginState>(
          //                 listener: (context, state) {
          //                   if (state is HasUser) {
          //                     Navigator.of(context).pushReplacement(
          //                       MaterialPageRoute(
          //                         builder: (context) => BlocProvider(
          //                           create: (context) => HomeBloc(),
          //                           child: const HomePage(),
          //                         ),
          //                         settings: RouteSettings(
          //                           arguments: state.data,
          //                         ),
          //                       ),
          //                     );
          //                   }
          //                   if (state is NoUser) {
          //                     ScaffoldMessenger.of(context).showSnackBar(
          //                       SnackBar(
          //                         content: Text(state.message),
          //                       ),
          //                     );
          //                   }
          //                 },
          //                 builder: (context, state) {
          //                   if (state is LoggingIn) {
          //                     return const SpinKitRing(
          //                       color: Colors.white,
          //                       size: 25,
          //                       lineWidth: 3,
          //                     );
          //                   } else {
          //                     return TextButton(
          //                       child: const Text(
          //                         'LOGIN',
          //                         style: TextStyle(
          //                           fontSize: 18,
          //                           color: Colors.white,
          //                         ),
          //                       ),
          //                       onPressed: () {
          //                         if (!formKey.currentState!.validate()) return;

          //                         context
          //                             .read<LoginBloc>()
          //                             .add(LoginUser(txtUser.text, txtPass.text));
          //                       },
          //                     );
          //                   }
          //                 },
          //               ),
          //               decoration: BoxDecoration(
          //                 color: Colors.lightBlue[900],
          //                 borderRadius: BorderRadius.circular(15),
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
