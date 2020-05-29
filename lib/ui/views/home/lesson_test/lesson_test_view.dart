import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/constants/firebase_paths.dart';
import 'package:prolang/app/helpers/app_bar_shape.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/app/services/firebase_auth_service.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:prolang/app/extensions/map_get.dart';
import 'package:prolang/ui/views/form/lesson_question_form_view.dart';
import 'package:prolang/ui/views/home/lang/lang_view.dart';
import 'package:prolang/ui/views/home/lesson/lesson_view.dart';
import 'package:prolang/ui/views/home/lesson_test/helpers/answer_to_color.dart';
import 'package:prolang/ui/views/home/lesson_test/widgets/question_entry.dart';
import 'package:prolang/ui/views/home/lesson_test/widgets/test_results.dart';
import 'package:prolang/ui/widgets/loading_indicator.dart';
import 'package:prolang/ui/widgets/responsive_safe_area.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tinycolor/tinycolor.dart';

import 'lesson_test_view_model.dart';

class LessonTestView extends StatelessWidget {
  final Lesson lesson;
  final LessonSection section;
  final Lang lang;

  const LessonTestView({
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
      child: ChangeNotifierProvider<LessonTestViewModel>(
        create: (_) => LessonTestViewModel(
          context.read,
          lesson,
          section,
          lang,
        ),
        builder: (context, child) {
          final vm = context.watch<LessonTestViewModel>();
          return ResponsiveSafeArea(
            child: PlatformScaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(child: _LessonTestViewBody._()),
              appBar: PlatformAppBar(
                trailingActions: FirebaseAuthService.cachedCurrentUser.uid ==
                        lang.adminId
                    ? <Widget>[
                        PlatformIconButton(
                          icon: Icon(PlatformIcons(context).add),
                          onPressed: () async {
                            if (await Navigator.of(context).push(
                                  platformPageRoute(
                                    context: context,
                                    builder: (context) =>
                                        LessonQuestionFormView(
                                      lang: lang,
                                      section: section,
                                      lesson: lesson,
                                      insertPosition: vm.questionList.length,
                                    ),
                                  ),
                                ) ==
                                true) {
                              context
                                  .read<LessonTestViewModel>()
                                  .loadQuestionList();
                            }
                          },
                        )
                      ]
                    : [],
                title: Text("Тест"),
                material: (context, _) => MaterialAppBarData(
                  shape: appBarShape(context),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LessonTestViewBody extends StatefulWidget {
  const _LessonTestViewBody._({Key key}) : super(key: key);

  @override
  _LessonTestViewBodyState createState() => _LessonTestViewBodyState();
}

class _LessonTestViewBodyState extends State<_LessonTestViewBody> {
  List<double> answers = [];

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((LessonTestViewModel viewModel) => viewModel.isLoading);

    return isLoading ? LoadingIndicator() : _test(context);
  }

  Widget _test(BuildContext context) {
    final vm = context.watch<LessonTestViewModel>();
    final lang = context.watch<Lang>();
    final section = context.watch<LessonSection>();
    final lesson = context.watch<Lesson>();
    final questionList = vm.questionList;
    final step = vm.step;

    if (questionList.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(PlatformIcons(context).work, size: 100),
            SizedBox(height: 20),
            Text(
              "Вопросов нет",
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      );
    }

    final roundAppBar = getValueForScreenType(
      context: context,
      desktop: true,
      tablet: true,
      mobile: false,
    );

    return step < questionList.length
        ? Column(
            children: <Widget>[
              Padding(
                padding: roundAppBar
                    ? const EdgeInsets.only(top: 5.0)
                    : EdgeInsets.zero,
                child: StepProgressIndicator(
                  totalSteps: questionList.length,
                  currentStep: step,
                  size: (roundAppBar ? 10 : 5) +
                      (FirebaseAuthService.cachedCurrentUser.uid == lang.adminId
                          ? 10.0
                          : 0.0),
                  padding: 1,
                  roundedEdges:
                      roundAppBar ? const Radius.circular(5) : Radius.zero,
                  customStep: (index, _, __) {
                    Color color;
                    if (answers.length > index) {
                      color = answerToColor(answers[index]).withOpacity(0.8);
                    } else {
                      color = Theme.of(context).disabledColor;
                    }
                    return GestureDetector(
                      child: Container(
                        color: index == step
                            ? TinyColor(color).darken(10).color
                            : color,
                        child: FirebaseAuthService.cachedCurrentUser.uid ==
                                lang.adminId
                            ? Text(
                                questionList[index].title,
                                textAlign: TextAlign.center,
                              )
                            : null,
                      ),
                      onTap: () {
                        if (FirebaseAuthService.cachedCurrentUser.uid ==
                            lang.adminId) {
                          setState(() {
                            vm.step = index;
                          });
                        }
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: QuestionEntry(
                  questionList[step],
                  key: Key(step.toString()),
                  onNext: (result) async {
                    setState(() {
                      answers.add(result);
                      vm.step++;
                    });

                    if (vm.step == questionList.length &&
                        FirebaseAuthService.cachedCurrentUser
                                .lessonResult(lang, section, lesson) <
                            answers.reduce((a, b) => a + b) / answers.length) {
                      final fs = context.read<FirestoreService>();
                      await fs.userCompleteTest(
                        lang,
                        section,
                        lesson,
                        questionList.length / answers.reduce((a, b) => a + b),
                      );
                    }
                  },
                ),
              ),
            ],
          )
        : TestResults(
            answers,
            onNext: () async {
              int count = 0;
              final nextLesson =
                  (await FirebasePaths.lessonSectionRef(lang, section)
                          .collection("lessons")
                          .orderBy("index")
                          .startAfter([lesson.index])
                          .limit(1)
                          .getDocuments())
                      .documents;
              if (nextLesson == null || nextLesson.isEmpty) {
                Navigator.popUntil(context, (route) {
                  return count++ == 2;
                });
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    platformPageRoute(
                      context: context,
                      builder: (_) => LessonView(
                        lang: lang,
                        section: section,
                        lesson: Lesson.fromSnapshot(nextLesson.first),
                      ),
                    ), (route) {
                  return count++ == 2;
                });
              }
            },
            onRestart: () {
              setState(() {
                answers = [];
                vm.step = 0;
              });
            },
          );
  }
}
