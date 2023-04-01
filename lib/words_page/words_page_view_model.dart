import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dictionary/const.dart';
import 'package:flutter_dictionary/data/database.dart';
import 'package:flutter_dictionary/definition/definition_state.dart';
import 'package:flutter_dictionary/model/word_ui.dart';
import 'package:flutter_dictionary/words/words_state.dart';
import 'package:flutter_dictionary/words_page/words_page_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarksViewModel extends AbstractWordsPageViewModel {
  BookmarksViewModel(super.db, super.localDb);

  @override
  Future<List<WordUi>> _getWords(int page, String filter) async {
    final offset = (page - 1) * pageSize;

    final query = _localDb.customSelect(
        "SELECT word_id, word FROM bookmarks WHERE word LIKE ? ORDER BY id DESC LIMIT ?, ?",
        readsFrom: {
          _localDb.bookmarks
        },
        variables: [
          Variable.withString("$filter%"),
          Variable.withInt(offset),
          Variable.withInt(pageSize),
        ]);
    return await query
        .map((w) => WordUi(id: w.read("word_id"), value: w.read("word")))
        .get();
  }
}

class HistoriesViewModel extends AbstractWordsPageViewModel {
  HistoriesViewModel(super.db, super.localDb);

  @override
  Future<List<WordUi>> _getWords(int page, String filter) async {
    final offset = (page - 1) * pageSize;
    final query = _localDb.customSelect(
        "SELECT word_id, word FROM histories WHERE word LIKE ? ORDER BY id DESC LIMIT ?, ?",
        readsFrom: {
          _localDb.histories
        },
        variables: [
          Variable.withString("$filter%"),
          Variable.withInt(offset),
          Variable.withInt(pageSize),
        ]);
    return await query
        .map((w) => WordUi(id: w.read("word_id"), value: w.read("word")))
        .get();
  }
}

class WordsPageViewModel extends AbstractWordsPageViewModel {
  WordsPageViewModel(super.db, super.localDb);

  @override
  Future<List<WordUi>> _getWords(int page, String filter) async {
    final offset = (page - 1) * pageSize;
    final query = _db.customSelect(
        "SELECT id,word FROM words WHERE word LIKE ? ORDER BY word LIMIT ?, ?",
        readsFrom: {
          _db.words
        },
        variables: [
          Variable.withString("$filter%"),
          Variable.withInt(offset),
          Variable.withInt(pageSize),
        ]);
    return await query
        .map((w) => WordUi(id: w.read("id"), value: w.read("word")))
        .get();
  }
}

abstract class AbstractWordsPageViewModel
    extends StateNotifier<WordsPageState> {
  final WordsDatabase _db;
  final LocalDatabase _localDb;
  AbstractWordsPageViewModel(this._db, this._localDb)
      : super(WordsPageState.init()) {
    getWords(1, "");
  }

  DefinitionState get currentDef => state.definitionState;

  WordsState get currentWords => state.wordsState;

  void getDefinition(int wordId) async {
    if (currentDef.wordId == wordId) return;
    final query = _db.select(_db.words)..where((w) => w.id.equals(wordId));
    final w = await query.getSingle();
    final tmpDefinition = w.definition
        .replaceAll("[HI]", "")
        .replaceAll("[HI1]", "")
        .replaceAll("[NewLine]", "\n\n");
    final bQuery = _localDb.select(_localDb.bookmarks)
      ..where((tbl) => tbl.wordId.equals(wordId));
    Bookmark? b = await bQuery.getSingleOrNull();
    final newDef = currentDef.copyWith(
        wordId: w.id,
        word: w.word,
        definition: tmpDefinition,
        isBookmark: b != null);

    final hQuery = _localDb.select(_localDb.histories)
      ..where((tbl) => tbl.wordId.equals(w.id));
    Historie? h = await hQuery.getSingleOrNull();
    if (h != null) {
      await (_localDb.delete(_localDb.histories)
            ..where((tbl) => tbl.wordId.equals(h.wordId)))
          .go();
    }
    await _localDb.into(_localDb.histories).insert(
          HistoriesCompanion(
            wordId: Value(w.id),
            word: Value(w.word),
          ),
        );

    state = state.copyWith(definitionState: newDef);
  }

  void addOrDeleteBookmark() async {
    final bQuery = _localDb.select(_localDb.bookmarks)
      ..where((tbl) => tbl.wordId.equals(currentDef.wordId));
    Bookmark? b = await bQuery.getSingleOrNull();
    debugPrint("b: ${b?.word}");
    if (b != null) {
      await (_localDb.delete(_localDb.bookmarks)
            ..where((tbl) => tbl.wordId.equals(b.wordId)))
          .go();
    } else {
      await _localDb.into(_localDb.bookmarks).insert(
            BookmarksCompanion(
              wordId: Value(currentDef.wordId),
              word: Value(currentDef.word),
            ),
          );
    }
    state = state.copyWith(
      definitionState: currentDef.copyWith(isBookmark: !currentDef.isBookmark),
    );
  }

  Timer? _filterTimer;

  void filter(String filter) {
    _filterTimer?.cancel();
    if (currentWords.filter == filter) return;
    _filterTimer = Timer(const Duration(milliseconds: 400), () {
      getWords(1, filter);
    });
  }

  void getMoreWords() {
    if (!currentWords.isMore) return;
    getWords(currentWords.page + 1, currentWords.filter);
  }

  Future<List<WordUi>> _getWords(int page, String filter);

  void getWords(int page, String filter) async {
    if (currentWords.isLoading) return;
    state = state.copyWith(
        wordsState: currentWords.copyWith(
      isLoading: true,
      page: page,
      filter: filter,
      isMore: false,
    ));
    final pageWords = await _getWords(page, filter);
    List<WordUi> newWords;
    if (page > 1) {
      newWords = currentWords.words.toList();
      newWords.addAll(pageWords);
    } else {
      newWords = pageWords;
    }

    state = state.copyWith(
      wordsState: currentWords.copyWith(
        isLoading: false,
        words: newWords,
        isMore: pageWords.length >= pageSize,
      ),
    );
  }
}
