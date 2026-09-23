import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_utils/utils/log_utils.dart';
import 'package:toastification/toastification.dart';

void toast(level, icon, message, {type = ToastificationType.success}) {
  addDebug(message);
  // if (isAndroid() || kIsWeb) {
  toastification.show(
    description: RichText(
      text: TextSpan(
        text: message,
        style: const TextStyle(color: CupertinoColors.black),
      ),
    ),
    title: Text(level),
    type: type,
    style: ToastificationStyle.flatColored,
    autoCloseDuration: const Duration(seconds: 1),
    alignment: Alignment.bottomCenter,
    animationDuration: const Duration(milliseconds: 200),
    icon: Icon(icon),
    showIcon: true,
    pauseOnHover: false,
    dragToClose: true,
    backgroundColor: CupertinoColors.black.withValues(alpha: 0.24),
    // applyBlurEffect: true,
  );
  // }
}

void toastInfo(message) {
  toast('Information', CupertinoIcons.info, message, type: ToastificationType.success);
}

void toastWarn(message) {
  toast('Warning', CupertinoIcons.exclamationmark_triangle, message, type: ToastificationType.warning);
}

void toastError(message) {
  toast('Error', CupertinoIcons.xmark_circle, message, type: ToastificationType.error);
}

void configureFlutterErrorHandling() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('An error occurred')),
      child: Center(child: Text(details.toString())),
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
