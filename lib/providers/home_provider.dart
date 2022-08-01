// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:propnex_test/models/detail_movie_response.dart';
import 'package:propnex_test/models/movie_response.dart';
import 'package:propnex_test/models/recommended_response.dart';
import 'package:propnex_test/models/search_response.dart';
import 'package:propnex_test/services/home_services.dart';
import 'package:propnex_test/services/search_service.dart';

class HomeProvider extends ChangeNotifier{

  Map<String, GetMovieResponse?> movieData = {};
  GetMovieResponse? getMovieResponse;
  GetMovieResponse? getMovieTopRatedResponse;


  SearchResponse? getSearchResponse;
  TextEditingController searchCtrl = TextEditingController();



  void getMovies (String type)async{
    Future.delayed(Duration(seconds: 1));
    var resp = await HomeServices().getMovies(type);
    if(resp != null){
      getMovieResponse = resp;
      movieData[type] = resp;
      notifyListeners();
    }
    else{
      print ("gagal");
    }
}

  void getMoviesTopRated (String type)async{
    Future.delayed(Duration(seconds: 1));
    var resp = await HomeServices().getMovies(type);
    if(resp != null){
      getMovieTopRatedResponse = resp;
      getMovieTopRatedResponse!.results!.sort((a, b) => b.voteAverage.compareTo(a.voteAverage));
      notifyListeners();
    }
    else{
      print ("gagal");
    }
}

  void getSearch(String query)async{
    var resp = await SearchService().searchMovies(query);
    if(resp != null){
      getSearchResponse = resp;
      notifyListeners();
    }
    else{
      print("gagal");
    }
  }



}