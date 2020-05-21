import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/constants/ThemeColors.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/ui/views/widgets/firebase_image.dart';
import 'package:prolang/ui/views/widgets/loading_indicator.dart';
import 'package:prolang/ui/views/widgets/responsive_safe_area.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:easy_localization/easy_localization.dart';

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

  Center _loadingIndicator() {
    return Center(
      child: PlatformCircularProgressIndicator(),
    );
  }

  Widget _lang(BuildContext context) {
    final lessonList =
        context.select((LangViewModel viewModel) => viewModel.lessonList);
    final avatarSize = 150.0;
    final media = ((MediaQuery.of(context).size.width - avatarSize) / 2);
    final expandedHeight = getValueForScreenType<double>(
      context: context,
      mobile: 256,
      tablet: 400,
      desktop: 500,
    );
    final lang = context.watch<Lang>();
    final basePath = "langs/${lang.documentId}";

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
          )),
        ),
        floatingPosition: FloatingPosition(
          left: media - 10,
          top: -(avatarSize / 2 - 22),
        ),
        expandedHeight: expandedHeight,
        slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.only(bottom: avatarSize / 2),
                sliver: SliverAppBar(
                  expandedHeight: expandedHeight,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.zero,
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          flex: isMaterial(context) ? 2 : 3,
                          child: Container(),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            lang.title[context.locale.languageCode],
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(),
                        ),
                      ],
                    ),
                    background: Container(
                      foregroundDecoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xCC000000),
                              const Color(0x88000000),
                              Theme.of(context).primaryColor
                            ],
                            stops: [
                              0.2,
                              0.6,
                              1
                            ]),
                      ),
                      child: FirebaseImage(
                        '$basePath/header' +
                            getValueForScreenType<String>(
                              context: context,
                              mobile: "_400x400",
                              tablet: "_400x400",
                              desktop: "",
                            ) +
                            '.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Преподаватель",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: ThemeColors.textColor(context)),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        lang.teacher,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: ThemeColors.textColor(context)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ] +
            groupBy<Lesson, int>(
              lessonList,
              (lesson) => lesson.section,
            ).entries.map((section) => LessonSliver(section)).toList(),
      ),
    );
  }
}

class ClampingBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      ClampingScrollPhysics();
}
