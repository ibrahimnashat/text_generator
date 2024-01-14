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
        String newKey = '';
        for (int i = 0; i < data.length; i++) {
          if (data[i].contains("}")) {
            int start = data[i].indexOf('}');
            newText += '{x$i}${data[i].replaceFirst('}', '')}';
            newKey += 'X$i${data[i].replaceFirst('}', '')}';
          } else {
            newText += data[i];
            newKey += data[i];
          }
        }
        text = newText;
        key = newKey;
      }
      key = names.underscoreToCamelCase(key
          .replaceAll(' ', '_')
          .replaceAll('?', "")
          .replaceAll('!', '')
          .replaceAll("'", "")
          .replaceAll(',', '')
          .replaceAll('%', '')
          .replaceAll('@', ''));
      key = names.firstLower(key);
      _textsMap[key] = text;
    }
  }
}
