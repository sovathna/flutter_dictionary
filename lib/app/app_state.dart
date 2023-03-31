import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_dictionary/main/drawer_widget.dart';

@immutable
class AppState {
  final bool isDarkTheme;
  final double fontSize;
  final bool shouldShowSplash;
  final List<int> navs;

  const AppState(
      this.isDarkTheme, this.fontSize, this.shouldShowSplash, this.navs);

  factory AppState.init() => const AppState(
        true,
        16.0,
        true,
        [0],
      );

  AppState copyWith({
    bool? isDarkTheme,
    double? fontSize,
    bool? shouldShowSplash,
    List<int>? navs,
  }) =>
      AppState(
        isDarkTheme ?? this.isDarkTheme,
        fontSize ?? this.fontSize,
        shouldShowSplash ?? this.shouldShowSplash,
        navs ?? this.navs,
      );

  String get title => drawerItemData[selectedPosition].title;

  int get selectedPosition => navs[navs.length - 1];
}
