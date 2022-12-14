import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dictionary/app/app_view_model.dart';
import 'package:flutter_dictionary/color_schemes.g.dart';
import 'package:flutter_dictionary/main/main_widget.dart';
import 'package:flutter_dictionary/splash/splash_page_view_model.dart';
import 'package:flutter_dictionary/splash/splash_page_widget.dart';
import 'package:provider/provider.dart';

class AppScrollBehaviour extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehaviour(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: "Noto Serif Khmer",
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: "Noto Serif Khmer",
      ),
      themeMode: context.select<AppViewModel, ThemeMode>(
          (vm) => vm.value.isDarkTheme ? ThemeMode.dark : ThemeMode.light),
      title: 'Khmer Dictionary',
      home: context
              .select<AppViewModel, bool>((vm) => vm.value.shouldShowSplash)
          ? ChangeNotifierProvider(
              create: (_) => SplashPageViewModel(),
              child: SplashPageWidget(
                () => WidgetsBinding.instance.addPostFrameCallback(
                  (timeStamp) => context.read<AppViewModel>().goToMainPage(),
                ),
              ),
            )
          : const MainWidget(),
    );
  }
}
