import 'package:flutter/material.dart';
import '../screens/landing.dart';
import '../screens/login.dart';
import '../screens/register.dart';
import '../screens/homepage.dart';
import '../screens/homepage2.dart';
import '../screens/auth_wrapper.dart';

class AppRoutes {
  static const String landing = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String home2 = '/home2';
  static const String authWrapper = '/auth-wrapper';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landing:
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case home2:
        return MaterialPageRoute(builder: (_) => const HomePage2());
      case authWrapper:
        return MaterialPageRoute(builder: (_) => const AuthWrapper());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
