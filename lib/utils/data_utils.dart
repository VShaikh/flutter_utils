bool parseBool(String val) {
  return val == 'true' ? true : false;
}

int parseInt(String val) {
  return int.parse(val);
}

bool isNumeric(String s) {
  return double.parse(s) != null;
}
