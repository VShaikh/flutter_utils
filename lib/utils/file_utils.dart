import 'dart:io';

import 'package:flutter_utils/main.dart';
import 'package:path_provider/path_provider.dart';

bool existsFile(filePath) {
  return File.fromUri(Uri.file(filePath)).existsSync();
}

bool existsFolder(folderPath) {
  return Directory.fromUri(Uri.directory(folderPath)).existsSync();
}

List<String> files(String folderPath) {
// var l = Directory.fromUri(Uri.file(folderPath)).listSync(recursive: true, followLinks: true);
  var l = Directory.fromUri(Uri.file(folderPath)).listSync(recursive: false, followLinks: false);
  return l.map((e) => e.path).where((f) => existsFile(f)).toList(growable: false);
}

List<String> folders(String folderPath) {
  var l = Directory.fromUri(Uri.file(folderPath)).listSync(recursive: false, followLinks: false);
  return l.map((e) => e.path).where((f) => !existsFile(f)).toList(growable: false);
}

String fileContent(String filePath) => existsFile(filePath) ? File.fromUri(Uri.parse(filePath)).readAsStringSync() : "";

void saveContent(String filePath, String contents) => File.fromUri(Uri.parse(filePath)).writeAsStringSync(contents, flush: true);

String encodeItem(String item) {
  return item.replaceAll("/", "~");
}

String decodeItem(String item) {
  return Uri.decodeComponent(item.replaceAll("~", "/"));
}

void ensureFolderCreated(folder) {
  var d = Directory.fromUri(Uri.directory(folder));
  if (!existsFolder(folder)) {
    d.createSync(recursive: true);
    addDebug("Created folder $folder");
  }
}

String joinPath(List<String> text) {
  return text.join(Platform.pathSeparator);
}

Future<List<String>> getAllAndroidRootFolders() async {
  addDebug("Getting all folders from $uRootFolderPath");
  return folders(uRootFolderPath).toList();
}

int getLastModifiedFile(String absPath) {
  return File.fromUri(Uri.file(absPath)).statSync().changed.millisecondsSinceEpoch;
}

int getLastModifiedFolder(String absPath) {
  return Directory.fromUri(Uri.file(absPath)).statSync().modified.millisecondsSinceEpoch;
}

String formatBytes(int bytes) {
  var inKB = bytes / 1024;
  var inMB = inKB / 1024;
  var inGB = inMB / 1024;
  var result = "${inGB.toStringAsFixed(2)} gb";
  if (inGB < 1) {
    result = "${inMB.toStringAsFixed(2)} mb";
  }
  if (inMB < 1) {
    result = "${inKB.toStringAsFixed(2)} kb";
  }
  return result;
}

Future<void> initStoragePath() async {
  var ext = await getExternalStorageDirectory();
  uStoragePath = ext!.path;
  addDebug("Initialized variable for Storage Path: $uStoragePath");
}
