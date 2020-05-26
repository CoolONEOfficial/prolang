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
    this.enabled = true,
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

  final bool enabled;
  final VoidCallback onPressed;

  VoidCallback get _onPressed => enabled ? onPressed : null;
  Color _color(BuildContext context) => enabled
      ? color ?? Theme.of(context).cardColor
      : Theme.of(context).disabledColor;

  @override
  Card createMaterialWidget(BuildContext context) {
    return Card(
      color: _color(context),
      shadowColor: shadowColor,
      borderOnForeground: borderOnForeground,
      clipBehavior: clipBehavior,
      margin: margin,
      semanticContainer: semanticContainer,
      child: InkWell(
        onTap: _onPressed,
        child: child,
      ),
    );
  }

  @override
  CupertinoButton createCupertinoWidget(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: _onPressed,
      child: Container(
        width: double.infinity,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: _color(context),
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
