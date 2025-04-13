// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ErrorClass implements Exception {
  int? _errorCode;
  final String _errorMessage = "";

  ErrorClass.withError({error}) {
    if (error is DioException) {
      _handleError(error);
    }
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioException error) {
    if (error.response != null) {
      if (error.response!.statusCode == 401) {
        return Fluttertoast.showToast(
            msg: error.response!.data['message'] ??
                "Error: 401 Unauthenticated".toString());
      } else if (error.type == DioExceptionType.badResponse) {
        if (kDebugMode) {
          print((error.response!.data['msg'] ?? error.response!.data['message'])
              .toString());
        }
        if (error.response!.data['errors'] != null) {
          return Fluttertoast.showToast(
              msg: error.response!.data['errors'].values.first[0].toString());
        }
        return Fluttertoast.showToast(
            msg:
                (error.response!.data['msg'] ?? error.response!.data['message'])
                    .toString());
      } else if (error.type == DioExceptionType.unknown) {
        if (kDebugMode) {
          print(error.response!.data['message'].toString());
        }
        return Fluttertoast.showToast(
            msg: error.response!.data['message'].toString());
      } else if (error.type == DioExceptionType.cancel) {
        if (kDebugMode) {
          print(error.response!.data['message'].toString());
        }
        return Fluttertoast.showToast(msg: 'Request was cancelled');
      } else if (error.type == DioExceptionType.connectionError) {
        if (kDebugMode) {
          print(error.response!.data['message'].toString());
        }
        return Fluttertoast.showToast(
            msg: 'Connection failed. Please check internet connection');
      } else if (error.type == DioExceptionType.connectionTimeout) {
        if (kDebugMode) {
          print(error.response!.data['message'].toString());
        }
        return Fluttertoast.showToast(msg: 'Connection timeout');
      } else if (error.type == DioExceptionType.badCertificate) {
        if (kDebugMode) {
          print(error.response!.data['message'].toString());
        }
        return Fluttertoast.showToast(
            msg: '${error.response!.data['message']}');
      } else if (error.type == DioExceptionType.receiveTimeout) {
        if (kDebugMode) {
          print(error.response!.data['message'].toString());
        }
        return Fluttertoast.showToast(msg: 'Receive timeout in connection');
      } else if (error.type == DioExceptionType.sendTimeout) {
        if (kDebugMode) {
          print(error.response!.data['message'].toString());
        }
        return Fluttertoast.showToast(msg: 'Receive timeout in send request');
      }
      return _errorMessage;
    } else {
      return Fluttertoast.showToast(msg: error.toString());
    }
  }
}
