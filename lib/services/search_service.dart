import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:propnex_test/models/search_response.dart';

import 'dio_module.dart';

class SearchService {
  Future<SearchResponse> searchMovies(String query)async {
    try{
      Response res = await DioModule.getInstance().get("/search/movie?query=$query");
      return SearchResponse.fromJson(res.data);
    }on DioError catch (e){
      Fluttertoast.showToast(msg: e.message);
      return SearchResponse.withError(e.message);
    }
  }
}