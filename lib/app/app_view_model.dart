import 'package:flutter_dictionary/app/app_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppViewModel extends StateNotifier<AppState> {
  final Box settings;

  AppViewModel(this.settings) : super(AppState.init()) {
    _getTheme();
  }

  void goToMainPage() {
    state = state.copyWith(shouldShowSplash: false);
  }

  void _getTheme() {
    state = state.copyWith(
      isDarkTheme: settings.get("is_dark_theme", defaultValue: true),
      fontSize: settings.get("font_size", defaultValue: 16.0),
    );
  }

  void changeTheme() {
    final newTheme = !state.isDarkTheme;
    state = state.copyWith(isDarkTheme: newTheme);
    settings.put("is_dark_theme", newTheme);
  }

  void increaseFontSize() {
    double fontSize = settings.get("font_size", defaultValue: 16.0);
    fontSize += 2.0;
    if (fontSize > 50.0) fontSize = 50.0;
    state = state.copyWith(fontSize: fontSize);
    settings.put("font_size", fontSize);
  }

  void decreaseFontSize() {
    double fontSize = settings.get("font_size", defaultValue: 16.0);
    fontSize -= 2.0;
    if (fontSize < 16.0) fontSize = 16.0;
    state = state.copyWith(fontSize: fontSize);
    settings.put("font_size", fontSize);
  }

  void select(int position) {
    if (state.selectedPosition == position) return;
    state = state.copyWith(navs: state.navs.toList()..add(position));
  }

  void pop() {
    state = state.copyWith(navs: state.navs.toList()..removeLast());
  }
}
