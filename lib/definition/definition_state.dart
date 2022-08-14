import 'package:flutter/foundation.dart';

@immutable
class DefinitionState {
  final int wordId;
  final String word;
  final String definition;
  final bool isBookmark;

  const DefinitionState({
    required this.wordId,
    required this.word,
    required this.definition,
    required this.isBookmark,
  });

  static DefinitionState init() => const DefinitionState(
        wordId: 0,
        word: "",
        definition: "",
        isBookmark: false,
      );

  DefinitionState copyWith({
    int? wordId,
    String? word,
    String? definition,
    bool? isBookmark,
  }) {
    return DefinitionState(
      wordId: wordId ?? this.wordId,
      word: word ?? this.word,
      definition: definition ?? this.definition,
      isBookmark: isBookmark ?? this.isBookmark,
    );
  }
}
