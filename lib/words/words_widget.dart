import 'package:flutter/material.dart';
import 'package:flutter_dictionary/definition/definition_page.dart';
import 'package:flutter_dictionary/words_page/words_page_view_model.dart';
import 'package:flutter_dictionary/words_page/words_page_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordsWidget<VM extends AbstractWordsPageViewModel>
    extends ConsumerWidget {
  final double width;
  const WordsWidget(this.width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(tmpProvider(VM).notifier);
    final ScrollController scrollController = ScrollController();
    final TextEditingController controller =
        TextEditingController(text: vm.currentWords.filter);
    controller.selection =
        TextSelection.collapsed(offset: vm.currentWords.filter.length);
    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        vm.getMoreWords();
      }
    });
    final wordsState =
        ref.watch(tmpProvider(VM).select((value) => value.wordsState));
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 12.0),
          child: TextField(
            textInputAction: TextInputAction.search,
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: ref.watch(tmpProvider(VM)
                      .select((value) => value.wordsState.filter.isNotEmpty))
                  ? IconButton(
                      onPressed: () {
                        controller.clear();
                        vm.filter("");
                      },
                      icon: const Icon(Icons.clear_rounded),
                    )
                  : null,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              labelText: "ស្វែងរកពាក្យ",
            ),
            onChanged: (value) {
              vm.filter(value);
            },
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              ListView.builder(
                controller: scrollController,
                itemCount: wordsState.wordList.length,
                itemBuilder: (_, index) => WordItemWidget(
                  value: wordsState.wordList[index].value,
                  onItemClick: () {
                    ref
                        .read(tmpProvider(VM).notifier)
                        .getDefinition(wordsState.wordList[index].id);
                    if (width < 600) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DefinitionPage<VM>(),
                        ),
                      );
                    }
                  },
                ),
              ),
              wordsState.shouldShowEmpty
                  ? const Center(child: Text("មិនមានពាក្យ!"))
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ],
    );
  }
}

class WordItemWidget extends StatelessWidget {
  final String value;
  final void Function() onItemClick;
  const WordItemWidget(
      {Key? key, required this.value, required this.onItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(4.0),
      child: ListTile(
        onTap: onItemClick,
        title: Text(value),
      ),
    );
  }
}
