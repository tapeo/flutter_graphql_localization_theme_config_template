import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_graphql_localization_theme_config_template/main.dart';

class Functions {
  static Future<String> _call(
    User user, {
    @required String functionName,
    var body,
  }) async {
    var url =
        'https://us-central1-massimobanchell.cloudfunctions.net/$functionName';
    var response = await http.post(url, body: body);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response.body;
  }

  static Future<String> callEurope(
    User user, {
    @required String functionName,
    @required var body,
  }) async {
    var url =
        'https://europe-west1-massimobanchell.cloudfunctions.net/$functionName';
    var response = await http.post(url, body: body);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response.body;
  }

  Future registerClaim(User currentUser) async {
    try {
      var body = {'uid': currentUser.uid};

      if (currentUser.uid == environment.adminUid) {
        await _call(currentUser, functionName: "register_admin", body: body);
        environment.admin = true;
      } else {
        await _call(currentUser, functionName: "register_user", body: body);
        environment.admin = false;
      }
    } catch (e) {
      print(e);
    }
  }
}
