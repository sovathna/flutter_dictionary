// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Word extends DataClass implements Insertable<Word> {
  final int id;
  final String word;
  final String definition;
  Word({required this.id, required this.word, required this.definition});
  factory Word.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Word(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      word: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}word'])!,
      definition: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}definition'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word'] = Variable<String>(word);
    map['definition'] = Variable<String>(definition);
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      id: Value(id),
      word: Value(word),
      definition: Value(definition),
    );
  }

  factory Word.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Word(
      id: serializer.fromJson<int>(json['id']),
      word: serializer.fromJson<String>(json['word']),
      definition: serializer.fromJson<String>(json['definition']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'word': serializer.toJson<String>(word),
      'definition': serializer.toJson<String>(definition),
    };
  }

  Word copyWith({int? id, String? word, String? definition}) => Word(
        id: id ?? this.id,
        word: word ?? this.word,
        definition: definition ?? this.definition,
      );
  @override
  String toString() {
    return (StringBuffer('Word(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('definition: $definition')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, word, definition);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Word &&
          other.id == this.id &&
          other.word == this.word &&
          other.definition == this.definition);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<int> id;
  final Value<String> word;
  final Value<String> definition;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.definition = const Value.absent(),
  });
  WordsCompanion.insert({
    this.id = const Value.absent(),
    required String word,
    required String definition,
  })  : word = Value(word),
        definition = Value(definition);
  static Insertable<Word> custom({
    Expression<int>? id,
    Expression<String>? word,
    Expression<String>? definition,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (word != null) 'word': word,
      if (definition != null) 'definition': definition,
    });
  }

  WordsCompanion copyWith(
      {Value<int>? id, Value<String>? word, Value<String>? definition}) {
    return WordsCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
      definition: definition ?? this.definition,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('definition: $definition')
          ..write(')'))
        .toString();
  }
}

