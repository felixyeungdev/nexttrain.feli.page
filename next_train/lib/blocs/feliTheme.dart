import 'package:flutter/material.dart';
import 'package:next_train/cardShape.dart';
import 'package:next_train/db_api.dart';
import 'package:next_train/hexColor.dart';
import 'package:flutter/services.dart';

Color feliOrange = HexColor('#f9a825');

class FeliThemeChanger with ChangeNotifier {
  ThemeData get lightTheme => ThemeData(
        platform: TargetPlatform.android,
        popupMenuTheme: PopupMenuThemeData(color: Colors.grey.shade200),
        appBarTheme: AppBarTheme(elevation: preferredThemeElevation),
        colorScheme: ColorScheme.light(primary: feliOrange),
        bottomAppBarTheme:
            BottomAppBarTheme(elevation: preferredThemeElevation),
        cardTheme:
            CardTheme(elevation: preferredThemeElevation, shape: feliCardShape),
        accentColor: feliOrange,
        secondaryHeaderColor: feliOrange,
        primaryColor: feliOrange,
        brightness: Brightness.light,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: feliOrange,
          elevation: preferredThemeElevation,
          focusElevation: preferredThemeElevation * 1.25,
          highlightElevation: preferredThemeElevation * 1.5,
        ),
        textTheme: TextTheme(headline6: TextStyle(color: feliOrange)),
      );

  ThemeData get darkTheme => ThemeData(
        platform: TargetPlatform.android,
        popupMenuTheme: PopupMenuThemeData(color: Colors.grey.shade700),
        appBarTheme: AppBarTheme(elevation: preferredThemeElevation),
        bottomAppBarColor: Colors.grey.withAlpha(12),
        bottomAppBarTheme:
            BottomAppBarTheme(elevation: preferredThemeElevation),
        colorScheme: ColorScheme.dark(primary: feliOrange),
        cardTheme:
            CardTheme(elevation: preferredThemeElevation, shape: feliCardShape),
        accentColor: feliOrange,
        secondaryHeaderColor: feliOrange,
        brightness: Brightness.dark,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: feliOrange,
          elevation: preferredThemeElevation,
          focusElevation: preferredThemeElevation * 1.25,
          highlightElevation: preferredThemeElevation * 1.5,
        ),
        textTheme: TextTheme(headline6: TextStyle(color: feliOrange)),
      );

  ThemeData get blackTheme => ThemeData(
        platform: TargetPlatform.android,
        popupMenuTheme: PopupMenuThemeData(color: Colors.grey.shade900),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
            elevation: preferredThemeElevation,
            color: Colors.black.withAlpha(25)),
        bottomAppBarColor: Colors.grey.withAlpha(32),
        bottomAppBarTheme:
            BottomAppBarTheme(elevation: preferredThemeElevation),
        colorScheme: ColorScheme.dark(primary: feliOrange),
        cardTheme: CardTheme(
            elevation: preferredThemeElevation,
            color: Colors.white10,
            shape: feliCardShape),
        accentColor: feliOrange,
        secondaryHeaderColor: feliOrange,
        brightness: Brightness.dark,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: feliOrange,
          elevation: preferredThemeElevation,
          focusElevation: preferredThemeElevation * 1.25,
          highlightElevation: preferredThemeElevation * 1.5,
        ),
        textTheme: TextTheme(headline6: TextStyle(color: feliOrange)),
        dialogBackgroundColor: Colors.grey.shade900,
      );

  double get preferredThemeElevation {
    return FeliStorageAPI().getPreferredThemeElevation();
  }

  FeliThemeChanger();

  setTheme() {
    notifyListeners();
  }

  ThemeData getTheme(String defaultScheme) {
    String preferredScheme = FeliStorageAPI().getColorScheme();

    switch (preferredScheme) {
      case 'automatic':
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        return defaultScheme == 'light' ? lightTheme : darkTheme;
      case 'light':
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
        return lightTheme;
      case 'dark':
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        return darkTheme;
      case 'black':
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        return blackTheme;
        break;
      default:
    }
    return darkTheme;
  }
}
