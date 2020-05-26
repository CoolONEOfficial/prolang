import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:prolang/app/constants/firebase_paths.dart';
import 'package:prolang/app/helpers/app_bar_shape.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/app/services/firebase_auth_service.dart';
import 'package:prolang/ui/views/form/lesson_phrase_form_view.dart';
import 'package:prolang/ui/views/home/lesson_phrases/widgets/phrase_list.dart';
import 'package:prolang/ui/widgets/firebase_image.dart';
import 'package:prolang/ui/widgets/loading_indicator.dart';
import 'package:prolang/ui/widgets/responsive_safe_area.dart';
import 'package:provider/provider.dart';

import 'lesson_phrases_view_model.dart';

class LessonPhrasesView extends StatelessWidget {
  final Lesson lesson;
  final LessonSection section;
  final Lang lang;

  const LessonPhrasesView({
    Key key,
    this.lesson,
    this.section,
    this.lang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Lesson>(
          create: (_) => lesson,
        ),
        Provider<LessonSection>(
          create: (_) => section,
        ),
        Provider<Lang>(
          create: (_) => lang,
        ),
      ],
      child: ChangeNotifierProvider<LessonPhrasesViewModel>(
        create: (_) => LessonPhrasesViewModel(
          context.read,
          lesson,
          section,
          lang,
        ),
        builder: (context, child) => ResponsiveSafeArea(
          child: PlatformScaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(child: _LessonPhrasesViewBody._()),
            appBar: PlatformAppBar(
              trailingActions:
                  FirebaseAuthService.cachedCurrentUser.uid == lang.adminId
                      ? <Widget>[
                          PlatformIconButton(
                            icon: Icon(PlatformIcons(context).add),
                            onPressed: () => Navigator.of(context).push(
                              platformPageRoute(
                                context: context,
                                builder: (context) => LessonPhraseFormView(
                                  lang: lang,
                                  section: section,
                                  lesson: lesson,
                                  insertPosition: 0,
                                ),
                              ),
                            ),
                          )
                        ]
                      : [],
              title: Text("Грамматика"),
              material: (context, _) => MaterialAppBarData(
                shape: appBarShape(context),
              ),
              cupertino: (context, _) => CupertinoNavigationBarData(
                previousPageTitle: lesson.title,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LessonPhrasesViewBody extends StatelessWidget {
  const _LessonPhrasesViewBody._({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = context
        .select((LessonPhrasesViewModel viewModel) => viewModel.isLoading);

    return isLoading ? LoadingIndicator() : _phrases(context);
  }

  Widget _phrases(BuildContext context) {
    final lesson = context.watch<Lesson>();
    final section = context.watch<LessonSection>();
    final lang = context.watch<Lang>();

    final lessonRef = FirebasePaths.lessonRef(lang, section, lesson);
    final lessonPath = lessonRef.path;

    return LayoutBuilder(builder: (context, constraints) {
      final screenHeight = constraints.maxHeight;
      final screenWidth = constraints.maxWidth;

      return Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            height: screenHeight / 3,
            child: FullScreenWidget(
              child: Center(
                child: Hero(
                  tag: "smallImage",
                  child: FirebaseImage(
                    "$lessonPath/grammar.jpg",
                    fit: BoxFit.contain,
                    width: screenWidth,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: screenHeight / 3 * 2,
            child: PhraseList(
              lessonRef: lessonRef.collection("phrases"),
            ),
          ),
        ],
      );
    });
  }
}
