import 'package:dofsweb/blocs/home/home_bloc.dart';
import 'package:dofsweb/blocs/login/login_bloc.dart';
import 'package:dofsweb/blocs/splash/splash_bloc.dart';
import 'package:dofsweb/screens/home_page.dart';
import 'package:dofsweb/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SplashBloc>().add(CheckUser());

    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is LoggedIn) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => HomeBloc(),
                child: const HomePage(),
              ),
              settings: RouteSettings(arguments: state.userPreferences),
            ),
          );
        }
        if (state is NotLoggedIn) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => LoginBloc(),
                child: LoginPage(),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: SizedBox(
            height: 500,
            width: 500,
            child: Image.asset('assets/logo.png'),
          ),
        ),
      ),
    );
  }
}
