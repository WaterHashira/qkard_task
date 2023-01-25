import 'package:qkard_task/theme/app_theme.dart';
import 'package:flutter/material.dart' hide ButtonStyle;

extension MyThemeExtension on ThemeData {
  AppStyle get appStyle => extension<AppStyle>()!;
}
