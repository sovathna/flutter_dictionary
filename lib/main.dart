import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dictionary/app/app_state.dart';
import 'package:flutter_dictionary/app/app_view_model.dart';
import 'package:flutter_dictionary/app/app_widget.dart';
import 'package:flutter_dictionary/data/database.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

final wordsDbProvider = Provider<WordsDatabase>((ref) => WordsDatabase());
final localDbProvider =
    Provider.autoDispose<LocalDatabase>((ref) => LocalDatabase());
final settingsProvider = Provider<Box>((ref) => Hive.box("settings"));
final appViewModelProvider = StateNotifierProvider<AppViewModel, AppState>(
  (ref) => AppViewModel(ref.watch<Box>(settingsProvider)),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }

  final dir = await getApplicationSupportDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox("settings");
  runApp(const ProviderScope(child: AppWidget()));
}
