import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_mvvm/view_model/user_view_model.dart';
import '../../model/user_model.dart';
class SplashServices{
  Future<UserModel> getUserdata ()=>UserViewModel().getUser();
  void checkAuthentication(BuildContext context)async{
    getUserdata().then((value) async{
      if(value.token=='null' || value.token==''){
        Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context,RoutesName.login );
      }
      else{
        await Future.delayed(const Duration(seconds: 3));
       Navigator.pushNamed(context,RoutesName.home );

      }
    } ).onError((error, stackTrace) {
      if(kDebugMode){
        print('${error.toString()} This is the error');
      }
    });
  }


}