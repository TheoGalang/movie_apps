import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters
        .addAll({"api_key": "fbb9572d11b5458ac98f02b84f2bafc4"});
    handler.next(options);
  }
}
