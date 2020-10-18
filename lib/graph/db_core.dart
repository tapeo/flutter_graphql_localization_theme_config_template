import 'package:flutter_graphql_localization_theme_config_template/main.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DbCore {
  static final HttpLink httpLink = HttpLink(uri: environment.endpoint);

  static WebSocketLink websocketLink;
  static AuthLink authLink;

  static bool initialized = false;
  static String token;

  static _init(String token) {
    websocketLink = WebSocketLink(
        url: environment.webSocketEndpoint,
        config: SocketClientConfig(
            autoReconnect: true,
            inactivityTimeout: Duration(seconds: 30),
            initPayload: () => {
                  "headers": {"Authorization": 'Bearer ' + token}
                }));

    authLink = AuthLink(
      getToken: () async => 'Bearer ' + token,
    );

    DbCore.initialized = true;
    DbCore.token = token;
  }

  static GraphQLClient getClient(String token) {
    if (!initialized || DbCore.token == null || DbCore.token != token) {
      _init(token);
    }

    final Link link = authLink.concat(httpLink).concat(websocketLink);

    return GraphQLClient(
      link: link,
      cache: InMemoryCache(),
    );
  }
}
