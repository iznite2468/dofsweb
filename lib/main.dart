import 'package:dofsweb/blocs/splash/splash_bloc.dart';
import 'package:dofsweb/notifiers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'screens/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthNotifier>(
      create: (context) => AuthNotifier(),
      child: MaterialApp(
        title: 'Doctor DOFS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          scaffoldBackgroundColor: const Color(0xFFe3e5e8),
          appBarTheme: const AppBarTheme(
            elevation: 0.5,
            centerTitle: true,
            backgroundColor: Color(0XFF193566),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        home: BlocProvider(
          create: (context) => SplashBloc(),
          child: const SplashPage(),
        ),
      ),
    );
  }
}
