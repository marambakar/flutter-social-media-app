import 'package:flutter/cupertino.dart';

class AppLocale{
  Locale locale;
  String token;
  static final AppLocale _singleton = AppLocale._internal();

  BuildContext context;

  factory AppLocale() {
    return _singleton;
  }

  AppLocale._internal();
}