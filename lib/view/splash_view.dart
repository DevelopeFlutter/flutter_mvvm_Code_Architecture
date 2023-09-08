import 'package:flutter/material.dart';
import 'package:flutter_mvvm/view_model/services/splash_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashServices services = SplashServices();
  @override
  void initState() {
    services.checkAuthentication(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Splash Screen',
          style:  Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
