import 'package:mkr/core/common/urls.dart';
import 'package:dio/dio.dart';

class Apiservice {
  static late Dio dio;
  static initdio() {
    dio = Dio(BaseOptions(baseUrl: urls.baseurl));
    // dio.options.headers['Access-Control-Allow-Origin']='https://mymonshaa.web.app';
  }
}

// ignore: camel_case_types
class Postdata {
  static Future<Response> postdata(
      {required String path,
      String? token,
      Object? data,
      Map<String, dynamic>? queryParameters}) async {
    var respnse = await Apiservice.dio.post(path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
            headers: {"Accept": "application/json", "Authorization": token}));
    return respnse;
  }
}

class Putdata {
  static Future<Response> putdata(
      {required String path,
      String? token,
      Object? data,
      Map<String, dynamic>? queryParameters}) async {
    var respnse = await Apiservice.dio.put(path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
            headers: {"Accept": "application/json", "Authorization": token}));
    return respnse;
  }
}

// ignore: camel_case_types
class Getdata {
  static Future<Response> getdata(
      {required String path,
      String? token,
      Map<String, dynamic>? queryParameters}) async {
    var respnse = await Apiservice.dio.get(path,
        queryParameters: queryParameters,
        options: Options(
            receiveTimeout: Duration(minutes: 2),
            sendTimeout: Duration(minutes: 2),
            headers: {"Accept": "application/json", "Authorization": token}));
    return respnse;
  }
}

class Deletedata {
  static Future<Response> deletedata(
      {required String path,
      String? token,
      Map<String, dynamic>? queryParameters}) async {
    Response response = await Apiservice.dio.delete(path,
        queryParameters: queryParameters,
        options: Options(
            headers: {"Accept": "application/json", "Authorization": token}));
    return response;
  }
}
