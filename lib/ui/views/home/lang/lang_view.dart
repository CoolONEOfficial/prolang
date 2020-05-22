import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/constants/ThemeColors.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/ui/views/home/lang/widgets/lesson_appbar.dart';
import 'package:prolang/ui/widgets/firebase_image.dart';
import 'package:prolang/ui/widgets/loading_indicator.dart';
import 'package:prolang/ui/widgets/responsive_safe_area.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sliver_fab/sliver_fab.dart';

import 'lang_view_model.dart';
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
    final lessonList =
        context.select((LangViewModel viewModel) => viewModel.lessonList);

    final media = ((MediaQuery.of(context).size.width - avatarSize) / 2);
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

    final sectionedLessons = groupBy<Lesson, int>(
      lessonList,
      (lesson) => lesson.section,
    ).entries.toList();

    final sectionList = lang.sections.asMap().entries.map(
          (section) => MapEntry(
            section.value,
            sectionedLessons.length > section.key
                ? sectionedLessons[section.key].value
                : <Lesson>[],
          ),
        );

    return ScrollConfiguration(
      behavior: ClampingBehavior(),
      child: SliverFab(
        floatingWidget: Container(
          height: avatarSize,
          width: avatarSize,
          margin: EdgeInsets.only(left: 7.5),
          child: ClipOval(
            child: FirebaseImage(
              '$basePath/avatar.png',
            ),
          ),
        ),
        floatingPosition: FloatingPosition(
          left: media - 10,
          top: -(avatarSize / 2 - 22),
        ),
        expandedHeight: expandedHeight,
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
            (sectionList.isEmpty
                ? [
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PlatformIconButton(
                            icon: Icon(
                              PlatformIcons(context).add,
                              size: 40,
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  ]
                : sectionList.map((section) => LessonSliver(section)).toList()),
      ),
    );
  }

  createSection({int at = 0}) {}
}

class ClampingBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      ClampingScrollPhysics();
}
