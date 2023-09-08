// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:flutter_mvvm/model/movies_model.dart';
import 'package:flutter_mvvm/res/app_url.dart';
import 'package:flutter_mvvm/view_model/home_view_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';

class HomeRepository{
  final BaseApiServices _apiServices = NetworkApiService();
  Future<MovieListModel>getApi()async{
    try{
     dynamic response =await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
     log('${response.toString()} This is the response');
      return response =MovieListModel.fromJson(response);

    }
        catch(e){
      log('${e} This is the error');
      throw e;
        }
  }


}