import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prolang/ui/widgets/platform_card.dart';
import 'package:tinycolor/tinycolor.dart';

class PlatformCardButton extends PlatformCard {
  PlatformCardButton({
    Key key,
    Color color,
    Color shadowColor,
    bool borderOnForeground = true,
    Clip clipBehavior,
    EdgeInsetsGeometry margin,
    bool semanticContainer = true,
    Widget child,
    bool enabled = true,
    Function onPressed,
  }) : super(
          key: key,
          color: color,
          shadowColor: shadowColor,
          borderOnForeground: borderOnForeground,
          clipBehavior: clipBehavior,
          margin: margin,
          semanticContainer: semanticContainer,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
          enabled: enabled,
          onPressed: onPressed,
        );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontSize: 20,
            color: enabled
                ? Theme.of(context).textTheme.bodyText2.color
                : TinyColor(Theme.of(context).disabledColor).lighten(40).color,
          ),
        ),
      ),
      child: super.build(context),
    );
  }
}
