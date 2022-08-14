import 'package:flutter/material.dart';
import 'package:flutter_dictionary/model/word_ui.dart';
import 'package:flutter_dictionary/words_page/words_page_view_model.dart';
import 'package:provider/provider.dart';

class WordsWidget<VM extends AbstractWordsPageViewModel>
    extends StatelessWidget {
  final void Function(int) onItemClick;

  const WordsWidget({Key? key, required this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<VM>(context, listen: false);
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

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 12.0),
          child: TextField(
            textInputAction: TextInputAction.search,
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: context.select<VM, bool>(
                      (vm) => vm.currentWords.filter.isNotEmpty)
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
              Selector<VM, List<WordUi>>(
                  selector: (_, vm) => vm.currentWords.wordList,
                  builder: (_, words, __) {
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: words.length,
                      itemBuilder: (_, index) => WordItemWidget(
                        value: words[index].value,
                        onItemClick: () => onItemClick(words[index].id),
                      ),
                    );
                  }),
              Selector<VM, bool>(
                selector: (_, vm) => vm.currentWords.shouldShowEmpty,
                builder: (_, shouldShowEmpty, __) {
                  if (shouldShowEmpty) {
                    return const Center(child: Text("មិនមានពាក្យ!"));
                  }
                  return const SizedBox.shrink();
                },
              )
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
