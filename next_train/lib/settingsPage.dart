// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:next_train/db_api.dart';
import 'package:next_train/nextTrain.dart';
import 'package:next_train/translations.dart';
import 'package:provider/provider.dart';
import 'blocs/feliTheme.dart';
import 'restartWidget.dart';
import 'language.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> colorSchemes = [
    'automatic',
    'light',
    'dark',
    'black',
  ];

  List<Language> languages = [
    Languages.automatic,
    Languages.english,
    Languages.traditionalChinese,
    Languages.simplifiedChinese,
  ];
  String _appLanguage = FeliStorageAPI().getLanguage();
  String selectedLanguage = FeliStorageAPI().getLanguage(real: true);
  String systemLanguage = FeliStorageAPI().getSystemLanguage();
  String selectedColorScheme = FeliStorageAPI().getColorScheme();
  List<DropdownMenuItem<String>> colorSchemeDropdownItems;
  List<DropdownMenuItem<String>> languageDropdownItems;
  double preferredThemeElevation =
      FeliStorageAPI().getPreferredThemeElevation();
  bool displayOrderFlipped = FeliStorageAPI().getDisplayOrderFlipped();

  List<DropdownMenuItem<String>> buildColorSchemeDropDownItems(
      List<String> colorSchemes) {
    List<DropdownMenuItem<String>> items = [];

    for (var scheme in colorSchemes) {
      items.add(DropdownMenuItem(
        value: scheme,
        child: Text(Translate.get(scheme)),
      ));
    }
    return items;
  }

  List<DropdownMenuItem<String>> buildlanguageDropDownItems(
      List<Language> colorSchemes) {
    List<DropdownMenuItem<String>> items = [];
    for (var language in languages) {
      items.add(DropdownMenuItem(
        value: language.value,
        child: Text(language.displayName),
      ));
    }
    return items;
  }

  @override
  void initState() {
    if (preferredThemeElevation > 8) preferredThemeElevation = 4;
    if (preferredThemeElevation < 0) preferredThemeElevation = 0;
    languages[0].displayName =
        Translate.translate['automatic'][_appLanguage] + ' ($systemLanguage)';
    colorSchemeDropdownItems = buildColorSchemeDropDownItems(colorSchemes);
    languageDropdownItems = buildlanguageDropDownItems(languages);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final feliTheme = Provider.of<FeliThemeChanger>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.get('settings')),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
              tooltip: Translate.get('back'),
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            constraints: BoxConstraints(maxWidth: 480),
            child: Column(
              children: <Widget>[
                Card(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(Translate.get('color_scheme')),
                            trailing: DropdownButton(
                              // elevation: FeliStorageAPI()
                              //     .getPreferredThemeElevation()
                              //     .ceil(),
                              underline: Container(),
                              value: selectedColorScheme,
                              items: colorSchemeDropdownItems,
                              onChanged: (value) {
                                feliTheme.setTheme();
                                FeliStorageAPI().setColorScheme(value);
                                setState(() {
                                  selectedColorScheme = value;
                                });
                                // RestartWidget.restartApp(context);
                              },
                            ),
                          ),
                          FeliDivider(),
                          ListTile(
                            title: Text(Translate.get('language')),
                            trailing: DropdownButton(
                              // elevation: FeliStorageAPI()
                              //     .getPreferredThemeElevation()
                              //     .ceil(),
                              underline: Container(),
                              value: selectedLanguage,
                              items: languageDropdownItems,
                              onChanged: (value) {
                                FeliStorageAPI().setLanguage(value);
                                feliTheme.setTheme();
                                setState(() {
                                  selectedLanguage = value;
                                  _appLanguage = FeliStorageAPI().getLanguage();
                                  languages[0].displayName =
                                      Translate.translate['automatic']
                                              [_appLanguage] +
                                          ' ($systemLanguage)';

                                  colorSchemeDropdownItems =
                                      buildColorSchemeDropDownItems(
                                          colorSchemes);
                                  languageDropdownItems =
                                      buildlanguageDropDownItems(languages);
                                });
                                // RestartWidget.restartApp(context);
                              },
                            ),
                          ),
                          FeliDivider(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(title: Text(Translate.get('elevation'))),
                              Slider(
                                  label: '$preferredThemeElevation',
                                  divisions: 4 * 4,
                                  value: preferredThemeElevation,
                                  onChanged: (double value) {
                                    setState(() {
                                      preferredThemeElevation = value;
                                    });
                                    FeliStorageAPI().setPreferredThemeElevation(
                                        preferredThemeElevation);
                                    feliTheme.setTheme();
                                  },
                                  min: 0,
                                  max: 4),
                            ],
                          ),
                          FeliDivider(),
                          // ListTile(
                          //   title: Text(Translate.get('reverse_display_order')),
                          //   trailing: Switch(
                          //     activeColor: Theme.of(context).accentColor,
                          //     value: displayOrderFlipped,
                          //     onChanged: (bool value) {
                          //       setState(() {
                          //         displayOrderFlipped = value;
                          //       });
                          //       FeliStorageAPI().setDisplayOrderFlipped(value);
                          //     },
                          //   ),
                          // ),
                          SwitchListTile(
                              title:
                                  Text(Translate.get('reverse_display_order')),
                              value: displayOrderFlipped,
                              onChanged: (bool value) {
                                setState(() {
                                  displayOrderFlipped = value;
                                });
                                FeliStorageAPI().setDisplayOrderFlipped(value);
                              }),
                          AboutListTile(
                            dense: true,
                            applicationVersion: applicationVersion,
                            applicationIcon: Container(
                              constraints: BoxConstraints(maxWidth: 48.0, maxHeight: 48.0),
                              child: Image.network(applicationImage),
                            ),
                          ),


                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: <Widget>[
                          //     SizedBox(width: 16),
                          //     Text(Translate.get('color_scheme'),
                          //         style: Theme.of(context).textTheme.title),
                          //     Expanded(
                          //       flex: 1,
                          //       child: Container(),
                          //     ),
                          //     DropdownButton(
                          //       // elevation: 01,
                          //       value: selectedColorScheme,
                          //       items: colorSchemeDropdownItems,
                          //       onChanged: (value) {
                          //         FeliStorageAPI().setColorScheme(value);
                          //         setState(() {
                          //           selectedColorScheme = value;
                          //         });
                          //         RestartWidget.restartApp(context);
                          //       },
                          //     ),
                          //     SizedBox(width: 16),
                          //   ],
                          // ),
                          // Divider(),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: <Widget>[
                          //     SizedBox(width: 16),
                          //     Text(Translate.get('language'),
                          //         style: Theme.of(context).textTheme.title),
                          //     Expanded(
                          //       flex: 1,
                          //       child: Container(),
                          //     ),
                          //     DropdownButton(
                          //       // elevation: 01,
                          //       value: selectedLanguage,
                          //       items: languageDropdownItems,
                          //       onChanged: (value) {
                          //         FeliStorageAPI().setLanguage(value);

                          //         RestartWidget.restartApp(context);
                          //       },
                          //     ),
                          //     SizedBox(width: 16),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeliDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
    );
  }
}
