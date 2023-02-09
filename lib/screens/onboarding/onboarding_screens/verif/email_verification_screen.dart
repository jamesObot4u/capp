import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:layover/config/theme.dart';
import 'package:layover/screens/onboarding/onboarding_screens/screens.dart';
import 'package:layover/screens/onboarding/widgets/cbutton.dart';
import 'package:layover/screens/onboarding/widgets/custom_text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  static const String routeName = '/verif';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const EmailVerification(),
    );
  }

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool isVerified = false;
  Timer? timer;
  bool canResend = false;

  @override
  void initState() {
    super.initState();

    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    print(FirebaseAuth.instance.currentUser!.emailVerified);
    if (!isVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (timer) {
        checkEmailVerified();
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    print(FirebaseAuth.instance.currentUser!.emailVerified);
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() {
        canResend = false;
      });
      await Future.delayed(Duration(seconds: 10));
      setState(() {
        canResend = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 50.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: CustomTextHeader(
                          text: "Verify Your Email",
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'A verification link has been sent to your email.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17, fontFamily: 'FTL'),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      !isVerified
                          ? Container(
                              width: 250,
                              decoration: BoxDecoration(
                                  color: theme().secondaryHeaderColor),
                              child: TextButton(
                                  onPressed: () {
                                    canResend ? sendVerificationEmail() : null;
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Icon(
                                          Icons.email,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'Resend Verification Link',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )),
                            )
                          : Container(
                              width: 250,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 26, 92, 61)),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Verified',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Icon(
                                          Icons.verified,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                    ],
                  ),
                ),
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 5,
                      currentStep: 2,
                      selectedColor: theme().primaryColor,
                      unselectedColor: theme().backgroundColor,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    isVerified
                        ? Cbutton(
                            text: 'NEXT STEP',
                            onpressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  Demography.routeName,
                                  ModalRoute.withName('/demo'));
                            },
                          )
                        : Cbutton(text: 'NEXT STEP')
                  ],
                ),
              ])),
    );
  }
}
