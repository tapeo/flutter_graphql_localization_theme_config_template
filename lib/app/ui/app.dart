import 'package:flutter/material.dart';
import 'package:flutter_graphql_localization_theme_config_template/app/provider/auth_provider.dart';
import 'package:flutter_graphql_localization_theme_config_template/theme/button.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome"),
              RaisedButton(
                child: Text("logout"),
                onPressed: () async {
                  await Provider.of<AuthProvider>(context, listen: false)
                      .signOut();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
