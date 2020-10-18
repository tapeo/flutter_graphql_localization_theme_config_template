import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_graphql_localization_theme_config_template/app_config.dart';
import 'package:flutter_graphql_localization_theme_config_template/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_graphql_localization_theme_config_template/theme/theme.dart';
import 'package:flutter_graphql_localization_theme_config_template/ui/app_view.dart';
import 'package:flutter_graphql_localization_theme_config_template/ui/login/login_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:timeago/timeago.dart' as timeago;

AppConfig environment;
bool logged;
String detailIdOpened;

Future<void> main({String env}) async {
  WidgetsFlutterBinding.ensureInitialized();

  environment = await AppConfig.forEnvironment(env);

  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  logged = prefs.getBool("logged") ?? false;

  await initializeDateFormatting();

  FlutterError.onError = (FlutterErrorDetails details) {
    if (environment.isDev) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  runApp(AppContainer());
}

class AppContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!environment.isDev) {
      ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
        return getErrorWidget(context, errorDetails);
      };
    }

    print("endpoint: ${environment.endpoint}");

    return OverlaySupport(
      child: MaterialApp(
        title: "Studio Legale Banchelli",
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: kIsWeb ? NoGlow() : ScrollBehavior(),
            child: child,
          );
        },
        debugShowCheckedModeBanner: false,
        home: AppWithStatusColor(),
        theme: kLightGalleryTheme,
        darkTheme: kLightGalleryTheme,
      ),
    );
  }
}

class AppWithStatusColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget widget;

    print("logged: $logged");

    if (logged) {
      widget = AppView();
    } else {
      widget = LoginView();
    }

    if (!kIsWeb && Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.white, statusBarBrightness: Brightness.dark));
    }

    return widget;
  }
}

class NoGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            AppLocalizations.of(context).translate("generic_error"),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    ),
    theme: kLightGalleryTheme,
    darkTheme: kLightGalleryTheme,
  );
}
