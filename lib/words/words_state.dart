import 'package:flutter/foundation.dart';
import 'package:flutter_dictionary/model/word_ui.dart';

@immutable
class WordsState {
  final int page;
  final String filter;
  final bool isLoading;
  final bool isMore;
  final Iterable<WordUi> words;

  const WordsState({
    required this.words,
    required this.isLoading,
    required this.page,
    required this.isMore,
    required this.filter,
  });

  static WordsState init() => WordsState(
        words: List.empty(),
        isLoading: false,
        page: 1,
        filter: "",
        isMore: false,
      );

  WordsState copyWith({
    Iterable<WordUi>? words,
    bool? isLoading,
    int? page,
    String? filter,
    bool? isMore,
  }) {
    return WordsState(
        words: words ?? this.words,
        isLoading: isLoading ?? this.isLoading,
        page: page ?? this.page,
        filter: filter ?? this.filter,
        isMore: isMore ?? this.isMore);
  }

  List<WordUi> get wordList {
    return words as List<WordUi>;
  }

  bool get shouldShowEmpty {
    return words.isEmpty && !isLoading;
  }
}
