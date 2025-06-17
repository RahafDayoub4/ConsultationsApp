import 'package:dio/dio.dart';
import 'package:newtest/app/constants.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();

    Duration _timeOut = Duration(milliseconds: 60 * 1000);
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: "SEND TOKEN HERE",
      DEFAULT_LANGUAGE: "en",
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      receiveTimeout: _timeOut,
      sendTimeout: _timeOut,
    );

    return dio;
  }
}
