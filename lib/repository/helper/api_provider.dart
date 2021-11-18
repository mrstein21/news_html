import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:news_app/mixins/server.dart';
import 'exception.dart';
import 'logging_interceptor.dart';

class ApiProvider{
  Dio _dio;
  DioCacheManager _dioCacheManager;
  Options _cacheOptions;



  ApiProvider(){
    BaseOptions options =
    BaseOptions(receiveTimeout: 15000, connectTimeout: 15000);
    _dio = Dio(options);
    _dio.interceptors.add(LoggingInterceptor());
    _dioCacheManager = DioCacheManager(CacheConfig());
    _cacheOptions = buildCacheOptions(Duration(days: 7), forceRefresh: true);
    _dio.interceptors.add(_dioCacheManager.interceptor);
  }

  Future<dynamic>get(String endpoint)async{
    try {
      Response response = await _dio.get(Server.url + endpoint,options: _cacheOptions);
      return _returnResponse(response);
    }
    on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        return responseJson;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }

}