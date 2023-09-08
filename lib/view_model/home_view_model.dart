import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm/data/response/api_response.dart';
import 'package:flutter_mvvm/model/movies_model.dart';
import 'package:flutter_mvvm/repository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier{
  final _repo=HomeRepository();
  ApiResponse <MovieListModel> moviesList = ApiResponse.loading();
  setMovieList(ApiResponse<MovieListModel> response ){
    moviesList = response;
    notifyListeners();

  }
  Future<dynamic> getApi()async{
    setMovieList(ApiResponse.loading());
      _repo.getApi().then((value) {
setMovieList(ApiResponse.completed(value));

    }).onError((error, stackTrace) {
      setMovieList(ApiResponse.error(error.toString()));

    });
  }

}