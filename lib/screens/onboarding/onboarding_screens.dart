// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:layover/blocs/onboarding/onboarding_bloc.dart';
// import 'package:layover/cubits/signup/signup_cubit.dart';
// import 'package:layover/respositories/auth_repository.dart';
// import 'package:layover/respositories/repositories.dart';
// import 'package:layover/screens/onboarding/onboarding_screens/bio/bio_screen.dart';
// import 'package:layover/screens/onboarding/onboarding_screens/demo/demo_screen.dart';
// import 'package:layover/screens/onboarding/onboarding_screens/email/email_screen.dart';
// import 'package:layover/screens/onboarding/onboarding_screens/verif/email_verification_screen.dart';
// import 'package:layover/screens/onboarding/onboarding_screens/picture/pictures_screen.dart';
// import 'package:layover/screens/onboarding/onboarding_screens/start_screen.dart';

// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({Key? key}) : super(key: key);

//   static const String routeName = '/onboarding';

//   static Route route() {
//     return MaterialPageRoute(
//       settings: const RouteSettings(name: routeName),
//       builder: (context) => const OnboardingScreen(),
//     );
//   }

//   static const List<Tab> tabs = <Tab>[
//     Tab(
//       text: 'Start',
//     ),
//     Tab(
//       text: 'Email',
//     ),
//     Tab(
//       text: 'EmailVerification',
//     ),
//     Tab(
//       text: 'Demography',
//     ),
//     Tab(
//       text: 'Pictures',
//     ),
//     Tab(
//       text: 'Biography',
//     )
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: tabs.length,
//         child: Builder(builder: (BuildContext context) {
//           final TabController tabController = DefaultTabController.of(context)!;

//           return Scaffold(
//             resizeToAvoidBottomInset: false,
//             appBar: AppBar(
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//             ),
//             body: TabBarView(children: [
//               Start(tabController: tabController),
//               Email(tabController: tabController),
//               EmailVerification(tabController: tabController),
//               Demography(tabController: tabController),
//               Pictures(tabController: tabController),
//               Biography(tabController: tabController),
//             ]),
//           );
//         }));
//   }
// }
