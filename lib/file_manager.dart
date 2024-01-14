import 'dart:io';

import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:text_generator/names.dart';
import 'package:text_generator/text_matcher.dart';

class FileManger {
  /// TextMatcher for current File
  late TextMatcher _textMatcher;

  Names names = Names();

  /// Current Working Directory
  late Directory _currentDirectory;

  /// Current Working Directory Getter
  Directory get currentDirectory => _currentDirectory;

  /// Constructor
  FileManger(TextMatcher textMatcher) {
    _textMatcher = textMatcher;
    _currentDirectory = Directory.current.absolute;
    if (!_currentDirectory.existsSync()) {
      _currentDirectory.createSync(recursive: true);
    }
  }

  /// List Directories inside lib folder
  List<FileSystemEntity> listDirectoryDartFiles() {
    final dartFiles = Glob('lib/**.dart').listSync();

    return dartFiles;
  }

  /// Using Dart's New Record Feature, Checking if file has a screen  widget currently works on StatelessWidget(s) and
  /// StatefulWidget(s)
  (bool, String) _checkIfScreenFile(File file) {
    String content = file.readAsStringSync();
    bool isScreenFile = content.contains('@generate');
    return (isScreenFile, content);
  }

  /// Get Scree
  Set<String> getScreensTexts(List<FileSystemEntity> dartFiles) {
    for (final file in dartFiles) {
      // iterate over all files and get content
      if (file is File) {
        final result = _checkIfScreenFile(file);
        bool isScreenFile = result.$1;
        String content = result.$2;
        if (isScreenFile) {
          final texts = _textMatcher.matchAndExtractTexts(content);
          // _textMatcher.getAllTexts();
          for (var item in texts) {
            List<String> params = [];
            String key = item;
            if (key.contains("\${")) {
              final data = key.split('\${');
              String newKey = '';
              for (int i = 0; i < data.length; i++) {
                if (data[i].contains("}")) {
                  int start = data[i].indexOf('}');
                  key += 'X$i${data[i].substring(start + 1)}';
                  params.add(data[i].substring(0, start));
                } else {
                  newKey += data[i];
                }
              }
              key = newKey;
            }
            key = names.underscoreToCamelCase(key.replaceAll(' ', '_'));
            key = names.firstLower(key);
            if (params.isNotEmpty) {
              key += '(${params.join(',')})';
            }

            key = key
                .replaceAll(' ', '_')
                .replaceAll('?', "")
                .replaceAll('!', '')
                .replaceAll("'", "")
                .replaceAll(',', '')
                .replaceAll('%', '')
                .replaceAll('@', '');

            content = content.replaceAll("'$item'", 'context.tr.$key');
            content = content.replaceAll('"$item"', 'context.tr.$key');
            file.writeAsStringSync(content);
          }
        }
      }
    }

    return _textMatcher.texts;
  }

  void writeDataToFile(String data) {
    try {
      final file = File('${_currentDirectory.path}/app_en.json');
      file.writeAsStringSync(data);
    } catch (e) {
      throw ('Could Not Write JSON File...');
    }
  }
}
