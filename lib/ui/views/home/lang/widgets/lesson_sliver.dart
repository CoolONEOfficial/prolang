import 'package:flutter/widgets.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:provider/provider.dart';

import 'lesson_entry.dart';
import 'lesson_header.dart';

class LessonSliver extends StatelessWidget {
  final MapEntry<int, List<Lesson>> section;

  const LessonSliver(
    this.section, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: LessonHeader(title: context.watch<Lang>().sections[section.key]),
      sliver: SliverList(
        delegate: SliverChildListDelegate.fixed([
          ResponsiveGridRow(
            children: section.value
                .map(
                  (lesson) => ResponsiveGridCol(
                    lg: 6,
                    md: 12,
                    child: LessonEntry(lesson),
                  ),
                )
                .toList(),
          )
        ]),
      ),
    );
  }
}
