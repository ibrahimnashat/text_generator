import 'package:text_generator/names.dart';

class TextMapBuilder {
  /// Texts Map
  late Map<String, String> _textsMap;

  Names names = Names();

  /// Texts Map Getter
  Map<String, String> get textsMap => _textsMap;

  TextMapBuilder() {
    _textsMap = {};
  }

  /// Builds a Map from a List of String(s) with a value of String and key of
  /// a generated name text{number}
  void generateTextMap(Set<String> texts) {
    for (int i = 0; i < texts.length; i++) {
      String key = texts.elementAt(i);
      key = names.camelCaseToUnderscore(key.replaceAll(' ', '_'));
      key = names.firstLower(key);
      _textsMap[key] = texts.elementAt(i);
    }
  }
}
