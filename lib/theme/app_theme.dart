import 'package:flutter/material.dart';

part 'app_style.dart';

class AppTheme {
  const AppTheme._();

  static const _designFileWidth = 375;
  static final _deviceWidth = MediaQueryData.fromWindow(
    WidgetsBinding.instance.window,
  ).size.width;

  static double getAdaptiveSize(double size) =>
      size * _deviceWidth / _designFileWidth;

  static const _defaultElevation = 2.5;
  static const _defaultFontFamily = 'Manrope';

  static ThemeData _baseTheme(
    Brightness brightness, {
    Color? textColor,
    Color? accentColor,
    Color? onAccentColor,
    Color? scaffoldBackgroundColor,
  }) {
    late final ColorScheme defaultColorScheme;

    switch (brightness) {
      case Brightness.light:
        defaultColorScheme = const ColorScheme.light();
        textColor ??= Colors.black;
        break;
      case Brightness.dark:
        defaultColorScheme = const ColorScheme.dark();
        textColor ??= Colors.white;
        break;
    }

    final iconThemeData = IconThemeData(color: accentColor);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: _defaultFontFamily,
      iconTheme: iconThemeData,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: _defaultElevation,
        color: Colors.transparent,
        iconTheme: iconThemeData.copyWith(color: textColor),
        actionsIconTheme: iconThemeData,
        titleTextStyle: TextStyle(
          color: textColor,
          fontFamily: _defaultFontFamily,
          fontWeight: FontWeight.w500,
          fontSize: getAdaptiveSize(20),
        ),
      ),
      colorScheme: defaultColorScheme.copyWith(
        brightness: brightness,
        primary: accentColor,
        onPrimary: onAccentColor ?? textColor,
      ),
      toggleableActiveColor: accentColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: accentColor,
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: _defaultFontFamily,
            fontSize: getAdaptiveSize(16),
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          onPrimary: textColor,
          padding: const EdgeInsets.all(10),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          textStyle: const TextStyle(
            fontSize: 17,
            fontFamily: _defaultFontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      dialogTheme: DialogTheme(
        elevation: 10,
        backgroundColor: scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      splashFactory: InkSparkle.splashFactory,
      bottomSheetTheme: BottomSheetThemeData(
        modalElevation: 10,
        backgroundColor: scaffoldBackgroundColor,
        modalBackgroundColor: scaffoldBackgroundColor,
      ),
      snackBarTheme: SnackBarThemeData(
        elevation: _defaultElevation,
        contentTextStyle: TextStyle(
          fontSize: getAdaptiveSize(14),
          fontWeight: FontWeight.w500,
          fontFamily: _defaultFontFamily,
          color: textColor,
        ),
      ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
          TargetPlatform.values,
          value: (_) => const CupertinoPageTransitionsBuilder(),
        ),
      ),
    );
  }

  static final darkTheme = _baseTheme(
    Brightness.dark,
    accentColor: const Color(0xFF3A96FF),
    onAccentColor: Colors.black,
    scaffoldBackgroundColor: const Color(0xFF000000),
  ).copyWith(
    extensions: <ThemeExtension>{
      AppStyle._darkTheme(),
    },
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF111111),
      elevation: _defaultElevation,
      selectedItemColor: const Color(0xFF3A96FF),
      unselectedItemColor: const Color(0xFF707070),
      selectedLabelStyle: TextStyle(
        fontSize: getAdaptiveSize(11),
        color: const Color(0xFF3A96FF),
        fontFamily: _defaultFontFamily,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: getAdaptiveSize(11),
        color: const Color(0xFF707070),
        fontFamily: _defaultFontFamily,
      ),
      type: BottomNavigationBarType.fixed,
    ),
    dividerTheme: DividerThemeData(
      color: const Color(0xFFFFFFFF).withOpacity(0.6),
      space: 1,
      thickness: 0.25,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: getAdaptiveSize(20),
        color: const Color(0xFFFFFFFF),
        fontFamily: _defaultFontFamily,
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(
        fontSize: getAdaptiveSize(18),
        color: const Color(0xFFFFFFFF),
        fontFamily: _defaultFontFamily,
        fontWeight: FontWeight.w600,
      ),
      headline3: TextStyle(
        fontSize: getAdaptiveSize(16),
        fontFamily: _defaultFontFamily,
        color: const Color(0xFFFFFFFF).withOpacity(0.8),
        fontWeight: FontWeight.w500,
      ),
      headline4: TextStyle(
        fontSize: getAdaptiveSize(16),
        fontFamily: _defaultFontFamily,
        color: const Color(0xFFFFFFFF),
        fontWeight: FontWeight.w500,
      ),
      headline5: TextStyle(
        fontSize: getAdaptiveSize(14),
        fontFamily: _defaultFontFamily,
        color: const Color(0xFFFFFFFF),
        fontWeight: FontWeight.w400,
      ),
      headline6: TextStyle(
        fontSize: getAdaptiveSize(12),
        fontFamily: _defaultFontFamily,
        color: const Color(0xFFFFFFFF).withOpacity(0.8),
        fontWeight: FontWeight.w400,
      ),
      button: TextStyle(
        fontSize: getAdaptiveSize(16),
        fontFamily: _defaultFontFamily,
        color: const Color(0xFFFFFFFF),
        fontWeight: FontWeight.w600,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF181818),
      prefixIconColor: const Color(0xFFFFFFFF).withOpacity(0.3),
      errorStyle: const TextStyle(
        fontFamily: _defaultFontFamily,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.all(10),
      hintStyle: TextStyle(
        fontFamily: _defaultFontFamily,
        color: const Color(0xFFFFFFFF).withOpacity(0.3),
        fontSize: getAdaptiveSize(14),
        fontWeight: FontWeight.w500,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: const BorderSide(
          width: 0.5,
          color: Color(0xFF2C2C2C),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: const BorderSide(
          width: 0.75,
          color: Color(0xFF2C2C2C),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: const BorderSide(
          width: 0.5,
          color: Color(0xFF863636),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: const BorderSide(
          width: 1,
          color: Color(0xFF863636),
        ),
      ),
    ),
  );
}
