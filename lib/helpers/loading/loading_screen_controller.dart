import 'package:flutter/material.dart';

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingScreenController {
  final UpdateLoadingScreen update;
  final CloseLoadingScreen close;

  const LoadingScreenController({
    required this.update,
    required this.close,
  });
}
