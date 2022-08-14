import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
part 'database.g.dart';

@DriftDatabase(tables: [Words])
class WordsDatabase extends _$WordsDatabase {
  WordsDatabase() : super(_openWordsDbConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openWordsDbConnection() {
  return LazyDatabase(() async {
    final dbDir = await getApplicationSupportDirectory();
    final dbFile = File(path.join(dbDir.path, "data.sqlite"));
    return NativeDatabase(dbFile);
  });
}

class Words extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get word => text()();
  TextColumn get definition => text()();
}

@DriftDatabase(tables: [Histories, Bookmarks])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openLocalDbConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openLocalDbConnection() {
  return LazyDatabase(() async {
    final dbDir = await getApplicationSupportDirectory();
    final dbFile = File(path.join(dbDir.path, "local.sqlite"));
    return NativeDatabase(dbFile);
  });
}

class Histories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wordId => integer().unique()();
  TextColumn get word => text()();
}

class Bookmarks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wordId => integer().unique()();
  TextColumn get word => text()();
}
