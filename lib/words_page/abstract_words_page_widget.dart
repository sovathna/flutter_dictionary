import 'package:flutter/material.dart';
import 'package:flutter_dictionary/definition/definition_widget.dart';
import 'package:flutter_dictionary/words/words_widget.dart';
import 'package:flutter_dictionary/words_page/words_page_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AbstractWordsPageWidget<VM extends AbstractWordsPageViewModel>
    extends ConsumerWidget {
  const AbstractWordsPageWidget({Key? key}) : super(key: key);

  Widget _getDefinitionWidget(double maxWidth) {
    if (maxWidth < 600) {
      return const SizedBox.shrink();
    }
    return Expanded(
      flex: 2,
      child: DefinitionWidget<VM>(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: LayoutBuilder(builder: (_, constraint) {
        return Row(
          children: [
            Expanded(child: WordsWidget<VM>(constraint.maxWidth)),
            _getDefinitionWidget(constraint.maxWidth),
          ],
        );
      }),
    );
  }
}