class $WordsTable extends Words with TableInfo<$WordsTable, Word> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String?> word = GeneratedColumn<String?>(
      'word', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _definitionMeta = const VerificationMeta('definition');
  @override
  late final GeneratedColumn<String?> definition = GeneratedColumn<String?>(
      'definition', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, word, definition];
  @override
  String get aliasedName => _alias ?? 'words';
  @override
  String get actualTableName => 'words';
  @override
  VerificationContext validateIntegrity(Insertable<Word> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word')) {
      context.handle(
          _wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('definition')) {
      context.handle(
          _definitionMeta,
          definition.isAcceptableOrUnknown(
              data['definition']!, _definitionMeta));
    } else if (isInserting) {
      context.missing(_definitionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Word map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Word.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(attachedDatabase, alias);
  }
}

abstract class _$WordsDatabase extends GeneratedDatabase {
  _$WordsDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $WordsTable words = $WordsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [words];
}

class Historie extends DataClass implements Insertable<Historie> {
  final int id;
  final int wordId;
  final String word;
  Historie({required this.id, required this.wordId, required this.word});
  factory Historie.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Historie(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      wordId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}word_id'])!,
      word: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}word'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word_id'] = Variable<int>(wordId);
    map['word'] = Variable<String>(word);
    return map;
  }

  HistoriesCompanion toCompanion(bool nullToAbsent) {
    return HistoriesCompanion(
      id: Value(id),
      wordId: Value(wordId),
      word: Value(word),
    );
  }

  factory Historie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Historie(
      id: serializer.fromJson<int>(json['id']),
      wordId: serializer.fromJson<int>(json['wordId']),
      word: serializer.fromJson<String>(json['word']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wordId': serializer.toJson<int>(wordId),
      'word': serializer.toJson<String>(word),
    };
  }

  Historie copyWith({int? id, int? wordId, String? word}) => Historie(
        id: id ?? this.id,
        wordId: wordId ?? this.wordId,
        word: word ?? this.word,
      );
  @override
  String toString() {
    return (StringBuffer('Historie(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('word: $word')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wordId, word);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Historie &&
          other.id == this.id &&
          other.wordId == this.wordId &&
          other.word == this.word);
}

class HistoriesCompanion extends UpdateCompanion<Historie> {
  final Value<int> id;
  final Value<int> wordId;
  final Value<String> word;
  const HistoriesCompanion({
    this.id = const Value.absent(),
    this.wordId = const Value.absent(),
    this.word = const Value.absent(),
  });
  HistoriesCompanion.insert({
    this.id = const Value.absent(),
    required int wordId,
    required String word,
  })  : wordId = Value(wordId),
        word = Value(word);
  static Insertable<Historie> custom({
    Expression<int>? id,
    Expression<int>? wordId,
    Expression<String>? word,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wordId != null) 'word_id': wordId,
      if (word != null) 'word': word,
    });
  }

  HistoriesCompanion copyWith(
      {Value<int>? id, Value<int>? wordId, Value<String>? word}) {
    return HistoriesCompanion(
      id: id ?? this.id,
      wordId: wordId ?? this.wordId,
      word: word ?? this.word,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wordId.present) {
      map['word_id'] = Variable<int>(wordId.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoriesCompanion(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('word: $word')
          ..write(')'))
        .toString();
  }
}

class $HistoriesTable extends Histories
    with TableInfo<$HistoriesTable, Historie> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoriesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<int?> wordId = GeneratedColumn<int?>(
      'word_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'UNIQUE');
  final VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String?> word = GeneratedColumn<String?>(
      'word', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, wordId, word];
  @override
  String get aliasedName => _alias ?? 'histories';
  @override
  String get actualTableName => 'histories';
  @override
  VerificationContext validateIntegrity(Insertable<Historie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word_id')) {
      context.handle(_wordIdMeta,
          wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta));
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('word')) {
      context.handle(
          _wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Historie map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Historie.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $HistoriesTable createAlias(String alias) {
    return $HistoriesTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final int id;
  final int wordId;
  final String word;
  Bookmark({required this.id, required this.wordId, required this.word});
  factory Bookmark.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Bookmark(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      wordId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}word_id'])!,
      word: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}word'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word_id'] = Variable<int>(wordId);
    map['word'] = Variable<String>(word);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      wordId: Value(wordId),
      word: Value(word),
    );
  }

  factory Bookmark.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      id: serializer.fromJson<int>(json['id']),
      wordId: serializer.fromJson<int>(json['wordId']),
      word: serializer.fromJson<String>(json['word']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wordId': serializer.toJson<int>(wordId),
      'word': serializer.toJson<String>(word),
    };
  }

  Bookmark copyWith({int? id, int? wordId, String? word}) => Bookmark(
        id: id ?? this.id,
        wordId: wordId ?? this.wordId,
        word: word ?? this.word,
      );
  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('word: $word')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wordId, word);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.id == this.id &&
          other.wordId == this.wordId &&
          other.word == this.word);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<int> id;
  final Value<int> wordId;
  final Value<String> word;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.wordId = const Value.absent(),
    this.word = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.id = const Value.absent(),
    required int wordId,
    required String word,
  })  : wordId = Value(wordId),
        word = Value(word);
  static Insertable<Bookmark> custom({
    Expression<int>? id,
    Expression<int>? wordId,
    Expression<String>? word,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wordId != null) 'word_id': wordId,
      if (word != null) 'word': word,
    });
  }

  BookmarksCompanion copyWith(
      {Value<int>? id, Value<int>? wordId, Value<String>? word}) {
    return BookmarksCompanion(
      id: id ?? this.id,
      wordId: wordId ?? this.wordId,
      word: word ?? this.word,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wordId.present) {
      map['word_id'] = Variable<int>(wordId.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('word: $word')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<int?> wordId = GeneratedColumn<int?>(
      'word_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'UNIQUE');
  final VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String?> word = GeneratedColumn<String?>(
      'word', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, wordId, word];
  @override
  String get aliasedName => _alias ?? 'bookmarks';
  @override
  String get actualTableName => 'bookmarks';
  @override
  VerificationContext validateIntegrity(Insertable<Bookmark> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word_id')) {
      context.handle(_wordIdMeta,
          wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta));
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('word')) {
      context.handle(
          _wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Bookmark.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $HistoriesTable histories = $HistoriesTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [histories, bookmarks];
}
