import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utils/utils/log_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast(message,
    {fontSize = 16.0, bgColor = Colors.blue, textColor = Colors.white}) {
  addDebug(message);
  if (isAndroid() || kIsWeb) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: bgColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
}

void configureFlutterErrorHandling() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red.withOpacity(0.5),
          title: const Text('An error occurred')),
      body: Center(child: Text(details.toString())),
    );
  };
}

bool isAndroid() {
  if (kIsWeb) {
    return false;
  } else {
    return Platform.isAndroid;
  }
}

bool isLinux() {
  if (kIsWeb) {
    return false;
  } else {
    return Platform.isLinux;
  }
}
