import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dictionary/app/app_view_model.dart';
import 'package:flutter_dictionary/app/app_widget.dart';
import 'package:flutter_dictionary/data/database.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }

  final dir = await getApplicationSupportDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox("settings");
  runApp(
    MultiProvider(
      providers: [
        Provider<WordsDatabase>(
          create: (_) => WordsDatabase(),
          dispose: (context, db) => db.close(),
        ),
        Provider<LocalDatabase>(
          create: (_) => LocalDatabase(),
          dispose: (context, db) => db.close(),
        ),
        ChangeNotifierProvider<AppViewModel>(
          create: (_) => AppViewModel(),
        )
      ],
      child: const AppWidget(),
    ),
  );
}
