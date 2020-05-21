import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:provider/provider.dart';

class LessonHeader extends StatelessWidget {
  const LessonHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final section = context.watch<LessonSection>();
    return Padding(
      padding: getValueForScreenType(
        context: context,
        tablet: const EdgeInsets.only(top: 8.0),
        mobile: EdgeInsets.zero,
      ),
      child: Container(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                section.title,
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
              ExpandableTheme(
                data: ExpandableThemeData(
                  useInkWell: isMaterial(context),
                  iconColor: Colors.white,
                ),
                child: ExpandableButton(
                  child: ExpandableIcon(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
