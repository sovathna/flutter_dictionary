import 'package:flutter/material.dart';
import 'package:flutter_dictionary/splash/splash_page_view_model.dart';
import 'package:provider/provider.dart';

class SplashPageWidget extends StatelessWidget {
  final Function() _onDone;
  const SplashPageWidget(this._onDone, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<SplashPageViewModel>(
          builder: (_, vm, __) {
            if (vm.value.shouldRedirect) _onDone();

            final String title;
            final progress = vm.value.progress;
            if (progress == 0.0) {
              title = "កំពុងរៀបចំទាញយកទិន្នន័យ សូមមេត្តារង់ចាំ...!";
            } else if (progress == 1.0) {
              title = "កំពុងរៀបចំការកំណត់ សូមមេត្តារង់ចាំ...!";
            } else {
              title = "កំពុងទាញយកទិន្នន័យ សូមមេត្តារង់ចាំ...!";
            }

            return Padding(
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
            );
          },
        ),
      ),
    );
  }
}
