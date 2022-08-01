import 'package:propnex_test/services/api_interceptor.dart';

import 'log_interceptor.dart' as log;
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class DioModule with DioMixin implements Dio {
  DioModule._() {
    options = BaseOptions(
      contentType: 'application/json',
      connectTimeout: 30 * 1000,
      sendTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
      followRedirects: true,
      receiveDataWhenStatusError: true,
      baseUrl: "https://api.themoviedb.org/3",
    );

    interceptors
      ..add(ApiInterceptor())
      ..add(log.LogInterceptor());

    httpClientAdapter = DefaultHttpClientAdapter();
  }

  static Dio getInstance() => DioModule._();
}
