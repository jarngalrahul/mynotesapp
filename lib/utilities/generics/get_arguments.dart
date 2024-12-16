import 'package:flutter/material.dart';

//Extracting argument parameters when passed during navigation
extension GetArgument on BuildContext {
  T? getArgument<T>() {
    final modelRoute = ModalRoute.of(this);
    if (modelRoute != null) {
      final args = modelRoute.settings.arguments;
      if (args != null && args is T) {
        return args as T;
      }
    }
    return null;
  }
}
