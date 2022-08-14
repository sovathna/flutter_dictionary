import 'package:flutter/foundation.dart';
import 'package:flutter_dictionary/app/app_state.dart';
import 'package:hive/hive.dart';

class AppViewModel extends ValueNotifier<AppState> {
  final Box settings = Hive.box("settings");

  AppViewModel() : super(AppState.init()) {
    _getTheme();
  }

  void goToMainPage() {
    value = value.copyWith(shouldShowSplash: false);
  }

  void _getTheme() {
    value = value.copyWith(
      isDarkTheme: settings.get("is_dark_theme", defaultValue: true),
      fontSize: settings.get("font_size", defaultValue: 16.0),
    );
  }

  void changeTheme() {
    final newTheme = !value.isDarkTheme;
    value = value.copyWith(isDarkTheme: newTheme);
    settings.put("is_dark_theme", newTheme);
  }

  void increaseFontSize() {
    double fontSize = settings.get("font_size", defaultValue: 16.0);
    fontSize += 2;
    if (fontSize > 50.0) fontSize = 50.0;
    value = value.copyWith(fontSize: fontSize);
    settings.put("font_size", fontSize);
  }

  void decreaseFontSize() {
    double fontSize = settings.get("font_size", defaultValue: 16.0);
    fontSize -= 2;
    if (fontSize < 16.0) fontSize = 16.0;
    value = value.copyWith(fontSize: fontSize);
    settings.put("font_size", fontSize);
  }

  void selectDrawerItem(int position) {
    value = value.copyWith(selectedDrawer: position);
  }
}
