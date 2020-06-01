import 'dart:typed_data';

import 'package:card_settings/card_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/constants/firebase_paths.dart';
import 'package:prolang/app/helpers/form_localization.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/phrase.dart';
import 'package:prolang/app/services/firebase_storage_service.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:prolang/ui/views/form/widgets/card_settings_audio_recorder.dart';
import 'package:prolang/ui/widgets/platform_progress_dialog.dart';
import 'package:prolang/ui/widgets/required_indicator.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/ui/widgets/responsive_safe_area.dart';
import 'package:provider/provider.dart';

class LessonPhraseFormView extends StatefulWidget {
  final int insertPosition;
  final Lang lang;
  final LessonSection section;
  final Lesson lesson;
  final Phrase phrase;

  const LessonPhraseFormView({
    this.insertPosition,
    @required this.lang,
    @required this.section,
    @required this.lesson,
    this.phrase,
    Key key,
  }) : super(key: key);

  @override
  _LessonPhraseFormState createState() =>
      _LessonPhraseFormState(phrase ?? Phrase());
}

class _LessonPhraseFormState extends State<LessonPhraseFormView> {
  Phrase _phraseModel;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Uint8List _audioFile;
  bool _audioChanged = false;

  // control state only works if the field order never changes.
  // to support orientation changes, we assign a unique key to each field
  // if you only have one orientation, the _formKey is sufficient
  final GlobalKey<FormState> _originalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _translatedKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _audioKey = GlobalKey<FormState>();

  _LessonPhraseFormState(this._phraseModel);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return ResponsiveSafeArea(
      child: PlatformScaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: PlatformAppBar(
          title: Text(
                  "lesson_phrase_form.${formLocalizationKey(_phraseModel)}.title")
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
      labelWidth: 160,
      children: <CardSettingsSection>[
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'lesson_phrase_form.general.label'.tr(),
          ),
          children: <Widget>[
            _buildCardSettingsText_Original(),
            _buildCardSettingsText_Translated(),
            _buildCardSettingsAudio(),
          ],
        ),
      ],
    );
  }

  CardSettings _buildLandscapeLayout() {
    return CardSettings.sectioned(
      labelPadding: 12.0,
      labelWidth: 160,
      children: <CardSettingsSection>[
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'lesson_phrase_form.general.label'.tr(),
          ),
          children: <Widget>[
            _buildCardSettingsText_Original(),
            _buildCardSettingsText_Translated(),
            _buildCardSettingsAudio(),
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

  CardSettingsText _buildCardSettingsText_Original() {
    return CardSettingsParagraph(
      key: _originalKey,
      label: 'lesson_phrase_form.general.original.label'.tr(),
      hintText: 'lesson_phrase_form.general.original.hint'.tr(),
      numberOfLines: 2,
      maxLength: 100,
      initialValue: _phraseModel.original,
      requiredIndicator: RequiredIndicator(),
      contentOnNewLine: false,
      validator: (value) {
        if (value == null || value.isEmpty) return 'required_field'.tr();
        return null;
      },
      onSaved: (value) => _phraseModel = _phraseModel.copyWith(original: value),
      onChanged: (value) {
        setState(() {
          _phraseModel = _phraseModel.copyWith(original: value);
        });
      },
    );
  }

  CardSettingsText _buildCardSettingsText_Translated() {
    return CardSettingsParagraph(
      key: _translatedKey,
      label: 'lesson_phrase_form.general.translated.label'.tr(),
      hintText: 'lesson_phrase_form.general.translated.hint'.tr(),
      numberOfLines: 2,
      maxLength: 100,
      initialValue: _phraseModel.translated,
      contentOnNewLine: false,
      requiredIndicator: RequiredIndicator(),
      validator: (value) {
        if (value == null || value.isEmpty) return 'required_field'.tr();
        return null;
      },
      onSaved: (value) =>
          _phraseModel = _phraseModel.copyWith(translated: value),
      onChanged: (value) {
        setState(() {
          _phraseModel = _phraseModel.copyWith(translated: value);
        });
      },
    );
  }

  FormField _buildCardSettingsAudio() {
    onChanged(Uint8List value) {
      _audioFile = value;
      _audioChanged = true;
      _phraseModel = _phraseModel.copyWith(audioBytes: value.length);
    }

    validator(Uint8List value) {
      if (value == null || value.isEmpty) return 'required_field'.tr();
      return null;
    }

    final label = 'lesson_phrase_form.general.audio.label'.tr();
    final initial = (_phraseModel.audioBytes ?? 0) != 0
        ? Uint8List(_phraseModel.audioBytes)
        : null;
    final unattachDialogTitle =
        'lesson_phrase_form.general.audio.unattach_confirmation'.tr();
    final unattachDialogCancel = 'cancel'.tr();
    final unattachDialogConfirm = 'unattach'.tr();
    final icon = Icon(PlatformIcons(context).musicNote);

    return kIsWeb
        ? CardSettingsFilePicker(
            key: _audioKey,
            label: label,
            initialValue: initial,
            fileExtension: '.mp3',
            unattachDialogTitle: unattachDialogTitle,
            unattachDialogCancel: unattachDialogCancel,
            unattachDialogConfirm: unattachDialogConfirm,
            fileType: FileTypeCross.custom,
            requiredIndicator: RequiredIndicator(),
            validator: validator,
            onChanged: onChanged,
            icon: icon,
          )
        : CardSettingsAudioRecorder(
            key: _audioKey,
            label: label,
            initialValue: initial,
            unattachDialogTitle: unattachDialogTitle,
            unattachDialogCancel: unattachDialogCancel,
            unattachDialogConfirm: unattachDialogConfirm,
            requiredIndicator: RequiredIndicator(),
            validator: validator,
            onChanged: onChanged,
            icon: icon,
          );
  }

  // Event handlers

  onDonePressed() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      final key = formLocalizationKey(_phraseModel);

      showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
          title: Text("lesson_phrase_form.$key.confirmation".tr()),
          actions: <Widget>[
            PlatformDialogAction(
              child: PlatformText("cancel".tr()),
              onPressed: () => Navigator.pop(context),
            ),
            PlatformDialogAction(
              child: PlatformText(key.tr()),
              onPressed: () {
                Navigator.pop(context);
                applyLessonPhrase();
              },
            ),
          ],
        ),
      );
    }
  }

  applyLessonPhrase() async {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformProgressDialog(
        text: "lesson_phrase_form.${formLocalizationKey(_phraseModel)}.progress"
            .tr(),
      ),
    );

    final fs = context.read<FirestoreService>();
    if (_phraseModel.documentId != null) {
      await fs.updateLessonPhrase(
        widget.lang,
        widget.section,
        widget.lesson,
        _phraseModel,
      );
    } else {
      _phraseModel = _phraseModel.copyWith(
        documentId: await fs.insertLessonPhrase(
          widget.lang,
          widget.section,
          widget.lesson,
          _phraseModel,
          widget.insertPosition,
        ),
      );
    }

    final basePath = FirebasePaths.phrasePath(
      widget.lang,
      widget.section,
      widget.lesson,
      _phraseModel,
    );

    if (_audioChanged && _audioFile != null) {
      await FirebaseStorageService.uploadToStorage(
        _audioFile,
        "$basePath/audio.mp3",
      );
    }

    Navigator.pop(context);
    Navigator.pop(context, true);
  }
}
