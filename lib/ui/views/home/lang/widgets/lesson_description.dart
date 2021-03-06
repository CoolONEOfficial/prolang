import 'package:expandable/expandable.dart';
import 'package:flutter/widgets.dart';
import 'package:prolang/app/constants/theme_colors.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:provider/provider.dart';

class LessonDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final section = context.watch<LessonSection>();
    return ExpandablePanel(
      collapsed: Text(
        section.description,
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: ThemeColors.textColor()),
      ),
      expanded: Text(
        section.description,
        softWrap: true,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: ThemeColors.textColor(),
          fontSize: 20,
        ),
      ),
    );
  }
}
