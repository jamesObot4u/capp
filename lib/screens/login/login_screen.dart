import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:layover/blocs/auth/auth_bloc.dart';
import 'package:layover/config/theme.dart';
import 'package:layover/cubits/login/login_cubit.dart';
import 'package:layover/screens/home/home_screen.dart';
import 'package:layover/screens/login/controllers.dart';
import 'package:layover/screens/onboarding/onboarding_screens.dart';
import 'package:layover/screens/onboarding/onboarding_screens/screens.dart';
import 'package:layover/widgets/custom_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          return BlocProvider.of<AuthBloc>(context).state.status ==
                  AuthStatus.authenticated
              ? HomeScreen()
              : LoginScreen();
        });
  }

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mailCont = TextEditingController();
  final TextEditingController passCont = TextEditingController();
  GlobalKey<FormState> formKeyt = GlobalKey<FormState>();
  bool isLoading = false;
  String errorMsg = '';
  bool passVisible = true;
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
          child: Form(
            key: formKeyt,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 28.0),
                  child: Center(
                    child: Image.asset(
                      'assets/images/user.png',
                      height: 170,
                      width: 170,
                      color: theme().primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                  controller: mailCont,
                  // onChanged: (email) {
                  //   context.read<LoginCubit>().emailChanged(email);
                  // },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color.fromARGB(255, 83, 140, 210),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password ';
                    }
                  },
                  controller: passCont,
                  // onChanged: (password) {
                  //   context.read<LoginCubit>().passwordChanged(password);
                  // },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          if (passVisible == true) {
                            passVisible = false;
                          } else {
                            passVisible = true;
                          }
                        });
                      },
                      child: passVisible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color.fromARGB(255, 83, 140, 210),
                    ),
                  ),
                  obscureText: !passVisible ? false : true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: theme().primaryColor.withAlpha(50),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(2, 2),
                          ),
                        ],
                        gradient: LinearGradient(colors: [
                          theme().secondaryHeaderColor,
                          theme().primaryColor
                        ])),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKeyt.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          // context.read<LoginCubit>().LoginWithCredentials();
                          if (mailCont.text == '' || passCont == '') {
                            setState(() {
                              isLoading = true;
                            });
                          } else {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: mailCont.text,
                                      password: passCont.text)
                                  .then((value) => Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                        HomeScreen.routeName,
                                        ModalRoute.withName('/'),
                                      ));

                              errorMsg = '';
                            } on FirebaseAuthException catch (error) {
                              errorMsg = error.message!;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Incorrect email or password...')));
                            }
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0,
                          fixedSize: const Size(400, 40)),
                      child: Container(
                          width: double.infinity,
                          child: !isLoading
                              ? Text(
                                  'LOGIN',
                                  textAlign: TextAlign.center,
                                  style: theme()
                                      .textTheme
                                      .headline4!
                                      .copyWith(color: Colors.white),
                                )
                              : const Center(
                                  child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: theme()
                          .textTheme
                          .headline4!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/email');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Sign Up',
                          style: theme()
                              .textTheme
                              .headline4!
                              .copyWith(color: theme().primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value!))
    return 'Enter Valid Email';
  else
    return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Password is required';

  return null;
}
