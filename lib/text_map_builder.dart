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
      String text = texts.elementAt(i);
      if (text.contains("\${")) {
        final data = text.split('\${');
        String newText = '';
        for (int i = 0; i < data.length; i++) {
          if (data[i].contains("}")) {
            newText += '{x$i}${data[i].replaceFirst('}', '')}';
            key += 'X$i${data[i].replaceFirst('}', '')}';
          } else {
            newText += data[i];
            key += data[i];
          }
        }
        text = newText;
      }
      key = names.underscoreToCamelCase(key.replaceAll(' ', '_'));
      key = names.firstLower(key);
      _textsMap[key] = text;
    }
  }
}
