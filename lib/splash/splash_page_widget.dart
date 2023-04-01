import 'package:flutter/material.dart';
import 'package:flutter_dictionary/main.dart';
import 'package:flutter_dictionary/splash/splash_page_state.dart';
import 'package:flutter_dictionary/splash/splash_page_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _viewModelProvider =
    StateNotifierProvider<SplashPageViewModel, SplashPageState>(
        (ref) => SplashPageViewModel(ref.watch(settingsProvider)));

class SplashPageWidget extends ConsumerWidget {
  const SplashPageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<bool>(
      _viewModelProvider.select((value) => value.shouldRedirect),
      (bool? oldBool, bool newBool) {
        if (newBool) {
          ref.read(appViewModelProvider.notifier).goToMainPage();
        }
      },
    );

    final String title;
    final progress =
        ref.watch(_viewModelProvider.select((value) => value.progress));
    if (progress == 0.0) {
      title = "កំពុងរៀបចំទាញយកទិន្នន័យ សូមមេត្តារង់ចាំ...!";
    } else if (progress == 1.0) {
      title = "កំពុងរៀបចំការកំណត់ សូមមេត្តារង់ចាំ...!";
    } else {
      title = "កំពុងទាញយកទិន្នន័យ សូមមេត្តារង់ចាំ...!";
    }

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32.0),
                Image.asset(
                  "assets/icons/ic_launcher.png",
                  width: 100.0,
                ),
                const SizedBox(height: 64.0),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 16.0),
                LinearProgressIndicator(value: progress),
                const SizedBox(height: 8.0),
                Text(
                  "${(progress * 100).toInt()}%",
                  textAlign: TextAlign.end,
                ),
                const SizedBox(height: 64.0),
              ],
            ),
          )),
    );
  }
}
