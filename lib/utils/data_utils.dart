bool parseBool(String val) {
  return val == 'true' ? true : false;
}

int parseInt(String val) {
  return int.parse(val);
}

bool isNumeric(String s) {
  return double.parse(s) != null;
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
