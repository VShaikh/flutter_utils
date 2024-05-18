import 'dart:convert';

String jsonString(Object data) =>
    const JsonEncoder.withIndent(' ').convert(data);

dynamic jsonDecode(String data) => const JsonDecoder().convert(data);
