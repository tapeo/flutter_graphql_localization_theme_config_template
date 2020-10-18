import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AppConfig {
  final bool isDev;
  final String endpoint;
  final String webSocketEndpoint;
  final String adminUid;

  bool admin = false;

  AppConfig(
      {@required this.isDev,
      @required this.endpoint,
      @required this.adminUid,
      @required this.webSocketEndpoint});

  static Future<AppConfig> forEnvironment(String env) async {
    env = env ?? 'prod';

    bool isDev = false;

    if (env != null && env == "dev") {
      isDev = true;
    }

    final contents = await rootBundle.loadString(
      'assets/config/$env.json',
    );

    final json = jsonDecode(contents);

    return AppConfig(
        isDev: isDev,
        endpoint: json['endpoint'],
        adminUid: json['admin_uid'],
        webSocketEndpoint: json['webSocketEndpoint']);
  }
}
