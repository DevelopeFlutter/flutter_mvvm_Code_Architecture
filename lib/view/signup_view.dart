import 'package:flutter/material.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

import '../res/components/round_button.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';
class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  ValueNotifier _obsecurePassword = ValueNotifier(true);
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passworcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final _AuthviewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('SignUp'),
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
                loading: _AuthviewModel.signUploading,
                title: 'Sign Up',
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
                      'email':_emailcontroller.text.toString(),
                      'password':_passworcontroller.text.toString(),
                    };
                    _AuthviewModel.registerApi(data,context);
                  }
                },
              ),
              SizedBox(
                height: height * .02,
              ),
              InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RoutesName.login);
                  }
                  ,child: const Text("Already have an account? Login")),
            ],
          ),
        ));
  }
}
