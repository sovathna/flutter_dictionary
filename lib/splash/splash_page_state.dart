import 'package:flutter/foundation.dart';

@immutable
class SplashPageState {
  final double progress;
  final bool shouldRedirect;

  const SplashPageState({this.progress = 0, this.shouldRedirect = false});
}
