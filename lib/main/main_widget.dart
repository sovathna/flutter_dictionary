import 'package:flutter/material.dart';
import 'package:flutter_dictionary/about/about_page_widget.dart';
import 'package:flutter_dictionary/app/app_view_model.dart';
import 'package:flutter_dictionary/main/drawer_widget.dart';
import 'package:flutter_dictionary/words_page/words_page_view_model.dart';
import 'package:flutter_dictionary/words_page/words_page_widget.dart';
import 'package:provider/provider.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  List<Widget> _createActions(BuildContext context) {
    return [
      Switch(
        activeThumbImage: const AssetImage("assets/icons/ic_dark.png"),
        inactiveThumbImage: const AssetImage("assets/icons/ic_light.png"),
        value: context.select<AppViewModel, bool>((vm) => vm.value.isDarkTheme),
        onChanged: (value) => context.read<AppViewModel>().changeTheme(),
      ),
      const SizedBox(width: 16.0),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WordsPageViewModel(context.read(), context.read()),
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Expanded(
                    child: Text(context.watch<AppViewModel>().value.title)),
              ],
            ),
            actions: _createActions(context),
          ),
          drawer: DrawerWidget((position) {
            Navigator.of(context).pop();
          }),
          body: IndexedStack(
            sizing: StackFit.expand,
            index: context.read<AppViewModel>().value.selectedPosition,
            children: [
              const WordsPageWidget(),
              ChangeNotifierProvider(
                create: (context) =>
                    HistoriesViewModel(context.read(), context.read()),
                builder: (_, __) => const HistoriesPageWidget(),
              ),
              ChangeNotifierProvider(
                create: (context) =>
                    BookmarksViewModel(context.read(), context.read()),
                builder: (_, __) => const BookmarksPageWidget(),
              ),
              const AboutPageWidget(),
            ],
          )),
    );
  }
}
