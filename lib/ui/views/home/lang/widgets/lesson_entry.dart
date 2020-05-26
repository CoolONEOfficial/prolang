import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/constants/theme_colors.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/extensions/map_get.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/app/services/firebase_auth_service.dart';
import 'package:prolang/ui/views/home/lesson/lesson_view.dart';
import 'package:prolang/ui/widgets/platform_card.dart';
import 'package:prolang/ui/widgets/platform_card_button.dart';
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
          title: Text("lesson.delete.confirmation".tr()),
          actions: <Widget>[
            PlatformDialogAction(
              child: PlatformText(
                "cancel".tr(),
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            PlatformDialogAction(
              cupertino: (_, __) => CupertinoDialogActionData(
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
    return PlatformCardButton(
      color: Theme.of(context).cardColor,
      child: Row(
        children: <Widget>[
              Text(
                lesson.title,
              ),
            ] +
            (FirebaseAuthService.cachedCurrentUser.uid == lang.adminId
                ? [
                    Spacer(),
                    PlatformIconButton(
                      icon: Icon(
                        PlatformIcons(context).create,
                        color: ThemeColors.iconColor(),
                      ),
                      onPressed: () => LangView.showLessonForm(
                        context,
                        lang: lang,
                        section: section,
                        lesson: lesson,
                      ),
                    ),
                    PlatformIconButton(
                      icon: Icon(
                        PlatformIcons(context).delete,
                        color: ThemeColors.iconColor(),
                      ),
                      onPressed: () => onDeletePressed(context, lang, section),
                    ),
                    PlatformIconButton(
                      icon: Icon(
                        PlatformIcons(context).add,
                        color: ThemeColors.iconColor(),
                      ),
                      onPressed: () => LangView.showLessonForm(
                        context,
                        lang: lang,
                        section: section,
                        insertPosition: lesson.index,
                      ),
                    )
                  ]
                : FirebaseAuthService.cachedCurrentUser.progress
                            .get(lang.documentId)
                            .get(section.documentId)
                            .get(lesson.documentId) >
                        3 / 2
                    ? [
                        Spacer(),
                        Icon(
                          PlatformIcons(context).done,
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      ]
                    : []),
      ),
      onPressed: () => Navigator.of(context).push(platformPageRoute(
        context: context,
        builder: (context) =>
            LessonView(lesson: lesson, lang: lang, section: section),
        iosTitle: section.title,
      )),
    );
  }
}
