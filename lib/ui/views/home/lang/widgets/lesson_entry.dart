import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/ui/views/widgets/platform_card.dart';

class LessonEntry extends StatelessWidget {
  final Lesson lesson;

  const LessonEntry(
    this.lesson, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PlatformCard(
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            lesson.title,
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        onPressed: () {

        },
      ),
    );
  }
}
