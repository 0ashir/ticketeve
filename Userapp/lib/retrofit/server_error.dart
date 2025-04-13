// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ServerError implements Exception {
  int? _errorCode;
  final String _errorMessage = "";

  ServerError.withError({error}) {
    _handleError(error);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioException error) {
    if(error.response !=null){
    if (error.type == DioExceptionType.badResponse) {
      return Fluttertoast.showToast(
          msg: error.response!.data['message'].toString());
    } else if (error.type == DioExceptionType.unknown) {
      return Fluttertoast.showToast(
          msg: error.response != null
              ? error.response!.data['message'].toString()
              : error.toString());
    } else if (error.type == DioExceptionType.cancel) {
      return Fluttertoast.showToast(msg: 'Request was cancelled');
    } else if (error.type == DioExceptionType.connectionError) {
      return Fluttertoast.showToast(
          msg: 'Connection failed. Please check internet connection');
    } else if (error.type == DioExceptionType.connectionTimeout) {
      return Fluttertoast.showToast(msg: 'Connection timeout');
    } else if (error.type == DioExceptionType.badCertificate) {
      if (kDebugMode) {
        print(error.response!.data['message'].toString());
      }
      return Fluttertoast.showToast(msg: '${error.response!.data['message']}');
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return Fluttertoast.showToast(msg: 'Receive timeout in connection');
    } else if (error.type == DioExceptionType.sendTimeout) {
      return Fluttertoast.showToast(msg: 'Receive timeout in send request');
    } else if (error.response!.statusCode == 401) {
      return Fluttertoast.showToast(
          msg: error.response!.data['message'] ??
              "Error: 401 Unauthenticated".toString());
    }
    return _errorMessage;
  }else{
      return Fluttertoast.showToast(
          msg: error.toString());
  }}
}
