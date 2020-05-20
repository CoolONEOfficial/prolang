import 'dart:ui';

import 'package:flutter/widgets.dart';

String backgroundImagePath(BuildContext context) {
  String mode;
  switch (MediaQuery.of(context).platformBrightness) {
    case Brightness.dark:
      mode = "dark";
      break;
    case Brightness.light:
      mode = "light";
      break;
  }
  return "assets/images/background-$mode.jpg";
}