import 'dart:convert';
import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

const favouritesString = 'favourites';
const colorScheme = 'colorScheme';
const languageString = 'language';
const systemLanguageString = 'systemLanguage';
const preferredThemeElevation = 'preferredCardElevation';
const displayOrderFlipped = 'displayOrderFlipped';
const configBox = 'configBox';

final box = Hive.box(configBox);

class FeliStorageAPI {
  String getLanguage({real = false}) {
    String lang = box.get(languageString, defaultValue: 'auto');
    if (!real && (lang == 'auto')) lang = this.getSystemLanguage();

    return lang;
  }

  setLanguage(String language) {
    box.put(languageString, language);
  }

  String getSystemLanguage() {
    return box.get(systemLanguageString, defaultValue: 'en');
  }

  setSystemLanguage(String language) {
    box.put(systemLanguageString, language);
  }

  String getColorScheme() {
    return box.get(colorScheme, defaultValue: 'automatic');
  }

  setColorScheme(String scheme) {
    box.put(colorScheme, scheme);
  }
  bool getDisplayOrderFlipped() {
    return box.get(displayOrderFlipped, defaultValue: false);
  }

  setDisplayOrderFlipped(bool scheme) {
    box.put(displayOrderFlipped, scheme);
  }

  double getPreferredThemeElevation() {
    return box.get(preferredThemeElevation, defaultValue: 0.0);
  }

  setPreferredThemeElevation(double scheme) {
    box.put(preferredThemeElevation, scheme);
  }

  getStorage() {
    return box.get(favouritesString, defaultValue: '[]') ?? '[]';
  }

  List getFavouriteStations() {
    var favString = this.getStorage();
    // String favString = await storage.getItem('favouriteStations') ?? '[]';
    List favList = json.decode(favString) ?? '[]';

    return favList;
  }

  saveFavouriteStation(String lineStation) {
    List favourites = this.getFavouriteStations();
    if (favourites == null) favourites = [];
    if (!favourites.contains(lineStation)) {
      favourites.add(lineStation);
    }
    box.put(favouritesString, json.encode(favourites));
    // storage.setItem('favouriteStations', json.encode(favourites));
    return true;
    // myFile.writeAsStringSync(json.encode(favourites));
    // return true;
  }

  removeFavouriteStation(String lineStation) {
    List favourites = this.getFavouriteStations();
    if (favourites.contains(lineStation)) {
      favourites.remove(lineStation);
    }
    // LocalStorage storage = this.getStorage();
    // storage.setItem('favouriteStations', json.encode(favourites));
    box.put(favouritesString, json.encode(favourites));

    return true;
  }
}
