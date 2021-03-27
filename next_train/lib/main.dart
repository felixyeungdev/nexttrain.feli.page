import 'package:flutter/material.dart';
import 'package:next_train/aboutPage.dart';
import 'package:next_train/blocs/feliTheme.dart';
import 'package:next_train/cardShape.dart';
import 'package:next_train/db_api.dart';
import 'package:next_train/lines.dart';
import 'package:next_train/settingsPage.dart';
import 'package:provider/provider.dart';
// import 'package:next_train/db_api.dart';
import 'home.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hexColor.dart' show HexColor;
import 'restartWidget.dart';
import 'showData.dart';
import 'translations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const configBox = 'configBox';
// const refreshRate = 'refreshRateBox';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(configBox);
  // await Hive.openBox(refreshRate);

  runApp(MyApp());
}

Color feliOrange = HexColor('#f9a825');

ThemeData feliTheme = ThemeData(
  cardTheme: CardTheme(elevation: 0.0, shape: feliCardShape),
  accentColor: feliOrange,
  secondaryHeaderColor: feliOrange,
  primaryColor: Colors.white,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: feliOrange, elevation: 0.0),
  textTheme: TextTheme(title: TextStyle(color: feliOrange)),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, Widget Function(BuildContext)> routes() {
      Map<String, Widget Function(BuildContext)> result = {
        '/home/': (context) => MyHome(),
        '/settings/': (context) => SettingsPage(),
        '/about/': (context) => AboutPage(),
      };
      lines.forEach((line) {
        String ln = line.line;
        line.stations.forEach((station) {
          String sta = station.sta;
          result['/showData/?line=$ln&station=$sta'] =
              (context) => ShowData(ln, sta);
        });
      });
      return result;
    }

    ThemeData lightTheme = ThemeData(
      appBarTheme: AppBarTheme(elevation: 0.0),
      colorScheme: ColorScheme.light(primary: feliOrange),
      cardTheme: CardTheme(elevation: 0.0, shape: feliCardShape),
      accentColor: feliOrange,
      secondaryHeaderColor: feliOrange,
      primaryColor: Colors.white,
      brightness: Brightness.light,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: feliOrange,
        elevation: 0.0,
        focusElevation: 0.0,
        highlightElevation: 0.0,
      ),
      textTheme: TextTheme(headline6: TextStyle(color: feliOrange)),
    );

    ThemeData darkTheme = ThemeData(
      appBarTheme: AppBarTheme(elevation: 0.0),
      bottomAppBarColor: Colors.grey.withAlpha(12),
      colorScheme: ColorScheme.dark(primary: feliOrange),
      cardTheme: CardTheme(elevation: 0.0, shape: feliCardShape),
      accentColor: feliOrange,
      secondaryHeaderColor: feliOrange,
      brightness: Brightness.dark,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: feliOrange,
        elevation: 0.0,
        focusElevation: 0.0,
        highlightElevation: 0.0,
      ),
      textTheme: TextTheme(headline6: TextStyle(color: feliOrange)),
    );

    ThemeData blackTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(elevation: 0.0, color: Colors.black),
      bottomAppBarColor: Colors.grey.withAlpha(32),
      colorScheme: ColorScheme.dark(primary: feliOrange),
      cardTheme: CardTheme(
          elevation: 0.0, color: Colors.white10, shape: feliCardShape),
      accentColor: feliOrange,
      secondaryHeaderColor: feliOrange,
      brightness: Brightness.dark,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: feliOrange,
        elevation: 0.0,
        focusElevation: 0.0,
        highlightElevation: 0.0,
      ),
      textTheme: TextTheme(headline6: TextStyle(color: feliOrange)),
      dialogBackgroundColor: Colors.grey.shade900,
    );

    ThemeData getTheme(String defaultScheme) {
      String preferredScheme = FeliStorageAPI().getColorScheme();

      switch (preferredScheme) {
        case 'automatic':
          return defaultScheme == 'light' ? lightTheme : darkTheme;
        case 'light':
          return lightTheme;
        case 'dark':
          return darkTheme;
        case 'black':
          return blackTheme;
          break;
        default:
      }
      return darkTheme;
    }

    // final feliTheme = Provider.of<FeliThemeChanger>(context);

    return ChangeNotifierProvider<FeliThemeChanger>(
      create: (_) => FeliThemeChanger(),
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
        Map<String, Widget Function(BuildContext)> routes() {
      Map<String, Widget Function(BuildContext)> result = {
        '/home/': (context) => MyHome(),
        '/settings/': (context) => SettingsPage(),
        '/about/': (context) => AboutPage(),
      };
      lines.forEach((line) {
        String ln = line.line;
        line.stations.forEach((station) {
          String sta = station.sta;
          result['/showData/?line=$ln&station=$sta'] =
              (context) => ShowData(ln, sta);
        });
      });
      return result;
    }

    final feliTheme = Provider.of<FeliThemeChanger>(context);
    return MaterialApp(
      supportedLocales: [
        Locale('en'),
        Locale('zh', 'HK'),
        Locale('zh', 'TW'),
        Locale('zh', 'CN'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (Locale locale, supportedLocales) {
        switch (locale.languageCode) {
          case 'en':
            FeliStorageAPI().setSystemLanguage('en');
            return locale;
            break;
          case 'zh':
            if (locale.countryCode == 'CN') {
              FeliStorageAPI().setSystemLanguage('sc');
              return locale;
            } else if (locale.countryCode == 'HK' ||
                locale.countryCode == 'TW') {
              FeliStorageAPI().setSystemLanguage('tc');
              return locale;
            }
            break;
          default:
        }
        FeliStorageAPI().setSystemLanguage('en');
        return supportedLocales.first;
      },
      theme: feliTheme.getTheme('light'),
      darkTheme: feliTheme.getTheme('dark'),
      title: Translate.get('next_train'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home/',
      routes: routes(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => MyHome());
      },
    );
  }
}
