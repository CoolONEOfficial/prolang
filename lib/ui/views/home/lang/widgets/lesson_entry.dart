import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/constants/theme_colors.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/ui/widgets/platform_card.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../lang_view.dart';

class LessonEntry extends StatelessWidget {
  final Lesson lesson;

  const LessonEntry(
    this.lesson, {
    Key key,
  }) : super(key: key);

  onDeletePressed(
    BuildContext context,
    Lang lang,
    LessonSection section,
  ) =>
      showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
          title: Text("lang.lesson.delete.confirmation".tr()),
          actions: <Widget>[
            PlatformDialogAction(
              child: PlatformText(
                "cancel".tr(),
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            PlatformDialogAction(
              ios: (c) => CupertinoDialogActionData(
                isDestructiveAction: true,
              ),
              child: PlatformText(
                "delete".tr(),
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Navigator.pop(context);
                return LangView.deleteLesson(context,
                    lang: lang, section: section, lesson: lesson);
              },
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<Lang>();
    final section = context.watch<LessonSection>();
    return PlatformCard(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Text(
              lesson.title,
              style: TextStyle(
                fontSize: 30,
                color: ThemeColors.textColor(),
              ),
            ),
            Spacer(),
            PlatformIconButton(
              icon: Icon(PlatformIcons(context).delete),
              onPressed: () => onDeletePressed(context, lang, section),
            ),
            PlatformIconButton(
              icon: Icon(PlatformIcons(context).add),
              onPressed: () => LangView.createLesson(
                context,
                lang: lang,
                section: section,
                insertPosition: lesson.index,
              ),
            )
          ],
        ),
      ),
      onPressed: () {},
    );
  }
}
