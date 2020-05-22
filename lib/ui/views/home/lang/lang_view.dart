import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/constants/theme_colors.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:prolang/ui/views/home/lang/widgets/lesson_appbar.dart';
import 'package:prolang/ui/widgets/firebase_image.dart';
import 'package:prolang/ui/widgets/loading_indicator.dart';
import 'package:prolang/ui/widgets/platform_progress_dialog.dart';
import 'package:prolang/ui/widgets/responsive_safe_area.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:easy_localization/easy_localization.dart';

import 'form/lesson_form_view.dart';
import 'form/lesson_section_form_view.dart';
import 'lang_view_model.dart';
import 'widgets/lesson_fab.dart';
import 'widgets/lesson_sliver.dart';

class LangView extends StatelessWidget {
  const LangView(
    this.lang, {
    this.iosTitle = "",
    Key key,
  }) : super(key: key);

  final Lang lang;
  final String iosTitle;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Lang>(
          create: (_) => lang,
        )
      ],
      child: ChangeNotifierProvider<LangViewModel>(
        create: (_) => LangViewModel(context.read, lang),
        builder: (_, child) {
          return PlatformScaffold(
            body: _LangViewBody._(iosTitle),
          );
        },
      ),
    );
  }

  static deleteSection(
    BuildContext context, {
    Lang lang,
    LessonSection section,
  }) async {
    showPlatformDialog(
      context: context,
      builder: (_) =>
          PlatformProgressDialog(text: "lang.lesson_section.delete.progress".tr()),
    );
    await context.read<FirestoreService>().deleteLessonSection(lang, section);
    context.read<LangViewModel>().loadLessonList();
    Navigator.pop(context);
  }

  static deleteLesson(
    BuildContext context, {
    Lang lang,
    LessonSection section,
    Lesson lesson,
  }) async {
    showPlatformDialog(
      context: context,
      builder: (_) =>
          PlatformProgressDialog(text: "lang.lesson.delete.progress".tr()),
    );
    await context.read<FirestoreService>().deleteLesson(lang, section, lesson);
    context.read<LangViewModel>().loadLessonList();
    Navigator.pop(context);
  }

  static createSection(
    BuildContext context, {
    Lang lang,
    int insertPosition = 0,
  }) async {
    if (await Navigator.of(context).push(platformPageRoute(
          context: context,
          builder: (context) => LessonSectionFormView(
            insertPosition: insertPosition,
            lang: lang,
          ),
        )) ==
        true) {
      context.read<LangViewModel>().loadLessonList();
    }
  }

  static createLesson(
    BuildContext context, {
    Lang lang,
    LessonSection section,
    int insertPosition = 0,
  }) async {
    if (await Navigator.of(context).push(platformPageRoute(
          context: context,
          builder: (context) => LessonFormView(
            insertPosition: insertPosition,
            lang: lang,
            lessonSection: section,
          ),
        )) ==
        true) {
      context.read<LangViewModel>().loadLessonList();
    }
  }
}

class _LangViewBody extends StatelessWidget {
  const _LangViewBody._(this.iosTitle, {Key key}) : super(key: key);

  final String iosTitle;

  static const avatarSize = 150.0;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((LangViewModel viewModel) => viewModel.isLoading);

    return ResponsiveSafeArea(
      child: isLoading ? LoadingIndicator() : _lang(context),
      top: false,
      bottom: false,
    );
  }

  Widget _lang(BuildContext context) {
    final sectionList =
        context.select((LangViewModel viewModel) => viewModel.sectionList);

    final expandedHeight = getValueForScreenType<double>(
      context: context,
      mobile: 256,
      tablet: 400,
      desktop: 500,
    );
    final lang = context.watch<Lang>();
    final basePath = "langs/${lang.documentId}";
    final headTextAlign = getValueForScreenType(
      context: context,
      mobile: CrossAxisAlignment.center,
      tablet: CrossAxisAlignment.start,
    );

    return ScrollConfiguration(
      behavior: ClampingBehavior(),
      child: LessonFab(
        expandedHeight: expandedHeight,
        avatarSize: avatarSize,
        basePath: basePath,
        slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.only(
                  bottom: getValueForScreenType(
                    context: context,
                    mobile: avatarSize / 2,
                    tablet: 0,
                  ),
                ),
                sliver: LessonAppBar(
                  expandedHeight: expandedHeight,
                  basePath: basePath,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: headTextAlign,
                    children: <Widget>[
                      Text(
                        "Преподаватель",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: ThemeColors.textColor()),
                      ),
                      Text(
                        lang.teacher,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: ThemeColors.textColor()),
                      ),
                    ],
                  ),
                ),
              ),
            ] +
            sectionList.map((section) => LessonSliver(section)).toList() +
            [
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: PlatformIconButton(
                        icon: Icon(
                          PlatformIcons(context).add,
                          size: 40,
                        ),
                        onPressed: () => LangView.createSection(
                          context,
                          insertPosition: sectionList.length,
                          lang: lang,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
      ),
    );
  }
}

class ClampingBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      ClampingScrollPhysics();
}
