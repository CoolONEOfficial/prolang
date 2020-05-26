import 'package:card_settings/card_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/helpers/form_localization.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/question.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:prolang/ui/widgets/platform_progress_dialog.dart';
import 'package:prolang/ui/widgets/required_indicator.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/ui/widgets/responsive_safe_area.dart';
import 'package:provider/provider.dart';

class LessonQuestionFormView extends StatefulWidget {
  final int insertPosition;
  final Lang lang;
  final LessonSection section;
  final Lesson lesson;
  final Question question;

  const LessonQuestionFormView({
    this.insertPosition,
    @required this.lang,
    @required this.section,
    @required this.lesson,
    this.question,
    Key key,
  }) : super(key: key);

  @override
  _LessonQuestionFormState createState() =>
      _LessonQuestionFormState(question ?? Question());
}

class _LessonQuestionFormState extends State<LessonQuestionFormView> {
  Question _questionModel;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // control state only works if the field order never changes.
  // to support orientation changes, we assign a unique key to each field
  // if you only have one orientation, the _formKey is sufficient
  final GlobalKey<FormState> _titleKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _answersKey = GlobalKey<FormState>();

  _LessonQuestionFormState(this._questionModel);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return ResponsiveSafeArea(
      child: PlatformScaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: PlatformAppBar(
          title: Text(
                  "lesson_question_form.${formLocalizationKey(_questionModel)}.title")
              .tr(),
          trailingActions: <Widget>[
            PlatformIconButton(
              icon: Icon(PlatformIcons(context).done),
              onPressed: onDonePressed,
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: orientation == Orientation.portrait
              ? _buildPortraitLayout()
              : _buildLandscapeLayout(),
        ),
      ),
    );
  }

  /* CARDSETTINGS FOR EACH LAYOUT */

  CardSettings _buildPortraitLayout() {
    return CardSettings.sectioned(
      labelWidth: 100,
      children: <CardSettingsSection>[
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'lesson_question_form.general.label'.tr(),
          ),
          children: <Widget>[
            _buildCardSettingsText_Title(),
            _buildCardSettingsAnswers(),
            _buildCardSettingsCorrectAnswers(),
          ],
        ),
      ],
    );
  }

  CardSettings _buildLandscapeLayout() {
    return CardSettings.sectioned(
      labelPadding: 12.0,
      children: <CardSettingsSection>[
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'lesson_question_form.general.label'.tr(),
          ),
          children: <Widget>[
            _buildCardSettingsText_Title(),
            _buildCardSettingsAnswers(),
            _buildCardSettingsCorrectAnswers(),
            // CardFieldLayout(
            //   <Widget>[
            //     _buildCardSettingsRadioPicker_Gender(),
            //     _buildCardSettingsNumberPicker_Age(labelAlign: TextAlign.right),
            //   ],
            //   flexValues: [2, 1],
            // ),
          ],
        ),
      ],
    );
  }

  CardSettingsText _buildCardSettingsText_Title() {
    return CardSettingsParagraph(
      key: _titleKey,
      label: 'lesson_question_form.general.title.label'.tr(),
      hintText: 'lesson_question_form.general.title.hint'.tr(),
      numberOfLines: 2,
      maxLength: 100,
      initialValue: _questionModel.title,
      requiredIndicator: RequiredIndicator(),
      contentOnNewLine: false,
      validator: (value) {
        if (value == null || value.isEmpty) return 'required_field'.tr();
        return null;
      },
      onSaved: (value) =>
          _questionModel = _questionModel.copyWith(title: value),
      onChanged: (value) {
        setState(() {
          _questionModel = _questionModel.copyWith(title: value);
        });
      },
    );
  }

  List<String> _parseAnswers(String str) {
    return str.split("\n");
  }

  CardSettingsParagraph _buildCardSettingsAnswers() {
    return CardSettingsParagraph(
      key: _answersKey,
      label: 'lesson_question_form.general.answers.label'.tr(),
      hintText: 'lesson_question_form.general.answers.hint'.tr(),
      numberOfLines: 1 + (_questionModel.answers?.length ?? 0),
      maxLength: 100,
      initialValue: _questionModel.answers?.join("\n"),
      contentOnNewLine: false,
      requiredIndicator: RequiredIndicator(),
      validator: (value) {
        if (value == null || value.isEmpty) return 'required_field'.tr();
        return null;
      },
      onSaved: (value) => _questionModel = _questionModel.copyWith(
        answers: _parseAnswers(value),
      ),
      onChanged: (value) {
        setState(() {
          final answers = _parseAnswers(value);
          _questionModel = _questionModel.copyWith(
            answers: answers,
          );
        });
      },
    );
  }

  List<String> get validAnswers =>
      _questionModel.answers
          ?.where((element) => element.isNotEmpty)
          ?.toList() ??
      [];

  List<int> _parseCorrectAnswers(List<String> strList) =>
      strList.map((answer) => _questionModel.answers.indexOf(answer)).toList();

  CardSettingsCheckboxPicker _buildCardSettingsCorrectAnswers() {
    return CardSettingsCheckboxPicker(
      key: Key(validAnswers.join()),
      label: 'lesson_question_form.general.correctAnswers.label'.tr(),
      initialValues: _questionModel.correctAnswers
              ?.map((index) => validAnswers[index])
              ?.toList() ??
          [],
      options: validAnswers,
      visible: (validAnswers?.length ?? 0) > 1,
      requiredIndicator: RequiredIndicator(),
      validator: (value) {
        if (value == null || value.isEmpty) return 'required_field'.tr();
        return null;
      },
      onSaved: (value) {
        _questionModel = _questionModel.copyWith(
          correctAnswers: _parseCorrectAnswers(value),
        );
      },
      onChanged: (value) {
        setState(() {
          _questionModel = _questionModel.copyWith(
            correctAnswers: _parseCorrectAnswers(value),
          );
        });
      },
    );
  }

  // Event handlers

  onDonePressed() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      final key = formLocalizationKey(_questionModel);

      showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
          title: Text("lesson_question_form.$key.confirmation".tr()),
          actions: <Widget>[
            PlatformDialogAction(
              child: PlatformText("cancel".tr()),
              onPressed: () => Navigator.pop(context),
            ),
            PlatformDialogAction(
              child: PlatformText(key.tr()),
              onPressed: () {
                Navigator.pop(context);
                applyLessonQuestion();
              },
            ),
          ],
        ),
      );
    }
  }

  applyLessonQuestion() async {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformProgressDialog(
        text:
            "lesson_question_form.${formLocalizationKey(_questionModel)}.progress"
                .tr(),
      ),
    );

    final fs = context.read<FirestoreService>();
    if (_questionModel.documentId != null) {
      await fs.updateLessonQuestion(
        widget.lang,
        widget.section,
        widget.lesson,
        _questionModel,
      );
    } else {
      await fs.insertLessonQuestion(
        widget.lang,
        widget.section,
        widget.lesson,
        _questionModel,
        widget.insertPosition,
      );
    }

    Navigator.pop(context);
    Navigator.pop(context, true);
  }
}
