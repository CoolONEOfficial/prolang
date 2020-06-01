import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_platform_widgets/src/platform.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/app/models/question.dart';
import 'package:prolang/app/services/firebase_auth_service.dart';
import 'package:prolang/ui/views/form/lesson_question_form_view.dart';
import 'package:prolang/ui/views/home/lesson_test/helpers/answer_to_color.dart';
import 'package:prolang/ui/views/home/lesson_test/lesson_test_view_model.dart';
import 'package:prolang/ui/widgets/platform_card_button.dart';
import 'package:prolang/ui/widgets/responsive_content.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import 'answer_entry.dart';

class QuestionEntry extends StatefulWidget {
  final Question question;
  final Function(double) onNext;

  const QuestionEntry(
    this.question, {
    Key key,
    this.onNext,
  }) : super(key: key);

  @override
  _QuestionEntryState createState() => _QuestionEntryState();
}

class _QuestionEntryState extends State<QuestionEntry> {
  List<int> selectedAnswers = [];
  List<GlobalKey<AnswerEntryState>> answerKeys;
  static bool toggleLock = false;

  @override
  void initState() {
    super.initState();

    answerKeys = List<GlobalKey<AnswerEntryState>>.generate(
        widget.question.answers.length, (index) => GlobalKey());
  }

  onDeletePressed(
    BuildContext context,
    Lang lang,
    LessonSection section,
    Lesson lesson,
  ) {
    final vm = context.read<LessonTestViewModel>();

    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: Text("lesson_question.delete.confirmation".tr()),
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
              vm.deleteQuestion(widget.question);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<Lang>();
    final section = context.watch<LessonSection>();
    final lesson = context.watch<Lesson>();
    final vm = context.watch<LessonTestViewModel>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FirebaseAuthService.cachedCurrentUser.uid == lang.adminId
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  PlatformIconButton(
                    icon: Icon(PlatformIcons(context).delete),
                    onPressed: () => onDeletePressed(
                      context,
                      lang,
                      section,
                      lesson,
                    ),
                  ),
                  PlatformIconButton(
                    icon: Icon(PlatformIcons(context).create),
                    onPressed: () async {
                      if (await Navigator.of(context).push(
                            platformPageRoute(
                              context: context,
                              builder: (context) => LessonQuestionFormView(
                                lang: lang,
                                section: section,
                                lesson: lesson,
                                question: widget.question,
                              ),
                            ),
                          ) ==
                          true) {
                        vm.loadQuestionList();
                      }
                    },
                  ),
                  PlatformIconButton(
                    icon: Icon(PlatformIcons(context).add),
                    onPressed: () async {
                      if (await Navigator.of(context).push(
                            platformPageRoute(
                              context: context,
                              builder: (context) => LessonQuestionFormView(
                                lang: lang,
                                section: section,
                                lesson: lesson,
                                insertPosition:
                                    vm.questionList.indexOf(widget.question),
                              ),
                            ),
                          ) ==
                          true) {
                        context.read<LessonTestViewModel>().loadQuestionList();
                      }
                    },
                  ),
                ],
              )
            : SizedBox(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AutoSizeText(
            widget.question.title,
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        Flexible(
          child: SingleChildScrollView(
            child: ResponsiveGridRow(
              children: widget.question.answers.asMap().entries.map(
                (entry) {
                  final index = entry.key;
                  final answer = entry.value;

                  return ResponsiveGridCol(
                    md: 6,
                    sm: 12,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: AnswerEntry(
                        answer,
                        key: answerKeys[index],
                        onPressed: (bool enabled) {
                          setState(() {
                            if (enabled) {
                              selectedAnswers.add(index);
                            } else {
                              selectedAnswers.remove(index);
                            }
                          });

                          if (widget.question.correctAnswers.length == 1 && !toggleLock) {
                            toggleLock = true;
                            while (selectedAnswers.length > 1) {
                              answerKeys[selectedAnswers.first].currentState.toggle();
                            }
                            toggleLock = false;
                          }
                        },
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
        FirebaseAuthService.cachedCurrentUser.uid == lang.adminId
            ? Container()
            : Padding(
                padding: EdgeInsets.all(16.0).add(EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom)),
                child: PlatformCardButton(
                  enabled: selectedAnswers.isNotEmpty,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Проверить",
                      ),
                    ],
                  ),
                  onPressed: () async {
                    await showPlatformModalSheet(
                      context: context,
                      cupertino:
                          CupertinoModalSheetData(semanticsDismissible: false),
                      material: MaterialModalSheetData(isDismissible: false),
                      builder: _modalSheet,
                    );
                    widget.onNext(_correctAnswer);
                  },
                ),
              ),
      ],
    );
  }

  double get _correctAnswer {
    final selectedSet = selectedAnswers.toSet();
    final correctSet = widget.question.correctAnswers.toSet();
    final uncorrectSet =
        widget.question.answers.asMap().keys.toSet().difference(correctSet);
    return max(
        0,
        (correctSet.intersection(selectedSet).length / correctSet.length -
            uncorrectSet.intersection(selectedSet).length));
  }

  Widget _modalSheet(BuildContext context) {
    final correctAnswer = _correctAnswer;
    final color = answerToColor(correctAnswer);
    final backgroundColor = Theme.of(context).cardColor;

    return Container(
      color: backgroundColor,
      child: ResponsiveContent(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                correctAnswer == 1
                    ? "Верно!"
                    : correctAnswer == 0 ? "Неверно" : "Частично верно",
                style: Theme.of(context).textTheme.headline4.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 16.0),
              PlatformCardButton(
                color: color,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Дальше",
                      style: TextStyle(
                        color: backgroundColor,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
