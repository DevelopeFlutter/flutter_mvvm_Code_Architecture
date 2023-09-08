import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm/model/user_model.dart';
import 'package:flutter_mvvm/repository/auth_repository.dart';
import 'package:flutter_mvvm/utils/routes/routes.dart';
import 'package:flutter_mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier{

  final _myRepo =AuthRepository();
   bool _loading  = false;
  bool _signUploading = false;
  bool get loading => _loading;
  bool get signUploading  => _signUploading;

  setLoading( value){
    _loading = value;
    notifyListeners();
  }
  setSignUpLoading( value){
    _signUploading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data ,  BuildContext context )async{
    setLoading(true);
    _myRepo.loginApi(data).then((value){
      final  userPrefrence = Provider.of<UserViewModel>(context,listen: false);
     userPrefrence.saveUser(UserModel(
       token: value['token'].toString(),
     ));
      Utils.flushBarErrorMessage('Login Successfully ', context);
      setLoading(false);
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace){
      Utils.flushBarErrorMessage(error.toString(), context);
      setLoading(false);
      print('${error.toString()} Error');
    });

  }

  Future<void> registerApi (dynamic data ,  BuildContext context )async{
    setSignUpLoading(true);
    _myRepo.registerApi(data).then((value){
      Utils.flushBarErrorMessage('SignUp Successfully ', context);
      setSignUpLoading(false);
      print('${value.toString()} Error');
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace){
      Utils.flushBarErrorMessage(error.toString(), context);
      setSignUpLoading(false);
      print('${error.toString()} Error');
    });

  }

}
