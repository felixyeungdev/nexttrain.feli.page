import 'db_api.dart';

class Language {
  String value;
  String displayName;
  Language(this.value, this.displayName);
}

class Languages {
  static Language english = Language('en', 'English');
  static Language traditionalChinese = Language('tc', '繁體中文');
  static Language simplifiedChinese = Language('sc', '简体中文');
  static Language automatic = Language('auto', 'Automatic');
}
