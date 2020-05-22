import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ThemeColors {
  static Color primaryDark = Colors.deepPurple[600];
  static Color primaryLight = Colors.deepPurple[400];

  static Color accentDark = Colors.orangeAccent[500];
  static Color accentLight = Colors.orangeAccent[300];

  static Color primaryDarken() =>
      _color(light: Colors.deepPurple[600], dark: Colors.deepPurple[800]);

  static Color cardColor() =>
      _color(light: Colors.white, dark: Colors.grey[900]);

  static Color secondaryHeaderColor() =>
      _color(light: Colors.grey[300], dark: Colors.grey[850]);

  static Color backgroundColor(BuildContext context) => isMaterial(context)
      ? _color(light: Colors.white, dark: Colors.grey[800])
      : _color(light: Color.fromARGB(255, 242, 242, 247), dark: Colors.black);

  static Color textColor() => _color(light: Colors.black87, dark: Colors.white);

  static Color textAccentColor() =>
      _color(light: Colors.black87, dark: Colors.white);

  static Color _color({
    Color light,
    Color dark,
  }) {
    switch (WidgetsBinding.instance.window.platformBrightness) {
      case Brightness.dark:
        return dark;
      case Brightness.light:
        return light;
    }
  }
}