import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:layover/config/theme.dart';
import 'package:layover/screens/login/login_screen.dart';
import 'package:layover/screens/onboarding/onboarding_screens.dart';
import 'package:layover/screens/onboarding/onboarding_screens/screens.dart';
import 'package:layover/screens/onboarding/onboarding_screens/verif/email_verification_screen.dart';
import '../../blocs/auth/auth_bloc.dart';
import '/screens/screens.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          print("Listener");
          if (state.status == AuthStatus.unauthenticated) {
            Timer(Duration(seconds: 2), () {
              Navigator.of(context).pushReplacementNamed(Start.routeName);
              print('unauth');
            });
          } else if (state.status == AuthStatus.authenticated &&
              FirebaseAuth.instance.currentUser!.emailVerified == true) {
            Timer(Duration(seconds: 2), () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
              print('hill');
            });
          } else if (FirebaseAuth.instance.currentUser!.emailVerified ==
              false) {
            // Timer(Duration(seconds: 10), () {
            //   Navigator.of(context).pushNamed(EmailVerification.routeName);
            // });
          } else {
            // Timer(Duration(seconds: 2), () {
            //   Navigator.of(context).pushReplacementNamed(Start.routeName);
            // });
          }
        },
        child: Scaffold(
          body: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/icon.png',
                    color: theme().primaryColor,
                    height: 100,
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
