class Names {
  String firstUpper(String value) {
    return value[0].toUpperCase() + value.substring(1);
  }

  String firstLower(String value) {
    return value[0].toLowerCase() + value.substring(1);
  }

  String camelCaseToUnderscore(String input) {
    final regex = RegExp('([a-z0-9])([A-Z])');
    return input
        .replaceAllMapped(
            regex, (match) => '${match.group(1)}_${match.group(2)}')
        .toLowerCase();
  }

  String underscoreToCamelCase(String input) {
    List<String> parts = input.split('_');
    String camelCase = parts[0];

    for (int i = 1; i < parts.length; i++) {
      String word = parts[i];
      String capitalizedWord = word[0].toUpperCase() + word.substring(1);
      camelCase += capitalizedWord;
    }

    return camelCase;
  }
}
