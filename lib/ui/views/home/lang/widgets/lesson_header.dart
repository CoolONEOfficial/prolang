import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prolang/app/constants/ThemeColors.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LessonHeader extends StatelessWidget {
  final String title;

  const LessonHeader({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: getValueForScreenType(
          context: context,
          tablet: BorderRadius.all(
            const Radius.circular(16.0),
          ),
          mobile: BorderRadius.zero,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: getValueForScreenType(
            context: context,
            tablet: TextAlign.center,
            mobile: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
