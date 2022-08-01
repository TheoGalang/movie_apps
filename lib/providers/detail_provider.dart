import 'package:flutter/material.dart';

import '../models/detail_movie_response.dart';
import '../models/recommended_response.dart';
import '../services/home_services.dart';

class DetailProvider extends ChangeNotifier {
  GetDetailMovie? getDetailMovie;
  RecommendedResponse? getRecommended;

  void getMovieById(int id) async {
    var resp = await HomeServices().getMoviesById(id);
    if (resp != null) {
      getDetailMovie = resp;
      notifyListeners();
    }
    else {
      print("gagal");
    }
  }

  void getMoviesRecommended (int id)async{
    Future.delayed(Duration(seconds: 1));
    var resp = await HomeServices().getMoviesRecommended(id);
    if(resp != null){
      getRecommended = resp;
      notifyListeners();
    }
    else{
      print ("gagal");
    }
  }
}