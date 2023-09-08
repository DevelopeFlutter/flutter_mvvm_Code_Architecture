import 'package:flutter/material.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_mvvm/view/login_View.dart';

import '../../view/home_screen.dart';
import '../../view/signup_view.dart';
import '../../view/splash_view.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RoutesName.spalsh:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) =>const  SignUpView());
      default:
        MaterialPageRoute(
            builder: (BuildContext context) => const Scaffold(
                  body: Center(
                    child: Text('no route defiend '),
                  ),
                ));
    }
// return ;
  }
}
