import 'package:flutter_utils/main.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

Future<void> createThumbFromVideo(String videoPath, String thumbPath, int thumbWidth, int thumbHeight) async {
  addDebug("Creating thumbnail from video\n \t\t$videoPath \n \t\t $thumbPath");
  assert(existsFile(videoPath));
  String folder = thumbPath.substring(0, thumbPath.lastIndexOf("/") + 1);
  ensureFolderCreated(folder);
  assert(existsFolder(folder));

  await VideoThumbnail.thumbnailFile(
    video: videoPath,
    thumbnailPath: thumbPath,
    imageFormat: ImageFormat.PNG,
    quality: 100,
    maxWidth: thumbWidth,
    maxHeight: thumbHeight,
  );
}
