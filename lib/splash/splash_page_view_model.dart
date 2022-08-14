import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dictionary/const.dart';
import 'package:flutter_dictionary/splash/splash_page_state.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class SplashPageViewModel extends ValueNotifier<SplashPageState> {
  final Box settings = Hive.box("settings");
  SplashPageViewModel() : super(const SplashPageState()) {
    _downloadAndExtract();
  }

  void _downloadAndExtract() async {
    final dbDir = await getApplicationSupportDirectory();
    final dbFile = File(path.join(dbDir.path, "data.sqlite"));
    final int dataVersion = settings.get("data_version", defaultValue: 0);
    if (dataVersion == configDataVersion && await dbFile.exists()) {
      value = const SplashPageState(progress: 1.0);
      return;
    }

    final client = HttpClient();
    final request = await client.getUrl(Uri.parse(dbDownloadUrl));
    final response = await request.close();

    final responseBytes = await consolidateHttpClientResponseBytes(
      response,
      onBytesReceived: (cumulative, total) => value = SplashPageState(
        progress: cumulative.toDouble() / (total ?? 1.0),
      ),
    );
    final archive = ZipDecoder().decodeBytes(responseBytes);
    await dbFile.writeAsBytes(archive.first.content);
    settings.put("data_version", configDataVersion);
  }
}
