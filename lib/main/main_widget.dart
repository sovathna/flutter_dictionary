import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dictionary/about/about_page_widget.dart';
import 'package:flutter_dictionary/fade_indexed_stack.dart';
import 'package:flutter_dictionary/main.dart';
import 'package:flutter_dictionary/main/drawer_widget.dart';
import 'package:flutter_dictionary/words_page/words_page_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainWidget extends ConsumerWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tmp =
        ref.watch(appViewModelProvider.select((value) => value.navs.length));
    return WillPopScope(
      onWillPop: () async {
        if (tmp > 1 && !Navigator.of(context).canPop()) {
          ref.read(appViewModelProvider.notifier).pop();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  ref.watch(
                      appViewModelProvider.select((value) => value.title)),
                ),
              ),
            ],
          ),
          actions: const [_ThemeSwitcher()],
        ),
        drawer: const DrawerWidget(),
        body: FadeIndexedStack(
          index: ref.watch(
              appViewModelProvider.select((value) => value.selectedPosition)),
          children: const [
            WordsPageWidget(),
            HistoriesPageWidget(),
            BookmarksPageWidget(),
            AboutPageWidget(),
          ],
        ),
      ),
    );
  }
}

class _ThemeSwitcher extends ConsumerWidget {
  const _ThemeSwitcher();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: AnimatedToggleSwitch.rolling(
        current: ref.watch(appViewModelProvider
            .select((value) => value.isDarkTheme ? "dark" : "light")),
        values: const ["light", "dark"],
        indicatorColor: Colors.transparent,
        indicatorSize: const Size(28, double.infinity),
        height: 32,
        iconBuilder: (value, size, foreground) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image(
              width: 20,
              height: 20,
              color: Theme.of(context).colorScheme.primary,
              colorBlendMode: BlendMode.srcATop,
              image: AssetImage("assets/icons/ic_$value.png"),
            ),
          );
        },
        onChanged: (value) {
          ref.read(appViewModelProvider.notifier).changeTheme();
        },
      ),
    );
  }
}
