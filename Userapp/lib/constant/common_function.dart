import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eventright_pro_user/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart' as date_lib;
import 'package:timezone/timezone.dart';

class CommonFunction {
  static Future<bool> checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      toastMessage("No Internet Connection");
      return false;
    }
  }

  static toastMessage(String msg) {
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: AppColors.primaryColor, textColor: Colors.white, fontSize: 16.0);
  }

  static String shortMonthName(String date) {
    DateTime dateTime = DateTime.parse(date);
    final DateFormat format = DateFormat("MMM dd, yyyy");
    final String formatted = format.format(dateTime);
    return formatted;
  }

  static convertLocalToDetroit(String timeZone, String date) {
    DateTime dateTime = DateTime.parse(date);
    var detroitTime = TZDateTime.from(dateTime, getLocation(timeZone));
    var dateFormat = date_lib.DateFormat("h:mm a");
    return dateFormat.format(detroitTime);
  }
}

class MyConnectivity {
  MyConnectivity._internal();

  static final MyConnectivity _instance = MyConnectivity._internal();

  static MyConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else {
        isOnline = false;
      }
    } on SocketException catch (_) {
      isOnline = false;
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();
}
