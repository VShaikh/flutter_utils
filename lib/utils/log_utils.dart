import 'dart:developer';

import 'package:flutter_utils/main.dart';

void disableLog() {
  uEnableLog = false;
  addDebug("All logs are disabled");
}

void addDebug(String text) {
  if (uEnableLog) log("[${DateTime.now().toString()}] \t : $text");
}
