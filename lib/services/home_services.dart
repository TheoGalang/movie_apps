// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:propnex_test/models/detail_movie_response.dart';
import 'package:propnex_test/models/movie_response.dart';
import 'package:propnex_test/models/recommended_response.dart';
import 'dio_module.dart';



class HomeServices {


  Future<GetMovieResponse> getMovies(String type)async {
    try{
      Response res = await DioModule.getInstance().get("/movie/${type}");
      return GetMovieResponse.fromJson(res.data);
    }on DioError catch (e){
      Fluttertoast.showToast(msg: "Periksa Jaringan Anda Kembali");
      return GetMovieResponse.withError(e.message);
    }
}
  Future<GetDetailMovie> getMoviesById(int id)async {
    try{
      Response res = await DioModule.getInstance().get("/movie/${id}");
      return GetDetailMovie.fromJson(res.data);
    }on DioError catch (e){
      Fluttertoast.showToast(msg: "Periksa Jaringan Anda Kembali");
      return GetDetailMovie.withError(e.message);
    }
}

  Future<RecommendedResponse> getMoviesRecommended(int id)async {
    try{
      Response res = await DioModule.getInstance().get("/movie/$id/recommendations");
      return RecommendedResponse.fromJson(res.data);
    }on DioError catch (e){
      Fluttertoast.showToast(msg: "Periksa Jaringan Anda Kembali");
      return RecommendedResponse.withError(e.message);
    }
}

}