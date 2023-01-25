import 'package:flutter/material.dart';

class Globals {
  Globals._();

  // is not null only if app was opened with a referral link..
  static String? referralCode;

  static final navigatorKey = GlobalKey<NavigatorState>();

  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static BuildContext get context => navigatorKey.currentContext!;
}
