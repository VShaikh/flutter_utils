import 'package:get_time_ago/get_time_ago.dart';

String formatDuration(int input) {
  var inSec = (input) / 1;
  var inMin = inSec / 60;
  var inHr = inMin / 60;
  var result = "${inHr.toStringAsFixed(2)} hr";
  if (inHr < 1) {
    result = "${inMin.toStringAsFixed(2)} min";
  }
  if (inMin < 1) {
    result = "${inSec.toStringAsFixed(2)} sec";
  }
  return result;
}

String formatMilliSecSinceEpoc(String ms) {
  var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(ms));
  return GetTimeAgo.parse(dt);
}

String formatMilliSec(String ms) {
  var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(ms));
  return GetTimeAgo.parse(dt);
}
