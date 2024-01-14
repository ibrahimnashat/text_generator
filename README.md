
# Localization Text Generator

A Dart CLI Tool that can help you generate json file for all texts in all screens in a Flutter project to implement localization

## Usage

- Clone the project to your local machine.
- Run this command in the enclosing folder of the project:
  `dart pub global activate --source git https://github.com/ibrahimnashat/text_generator`

- run `generate_text` in your project's directory
- (alt+shift+f) or (shift+option+f) on vscode or (option+command+l) or (ctrl+alt+l) on android studio to format json file.
- change json file name to your desired language.
- Enjoy!

## Specs

- ✅ Single Quotation Text.
- ✅ Double Quotation Text.
- ⚠️ Triple Single Quotation.
- ✅ Triple Double Quotation.
- ✅ Excludes Imports.
- ✅ Excludes Keys.
- ✅ Checks for any file with Cupertino or Material imports.
- ⚠️ Automatically Check for Updates when launching package.
