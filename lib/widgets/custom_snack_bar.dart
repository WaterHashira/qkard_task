import 'package:qkard_task/theme/theme_extensions.dart';
import 'package:qkard_task/utils/generics.dart';
import 'package:flutter/material.dart';
import 'package:qkard_task/utils/globals.dart';

enum SnackBarType {
  success,
  error,
}

const _defaultSnackBarDuration = Duration(seconds: 2);

void showSuccessSnackBar(
  String? text, {
  Duration duration = _defaultSnackBarDuration,
}) {
  _showSnackBar(
    text,
    duration: duration,
    snackBarType: SnackBarType.success,
  );
}

void showErrorSnackBar(
  String? text, {
  Duration duration = _defaultSnackBarDuration,
}) {
  _showSnackBar(
    text,
    duration: duration,
    snackBarType: SnackBarType.error,
  );
}

Color _getBackgroundColor(SnackBarType snackBarType) {
  final appStyle = Theme.of(Globals.context).appStyle;

  switch (snackBarType) {
    case SnackBarType.success:
      return appStyle.successColor;
    case SnackBarType.error:
      return appStyle.errorColor;
  }
}

void _showSnackBar(
  String? text, {
  required SnackBarType snackBarType,
  Duration duration = _defaultSnackBarDuration,
}) {
  if (isNullOrBlank(text)) return;

  Globals.scaffoldMessengerKey.currentState
    ?..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: Text(text!),
        backgroundColor: _getBackgroundColor(snackBarType),
        clipBehavior: Clip.none,
        padding: const EdgeInsets.all(10),
        duration: duration,
      ),
    );
}
