import 'package:flutter/material.dart';

import 'package:flutter_dictionary/words_page/abstract_words_page_widget.dart';
import 'package:flutter_dictionary/words_page/words_page_view_model.dart';

class BookmarksPageWidget extends AbstractWordsPageWidget<BookmarksViewModel> {
  const BookmarksPageWidget({Key? key}) : super(key: key);
}

class HistoriesPageWidget extends AbstractWordsPageWidget<HistoriesViewModel> {
  const HistoriesPageWidget({Key? key}) : super(key: key);
}

class WordsPageWidget extends AbstractWordsPageWidget<WordsPageViewModel> {
  const WordsPageWidget({Key? key}) : super(key: key);
}
