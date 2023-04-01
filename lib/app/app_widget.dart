import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dictionary/color_schemes.g.dart';
import 'package:flutter_dictionary/const.dart';
import 'package:flutter_dictionary/main.dart';
import 'package:flutter_dictionary/main/main_widget.dart';
import 'package:flutter_dictionary/splash/splash_page_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppScrollBehaviour extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad
      };
}

class AppWidget extends ConsumerWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      scrollBehavior: AppScrollBehaviour(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: fontFamily,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: fontFamily,
      ),
      themeMode:
          ref.watch(appViewModelProvider.select((value) => value.isDarkTheme))
              ? ThemeMode.dark
              : ThemeMode.light,
      title: 'Khmer Dictionary',
      home: ref.watch(
              appViewModelProvider.select((value) => value.shouldShowSplash))
          ? const SplashPageWidget()
          : const MainWidget(),
    );
  }
}
