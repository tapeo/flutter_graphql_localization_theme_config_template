import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    Map<String, dynamic> jsonMap;

    try {
      String jsonString = await rootBundle
          .loadString('assets/i18n/${locale.languageCode}.json');
      jsonMap = json.decode(jsonString);
    } catch (e) {
      String jsonString = await rootBundle.loadString('assets/i18n/en.json');
      jsonMap = json.decode(jsonString);
    }

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    try {
      if (_localizedStrings.containsKey(key)) {
        return _localizedStrings[key];
      } else {
        return key;
      }
    } catch (e) {
      print(e);
      return key;
    }
  }

  Map<String, String> map() {
    return _localizedStrings;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'it'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
