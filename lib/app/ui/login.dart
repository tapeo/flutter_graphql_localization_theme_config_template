import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graphql_localization_theme_config_template/app/provider/auth_provider.dart';
import 'package:flutter_graphql_localization_theme_config_template/theme/button.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("App"),
              RaisedButton(
                child: Text("login"),
                onPressed: () async {
                  await Provider.of<AuthProvider>(context, listen: false)
                      .signInGoogle();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
