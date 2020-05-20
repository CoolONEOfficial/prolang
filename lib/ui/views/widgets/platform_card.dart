import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class PlatformCard extends PlatformWidgetBase<CupertinoButton, Card> {
  PlatformCard({
    Key key,
    this.color,
    this.shadowColor,
    this.borderOnForeground = true,
    this.margin,
    this.clipBehavior,
    this.child,
    this.semanticContainer = true,
    this.onPressed,
  })  : assert(borderOnForeground != null),
        super(key: key);

  final Color color;
  final Color shadowColor;
  final bool borderOnForeground;
  final Clip clipBehavior;
  final EdgeInsetsGeometry margin;
  final bool semanticContainer;
  final Widget child;

  final VoidCallback onPressed;

  @override
  Card createAndroidWidget(BuildContext context) {
    return Card(
      color: color,
      shadowColor: shadowColor,
      borderOnForeground: borderOnForeground,
      clipBehavior: clipBehavior,
      margin: margin,
      semanticContainer: semanticContainer,
      child: InkWell(
        onTap: onPressed,
        child: child,
      ),
    );
  }

  @override
  CupertinoButton createIosWidget(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: color,
          shadowColor: shadowColor,
          borderOnForeground: borderOnForeground,
          clipBehavior: clipBehavior,
          margin: margin,
          semanticContainer: semanticContainer,
          child: child,
        ),
      ),
    );
  }
}
