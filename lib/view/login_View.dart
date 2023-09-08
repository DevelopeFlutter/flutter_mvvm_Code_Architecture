// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/utils/utils.dart';
import 'package:flutter_mvvm/view/home_screen.dart';
import 'package:flutter_mvvm/view_model/auth_view_model.dart';

import '../res/components/round_button.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ValueNotifier _obsecurePassword = ValueNotifier(true);
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passworcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final _AuthviewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading:
          false,
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                focusNode: emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                controller: _emailcontroller,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.alternate_email),
                  labelText: 'Email',
                ),
                onFieldSubmitted: (value) {
                  Utils.fieldfocusChange(
                      context, emailFocusNode, passwordFocusNode);
                },
              ),
              ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (context, value, _) {
                    return TextFormField(
                      focusNode: passwordFocusNode,
                      obscureText: _obsecurePassword.value,
                      controller: _passworcontroller,
                      obscuringCharacter: '.',
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              _obsecurePassword.value =
                                  !_obsecurePassword.value;
                            },
                            child: Icon(_obsecurePassword.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility)),
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock_open_rounded),
                        labelText: 'Password',
                      ),
                    );
                  }),
              SizedBox(
                height: height * .085,
              ),
              RoundButton(
                loading: _AuthviewModel.loading ,
                title: 'Login',
                onPress: () {
                  if (_emailcontroller.text.isEmpty) {
                    Utils.flushBarErrorMessage('Please enter Email', context);
                  } else if (_passworcontroller.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        'Please enter Password', context);
                  } else if (_passworcontroller.text.length < 6) {
                    Utils.flushBarErrorMessage(
                        'Please enter 6 digit Password', context);
                  } else {

                  dynamic   data = {
                      'email':'eve.holt@reqres.in',
                      'password':'cityslicka',
                    };
                    _AuthviewModel.loginApi(data,context);
                  }
                },
              ),
              SizedBox(
                height: height * .02,
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.signUp);
                }
              ,child: const Text("Don't have an account? SingUp")),
            ],
          ),
        ));
  }
}
