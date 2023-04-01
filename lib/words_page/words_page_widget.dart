import 'package:flutter/material.dart';
import 'package:flutter_dictionary/main.dart';

import 'package:flutter_dictionary/words_page/abstract_words_page_widget.dart';
import 'package:flutter_dictionary/words_page/words_page_state.dart';
import 'package:flutter_dictionary/words_page/words_page_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tmpProvider = StateNotifierProvider.autoDispose
    .family<AbstractWordsPageViewModel, WordsPageState, Type>((ref, args) {
  if (args == HistoriesViewModel) {
    return HistoriesViewModel(
        ref.watch(wordsDbProvider), ref.watch(localDbProvider));
  } else if (args == BookmarksViewModel) {
    return BookmarksViewModel(
        ref.watch(wordsDbProvider), ref.watch(localDbProvider));
  }
  return WordsPageViewModel(
      ref.watch(wordsDbProvider), ref.watch(localDbProvider));
});

class BookmarksPageWidget extends AbstractWordsPageWidget<BookmarksViewModel> {
  const BookmarksPageWidget({Key? key}) : super(key: key);
}

class HistoriesPageWidget extends AbstractWordsPageWidget<HistoriesViewModel> {
  const HistoriesPageWidget({Key? key}) : super(key: key);
}

class WordsPageWidget extends AbstractWordsPageWidget<WordsPageViewModel> {
  const WordsPageWidget({Key? key}) : super(key: key);
}
