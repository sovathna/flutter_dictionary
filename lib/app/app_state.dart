import 'package:flutter/foundation.dart';
import 'package:flutter_dictionary/main/drawer_widget.dart';

@immutable
class AppState {
  final bool isDarkTheme;
  final double fontSize;
  final int selectedDrawer;
  final bool shouldShowSplash;

  const AppState({
    required this.isDarkTheme,
    required this.fontSize,
    required this.selectedDrawer,
    required this.shouldShowSplash,
  });

  static AppState init() => const AppState(
      isDarkTheme: true,
      fontSize: 16.0,
      selectedDrawer: 0,
      shouldShowSplash: true);

  AppState copyWith(
          {bool? isDarkTheme,
          double? fontSize,
          int? selectedDrawer,
          bool? shouldShowSplash}) =>
      AppState(
        isDarkTheme: isDarkTheme ?? this.isDarkTheme,
        fontSize: fontSize ?? this.fontSize,
        selectedDrawer: selectedDrawer ?? this.selectedDrawer,
        shouldShowSplash: shouldShowSplash ?? this.shouldShowSplash,
      );

  String get title => drawerItemData[selectedDrawer].title;
}
