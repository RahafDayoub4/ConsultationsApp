import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:newtest/data/network/failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNEDT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();

    case DioExceptionType.badResponse:
      if (error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(
          error.response?.statusCode ?? 0,
          error.response?.statusMessage ?? "",
        );
      } else {
        return DataSource.DEFAULT.getFailure();
      }

    case DioExceptionType.cancel:
      return DataSource.CANCLE.getFailure();
    case DioExceptionType.unknown:
      return DataSource.DEFAULT.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.BAD_REQUEST.getFailure();

    case DioExceptionType.connectionError:
      return DataSource.No_CONTENT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  No_CONTENT,
  BAD_REQUEST,
  FORVIDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERENAL_SEVER_ERROR,
  CONNEDT_TIMEOUT,
  CANCLE,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERENT_CONNECTION,
  DEFAULT,
}

extension DataSourceExtention on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMesaage.SUCCESS);
        break;

      case DataSource.No_CONTENT:
        return Failure(ResponseCode.No_CONTENT, ResponseMesaage.No_CONTENT);
        break;
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMesaage.BAD_REQUEST);
        break;
      case DataSource.FORVIDEN:
        return Failure(ResponseCode.FORVIDEN, ResponseMesaage.FORVIDEN);
        break;
      case DataSource.UNAUTHORISED:
        return Failure(ResponseCode.UNAUTHORISED, ResponseMesaage.UNAUTHORISED);
        break;
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMesaage.NOT_FOUND);
        break;
      case DataSource.INTERENAL_SEVER_ERROR:
        return Failure(
          ResponseCode.INTERENAL_SEVER_ERROR,
          ResponseMesaage.INTERENAL_SEVER_ERROR,
        );
        break;
      case DataSource.CONNEDT_TIMEOUT:
        return Failure(
          ResponseCode.CONNEDT_TIMEOUT,
          ResponseMesaage.CONNEDT_TIMEOUT,
        );
        break;
      case DataSource.CANCLE:
        return Failure(ResponseCode.CANCLE, ResponseMesaage.CANCLE);
        break;
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
          ResponseCode.RECIEVE_TIMEOUT,
          ResponseMesaage.RECIEVE_TIMEOUT,
        );
        break;
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMesaage.SEND_TIMEOUT);
        break;
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMesaage.CACHE_ERROR);
        break;
      case DataSource.NO_INTERENT_CONNECTION:
        return Failure(
          ResponseCode.NO_INTERENT_CONNECTION,
          ResponseMesaage.NO_INTERENT_CONNECTION,
        );
        break;
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMesaage.DEFAULT);
        break;
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200;
  static const int No_CONTENT = 201;
  static const int BAD_REQUEST = 400;
  static const int FORVIDEN = 401;
  static const int UNAUTHORISED = 403;
  static const int NOT_FOUND = 404;

  static const int INTERENAL_SEVER_ERROR = 500;

  //local status code
  static const int CONNEDT_TIMEOUT = -1;
  static const int CANCLE = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERENT_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMesaage {
  static const String SUCCESS = "success";
  static const String No_CONTENT = "success";
  static const String BAD_REQUEST = "Bad requet, try again later";
  static const String FORVIDEN = "User is uauthorised , Try again later";
  static const String UNAUTHORISED = "Forbiden request ,Try again later";
  static const String INTERENAL_SEVER_ERROR =
      "Some thing went worn ,Try again later";
  static const String NOT_FOUND = "Some thing went worn ,Try again later";

  //local status code
  static const String CONNEDT_TIMEOUT = "Time out error , Try again later";
  static const String CANCLE = "Request was cancelled ,Try again later";
  static const String RECIEVE_TIMEOUT = "Time out error , Try again later";
  static const String SEND_TIMEOUT = "Time out error , Try again later";
  static const String CACHE_ERROR = "Cache error, Try again later";
  static const String NO_INTERENT_CONNECTION =
      "Please check your internet connection";
  static const String UNKNOUN = "Something went wrong ,Try again later";
  static const String DEFAULT = "Something went wrong ,Try again later";
}
