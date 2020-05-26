import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:prolang/app/constants/theme_colors.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/ui/views/home/lang/lang_view.dart';
import 'package:prolang/ui/views/home/lang/widgets/lesson_description.dart';
import 'package:prolang/ui/widgets/platform_card.dart';
import 'package:prolang/ui/widgets/platform_card_button.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:provider/provider.dart';

import 'lesson_entry.dart';
import 'lesson_header.dart';

class LessonSliver extends StatelessWidget {
  final MapEntry<LessonSection, List<Lesson>> section;

  const LessonSliver(
    this.section, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<Lang>();
    return ExpandableNotifier(
      child: Provider<LessonSection>(
        create: (_) => section.key,
        child: SliverStickyHeader(
          header: LessonHeader(),
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: LessonDescription(),
              ),
              ResponsiveGridRow(
                children: section.value
                        .map(
                          (lesson) => ResponsiveGridCol(
                            lg: 6,
                            md: 12,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 8.0,
                                left: 8.0,
                                right: 8.0,
                              ),
                              child: LessonEntry(lesson),
                            ),
                          ),
                        )
                        .toList() +
                    [
                      ResponsiveGridCol(
                        lg: 6,
                        md: 12,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8.0,
                            left: 8.0,
                            right: 8.0,
                          ),
                          child: PlatformCardButton(
                            color: Theme.of(context).cardColor,
                            child: Icon(
                              PlatformIcons(context).add,
                              color: ThemeColors.textColor(),
                            ),
                            onPressed: () {
                              LangView.showLessonForm(
                                context,
                                lang: lang,
                                section: section.key.copyWith(),
                                insertPosition: section.value.length,
                              );
                            },
                          ),
                        ),
                      )
                    ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
