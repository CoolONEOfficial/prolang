import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prolang/app/constants/ThemeColors.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/ui/widgets/platform_card.dart';

class LessonEntry extends StatelessWidget {
  final Lesson lesson;

  const LessonEntry(
    this.lesson, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformCard(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          lesson.title,
          style: TextStyle(
            fontSize: 30,
            color: ThemeColors.textColor(),
          ),
        ),
      ),
      onPressed: () {

      },
    );
  }
}
