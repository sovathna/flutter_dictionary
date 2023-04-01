import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dictionary/main.dart';
import 'package:flutter_dictionary/words_page/words_page_view_model.dart';
import 'package:flutter_dictionary/words_page/words_page_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefinitionWidget<VM extends AbstractWordsPageViewModel>
    extends ConsumerWidget {
  const DefinitionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox.expand(
      child: Card(
        margin: const EdgeInsets.all(4.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _getDefinitionWidget(context, ref),
        ),
      ),
    );
  }

  Widget _getDefinitionWidget(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(tmpProvider(VM).select((value) => value.definitionState));
    if (state.wordId <= 0) {
      return Center(
        child: Text(
          "ចុចពាក្យដើម្បីមើលពន្យល់ន័យ",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: ref.watch(
                  appViewModelProvider.select((value) => value.fontSize))),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [
          Expanded(
            child: Text(
              state.word,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 28.0),
            ),
          ),
          TextButton(
            onPressed: () =>
                ref.read(appViewModelProvider.notifier).decreaseFontSize(),
            child: const Text("ក-", style: TextStyle(fontSize: 18.0)),
          ),
          TextButton(
            onPressed: () =>
                ref.read(appViewModelProvider.notifier).increaseFontSize(),
            child: const Text("ក+", style: TextStyle(fontSize: 18.0)),
          ),
          const SizedBox(width: 16.0),
          IconButton(
            onPressed: () {
              ref.read(tmpProvider(VM).notifier).addOrDeleteBookmark();
            },
            icon: state.isBookmark
                ? const Icon(Icons.bookmark_rounded)
                : const Icon(Icons.bookmark_outline_rounded),
          )
        ]),
        const SizedBox(height: 16.0),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: RichText(
              text: TextSpan(
                children: _buildDefinitionText(
                  context,
                  ref,
                  state.definition,
                  ref.watch(
                      appViewModelProvider.select((value) => value.fontSize)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<TextSpan> _buildDefinitionText(
      BuildContext context, WidgetRef ref, String definition, double fontSize) {
    final style =
        DefaultTextStyle.of(context).style.copyWith(fontSize: fontSize);
    final texts = <TextSpan>[];
    definition.split("[]").forEach((element) {
      if (element.contains("|")) {
        final tmp = TextSpan(
            text: element.split("|").last,
            style: style,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                ref
                    .read(tmpProvider(VM).notifier)
                    .getDefinition(int.parse(element.split("|").first));
              });
        texts.add(tmp);
      } else {
        texts.add(TextSpan(
          text: element,
          style: style,
        ));
      }
    });
    return texts;
  }
}
