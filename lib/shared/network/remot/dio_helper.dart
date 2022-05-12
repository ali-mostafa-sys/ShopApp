import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
          }),
    );
  }

  static Future<Response> getData({
    required String url,
   // required Map<String, dynamic> query,
    String? lang = 'en',
    String? Authorization,
  }) async {
    dio.options.headers = {'lang': lang, 'Authorization': Authorization};

    return dio.get(url,);
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      //  String? lang='ar',
      // String? token,
      required Map<String, dynamic> data}) async {
    //  dio.options.headers={'lang':lang};
    // return await dio.post(url, queryParameters: query, data: data);
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
