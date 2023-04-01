import 'package:flutter/material.dart';
import 'package:flutter_dictionary/definition/definition_widget.dart';
import 'package:flutter_dictionary/words_page/words_page_view_model.dart';
import 'package:flutter_dictionary/words_page/words_page_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefinitionPage<VM extends AbstractWordsPageViewModel>
    extends ConsumerWidget {
  const DefinitionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 600) {
      if (Navigator.canPop(context)) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pop(context);
        });
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                ref.watch(tmpProvider(VM)
                    .select((value) => value.definitionState.word)),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: DefinitionWidget<VM>(),
      ),
    );
  }
}
