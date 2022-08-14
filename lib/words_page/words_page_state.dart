import 'package:flutter/foundation.dart';
import 'package:flutter_dictionary/definition/definition_state.dart';
import 'package:flutter_dictionary/words/words_state.dart';

@immutable
class WordsPageState {
  final DefinitionState definitionState;
  final WordsState wordsState;

  const WordsPageState({
    required this.definitionState,
    required this.wordsState,
  });

  static WordsPageState init() => WordsPageState(
      wordsState: WordsState.init(), definitionState: DefinitionState.init());

  WordsPageState copyWith(
      {WordsState? wordsState, DefinitionState? definitionState}) {
    return WordsPageState(
      wordsState: wordsState ?? this.wordsState,
      definitionState: definitionState ?? this.definitionState,
    );
  }
}
