import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utils/utils/log_utils.dart';
import 'package:toastification/toastification.dart';

void toast(level, icon, message, {type = ToastificationType.success}) {
  addDebug(message);
  // if (isAndroid() || kIsWeb) {
    toastification.show(
      description: RichText(text: TextSpan(text: message)),
      title: Text(level),
      type: type,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.bottomCenter,
      animationDuration: const Duration(milliseconds: 500),
      icon: Icon(icon),
      showIcon: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
    );
  // }
}

void toastInfo(message) {
  toast('Information', Icons.info, message, type: ToastificationType.success);
}

void toastWarn(message) {
  toast('Warning', Icons.warning, message, type: ToastificationType.warning);
}

void toastError(message) {
  toast('Error', Icons.error, message, type: ToastificationType.error);
}

void configureFlutterErrorHandling() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red.withOpacity(0.5), title: const Text('An error occurred')),
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
