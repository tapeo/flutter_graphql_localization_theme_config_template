import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppTheme {
  static const double cardRadius = 10.0;
  static const double cardElevation = 0.0;
  static const double maxWidth = 500;
  static const double profileBorderWidth = 10;

  static progressBar({@required BuildContext context}) {
    return Center(
      child: Container(
          decoration: new BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 10,
                )
              ]),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor)),
                    // Container(
                    //   height: 16,
                    // ),
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: <Widget>[
                    //     Flexible(
                    //       child: Text(
                    //         "Caricamento",
                    //         style: TextStyle(fontSize: 21),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  static appBar(
      {BuildContext context,
      String title,
      double titleSpacing,
      List<Widget> actions,
      bool automaticallyImplyLeading,
      PreferredSizeWidget bottom,
      bool alignLeft}) {
    if (titleSpacing == null) {
      titleSpacing = NavigationToolbar.kMiddleSpacing;
    }

    Widget leadingWidget;

    if (automaticallyImplyLeading == null) {
      automaticallyImplyLeading = true;
      leadingWidget = IconButton(
        icon: Icon(FontAwesomeIcons.chevronLeft,
            color: Theme.of(context).primaryColor),
        onPressed: () => Navigator.of(context).pop(),
      );
    }

    return AppBar(
      titleSpacing: titleSpacing,
      brightness: Theme.of(context).brightness,
      elevation: 0,
      backgroundColor: Theme.of(context).accentColor,
      textTheme: TextTheme(
          bodyText1: TextStyle(color: Theme.of(context).primaryColor)),
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      actionsIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: "Pacifico",
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor),
      ),
      actions: actions,
      leading: leadingWidget,
      automaticallyImplyLeading: automaticallyImplyLeading,
      bottom: bottom,
    );
  }
}

final ThemeData kLightGalleryTheme = buildLightTheme();

ThemeData buildLightTheme() {
  const _primary = Color(0xFF000000);
  const _primaryLight = Color(0xFFCCCCCC);
  const _background = Color(0xFFFFFFFF);

  const _primaryColorDark = Color(0xFFFFFFFF);

  TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
        bodyText1: TextStyle(color: _primary),
        bodyText2: TextStyle(color: _primary));
  }

  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: _primary, secondary: _primaryLight, background: _background);

  final ThemeData base = ThemeData(
      brightness: Brightness.light,
      accentColorBrightness: Brightness.light,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(foregroundColor: Colors.white),
      primaryColorLight: _primaryLight,
      colorScheme: colorScheme,
      primaryColor: _primary,
      primaryColorDark: _primaryColorDark,
      buttonColor: _primary,
      dividerColor: _primaryLight,
      indicatorColor: _background,
      toggleableActiveColor: _primary,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: _background,
      canvasColor: _background,
      scaffoldBackgroundColor: _background,
      backgroundColor: Colors.white,
      errorColor: Colors.red,
      cardColor: _background,
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      cardTheme: CardTheme(elevation: 2, color: _background));
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

final ThemeData kDarkGalleryTheme = buildDarkTheme();

ThemeData buildDarkTheme() {
  const _primary = Color(0xFFFFFFFF);
  const _primaryLight = Color(0xFF999999);
  const _background = Color(0xFF000000);

  const _primaryColorDark = Color(0xFF222222);

  TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
        bodyText1: TextStyle(color: _primary),
        bodyText2: TextStyle(color: _primary));
  }

  final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
    primary: _primary,
    secondary: _primaryLight,
    background: _background,
  );

  final ThemeData base = ThemeData(
      appBarTheme: AppBarTheme(
          color: _background,
          iconTheme: IconThemeData(color: _primary),
          textTheme: TextTheme(
              bodyText1: TextStyle(color: _primary),
              bodyText2: TextStyle(color: _primary))),
      primaryColorLight: _primaryLight,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(foregroundColor: Colors.white),
      colorScheme: colorScheme,
      primaryColor: _primary,
      buttonColor: _primary,
      dividerColor: _primaryLight,
      primaryColorDark: _primaryColorDark,
      indicatorColor: _background,
      toggleableActiveColor: _primary,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: _background,
      canvasColor: _background,
      scaffoldBackgroundColor: _background,
      backgroundColor: Colors.white,
      errorColor: Colors.red,
      cardColor: _background,
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.accent,
      ),
      cardTheme: CardTheme(elevation: 2, color: _background));
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}
