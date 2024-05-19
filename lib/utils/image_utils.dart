import 'package:fc_native_image_resize/fc_native_image_resize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_utils/main.dart';

Future<void> createThumbFromImage(
    String inputPath, String thumbPath, int thumbWidth, int thumbHeight) async {
  assert(existsFile(inputPath));
  String folder = thumbPath.substring(0, thumbPath.lastIndexOf("/") + 1);
  ensureFolderCreated(folder);
  assert(existsFolder(folder));

  final plugin = FcNativeImageResize();

  await plugin.resizeFile(
      srcFile: inputPath,
      destFile: thumbPath,
      width: thumbWidth,
      height: thumbHeight,
      keepAspectRatio: true,
      format: "jpeg",
      quality: 100);
}

localNotFoundImage() => Image.asset('assets/images/notfound.jpg').image;

localNotFoundImageWidget() => Image.asset('assets/images/notfound.png');

void initCacheManager() {
  uCacheManager = DefaultCacheManager();
}

Future<void> deleteThumbsCache() async {
  addDebug("Removing all files from Cache Manager");
  await uCacheManager!.emptyCache();
}
