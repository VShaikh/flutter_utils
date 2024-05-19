import 'package:flutter_utils/main.dart';

class AppConfigs {
  init() async {
    await LocalConfigStorage.getInstance().init(Map.fromIterable(
        AppConfig.values.map((e) => MapEntry(e.name, e.value))));
  }

  bool getBool(AppConfig appConfig) {
    return LocalConfigStorage.getInstance().getBool(appConfig.name);
  }

  int getInt(AppConfig appConfig) {
    return LocalConfigStorage.getInstance().getInt(appConfig.name);
  }

  String getString(AppConfig appConfig) {
    return LocalConfigStorage.getInstance().getString(appConfig.name);
  }
}

enum AppConfig {
  isAutoHttpServerStart(true),
  isNotificationEnabled(false),
  serverHost("0.0.0.0"),
  serverPort(8192);

  final dynamic value;

  const AppConfig(this.value);
}

class Test {
  void main() {
    // AppConfig.isAutoHttpServerStart;
  }
}
