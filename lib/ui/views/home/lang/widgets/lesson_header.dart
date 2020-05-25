import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../lang_view.dart';

class LessonHeader extends StatelessWidget {
  const LessonHeader({Key key}) : super(key: key);

  onDeletePressed(
    BuildContext context,
    Lang lang,
    LessonSection section,
  ) =>
      showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
          title: Text("lesson_section.delete.confirmation".tr()),
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
                return LangView.deleteSection(
                  context,
                  lang: lang,
                  section: section,
                );
              },
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final section = context.watch<LessonSection>();
    final lang = context.watch<Lang>();
    final material = isMaterial(context);
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
            vertical: 5.0,
            horizontal: 16.0,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
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
              ),
              PlatformIconButton(
                icon: Icon(
                  PlatformIcons(context).create,
                  color: Colors.white,
                ),
                onPressed: () => LangView.showLessonSectionForm(
                  context,
                  lang: lang,
                  section: section,
                ),
              ),
              PlatformIconButton(
                icon: Icon(
                  PlatformIcons(context).delete,
                  color: Colors.white,
                ),
                onPressed: () => onDeletePressed(context, lang, section),
              ),
              PlatformIconButton(
                icon: Icon(
                  PlatformIcons(context).add,
                  color: Colors.white,
                ),
                onPressed: () => LangView.showLessonSectionForm(
                  context,
                  lang: lang,
                  insertPosition: section.index,
                ),
              ),
              ExpandableTheme(
                data: ExpandableThemeData(
                  useInkWell: isMaterial(context),
                  iconColor: Colors.white,
                  collapseIcon: material ? null : EvilIcons.chevron_up,
                  expandIcon: material ? null : EvilIcons.chevron_down,
                  iconSize: 28,
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
