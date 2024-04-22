import 'dart:convert';

class JsonUtils {
  static String jsonString(Object data) => const JsonEncoder.withIndent(' ').convert(data);

  static dynamic jsonDecode(String data) => const JsonDecoder().convert(data);
}
