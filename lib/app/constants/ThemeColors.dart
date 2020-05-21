import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeColors {
  static Color primaryDark = Colors.deepPurple[600];
  static Color primaryLight = Colors.deepPurple[400];

  static Color accentDark = Colors.orangeAccent[500];
  static Color accentLight = Colors.orangeAccent[300];

  static Color primaryDarken(BuildContext context) => _color(context,
      light: Colors.deepPurple[600], dark: Colors.deepPurple[800]);

  static Color cardColor(BuildContext context) =>
      _color(context, light: Colors.white, dark: Colors.grey[900]);

  static Color textColor(BuildContext context) =>
      _color(context, light: Colors.black87, dark: Colors.white);

  static Color textAccentColor(BuildContext context) =>
      _color(context, light: Colors.black87, dark: Colors.white);

  static Color _color(
    BuildContext context, {
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
