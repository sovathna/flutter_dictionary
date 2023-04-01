import 'package:flutter/material.dart';
import 'package:flutter_dictionary/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutPageWidget extends ConsumerWidget {
  const AboutPageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32.0),
            Image.asset(
              "assets/icons/ic_launcher.png",
              width: 100.0,
            ),
            const SizedBox(height: 32.0),
            const Text(
              "វចនានុក្រមខ្មែរ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 32.0),
            const Text(
              "ពុម្ពអក្សរប្រើប្រាស់\nHanuman ដោយ Danh Hong",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            TextButton(
              child: const Text(
                "អភិវឌ្ឍដោយ៖ ហុង សុវឌ្ឍនា",
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                launchUrlString("https://sovathna.github.io");
              },
            ),
            const SizedBox(height: 32.0),
            TextButton(
              child: const Text(
                "កូដរបស់កម្មវិធីនេះមាននៅលើGitHub",
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                launchUrlString(
                    "https://github.com/sovathna/flutter_dictionary");
              },
            ),
            const SizedBox(height: 32.0),
            Image.asset(
              ref.watch(
                      appViewModelProvider.select((value) => value.isDarkTheme))
                  ? "assets/icons/flutter_dark.png"
                  : "assets/icons/flutter_light.png",
              width: 180.0,
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
