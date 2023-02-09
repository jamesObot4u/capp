import 'package:flutter/material.dart';
import 'package:layover/model/model.dart';
import 'package:layover/screens/chat/chat_screen.dart';
import 'package:layover/screens/login/login_screen.dart';
import 'package:layover/screens/matches/matches_screen.dart';
import 'package:layover/screens/onboarding/onboarding_screens/screens.dart';
import 'package:layover/screens/premium/premium_screen.dart';
import 'package:layover/screens/profile/profile_screen.dart';
import 'package:layover/screens/splash/splash_screen.dart';

import '../card/card_form.dart';
import '../screens/onboarding/onboarding_screens.dart';
import '../screens/onboarding/onboarding_screens/verif/email_verification_screen.dart';
import '/screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('The Route is: ${settings.name}');

    print(settings);
    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case UsersScreen.routeName:
        return UsersScreen.route(user: settings.arguments as User);
      case Start.routeName:
        return Start.route();
      case Email.routeName:
        return Email.route();
      case EmailVerification.routeName:
        return EmailVerification.route();
      case Pictures.routeName:
        return Pictures.route();
      case Biography.routeName:
        return Biography.route();
      case Demography.routeName:
        return Demography.route();
      case MatchesScreen.routeName:
        return MatchesScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case PremiumScreen.routeName:
        return PremiumScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case CardForm.routeName:
        return CardForm.route();
      case ChatScreen.routeName:
        return ChatScreen.route(user: settings.arguments as User);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(appBar: AppBar(title: const Text('error'))),
      settings: const RouteSettings(name: '/error'),
    );
  }
}
