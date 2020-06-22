import 'dart:typed_data';

import 'package:card_settings/card_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/constants/firebase_paths.dart';
import 'package:prolang/app/helpers/form_localization.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/services/firebase_storage_service.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:prolang/ui/widgets/platform_progress_dialog.dart';
import 'package:prolang/ui/widgets/required_indicator.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/ui/widgets/responsive_safe_area.dart';
import 'package:provider/provider.dart';

class LessonFormView extends StatefulWidget {
  final int insertPosition;
  final Lang lang;
  final LessonSection lessonSection;
  final Lesson lesson;

  const LessonFormView({
    this.insertPosition,
    @required this.lang,
    @required this.lessonSection,
    this.lesson,
    Key key,
  }) : super(key: key);

  @override
  _LessonFormState createState() => _LessonFormState(lesson ?? Lesson());
}

class _LessonFormState extends State<LessonFormView> {
  Lesson _lessonModel;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Uint8List _videoFile;
  bool _videoChanged = false;
  Uint8List _grammarSchemeFile;
  bool _grammarChanged = false;
  Uint8List _pdfFile;
  bool _pdfChanged = false;
  Uint8List _imageFile;
  bool _imageChanged = false;
  Uint8List _audioFile;
  bool _audioChanged = false;

  // control state only works if the field order never changes.
  // to support orientation changes, we assign a unique key to each field
  // if you only have one orientation, the _formKey is sufficient
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _descriptionKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _videoKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _grammarKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _pdfKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _audioKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _imageKey = GlobalKey<FormState>();

  _LessonFormState(this._lessonModel);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return ResponsiveSafeArea(
      child: PlatformScaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: PlatformAppBar(
          title: Text("lesson_form.${formLocalizationKey(_lessonModel)}.title")
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
      labelWidth: 200,
      children: <CardSettingsSection>[
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'lesson_form.general.label'.tr(),
          ),
          children: <Widget>[
            _buildCardSettingsText_Title(),
            _buildCardSettingsText_Description(),
            _buildCardSettingsVideo(),
            _buildCardSettingsImage(),
            _buildCardSettingsAudio(),
            _buildCardSettingsPdf(),
            _buildCardSettingsGrammaticalScheme(),
          ],
        ),
      ],
    );
  }

  CardSettings _buildLandscapeLayout() {
    return CardSettings.sectioned(
      labelPadding: 12.0,
      labelWidth: 200,
      children: <CardSettingsSection>[
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'lesson_form.general.label'.tr(),
          ),
          children: <Widget>[
            _buildCardSettingsText_Title(),
            _buildCardSettingsText_Description(),
            _buildCardSettingsVideo(),
            _buildCardSettingsImage(),
            _buildCardSettingsAudio(),
            _buildCardSettingsPdf(),
            _buildCardSettingsGrammaticalScheme(),
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
    return CardSettingsText(
      key: _nameKey,
      label: 'lesson_form.general.title.label'.tr(),
      hintText: 'lesson_form.general.title.hint'.tr(),
      initialValue: _lessonModel.title,
      requiredIndicator: RequiredIndicator(),
      validator: (value) {
        if (value == null || value.isEmpty) return 'required_field'.tr();
        return null;
      },
      onSaved: (value) => _lessonModel = _lessonModel.copyWith(title: value),
      onChanged: (value) {
        setState(() {
          _lessonModel = _lessonModel.copyWith(title: value);
        });
      },
    );
  }

  CardSettingsText _buildCardSettingsText_Description() {
    return CardSettingsParagraph(
      key: _descriptionKey,
      label: 'lesson_form.general.description.label'.tr(),
      hintText: 'lesson_form.general.description.hint'.tr(),
      initialValue: _lessonModel.description,
      onSaved: (value) =>
          _lessonModel = _lessonModel.copyWith(description: value),
      onChanged: (value) {
        setState(() {
          _lessonModel = _lessonModel.copyWith(description: value);
        });
      },
    );
  }

  CardSettingsFilePicker _buildCardSettingsVideo() {
    return CardSettingsFilePicker(
      key: _videoKey,
      label: 'lesson_form.general.video.label'.tr(),
      icon: Icon(PlatformIcons(context).videoCamera),
      initialValue: widget.lesson != null && widget.lesson.videoBytes > 0
          ? Uint8List(widget.lesson.videoBytes)
          : null,
      unattachDialogTitle:
          'lesson_form.general.video.unattach_confirmation'.tr(),
      unattachDialogCancel: 'cancel'.tr(),
      unattachDialogConfirm: 'unattach'.tr(),
      fileExtension: ".mp4",
      fileType: FileTypeCross.custom,
      onChanged: (value) {
        _videoFile = value;
        _videoChanged = true;
        _lessonModel = _lessonModel.copyWith(videoBytes: value.length);
      },
    );
  }

  CardSettingsFilePicker _buildCardSettingsPdf() {
    return CardSettingsFilePicker(
      key: _pdfKey,
      label: 'lesson_form.general.pdf.label'.tr(),
      icon: Icon(PlatformIcons(context).book),
      initialValue: widget.lesson != null && widget.lesson.pdfBytes > 0
          ? Uint8List(widget.lesson.pdfBytes)
          : null,
      unattachDialogTitle: 'lesson_form.general.pdf.unattach_confirmation'.tr(),
      unattachDialogCancel: 'cancel'.tr(),
      unattachDialogConfirm: 'unattach'.tr(),
      fileExtension: ".pdf",
      fileType: FileTypeCross.custom,
      onChanged: (value) {
        _pdfFile = value;
        _pdfChanged = true;
        _lessonModel = _lessonModel.copyWith(pdfBytes: value.length);
      },
    );
  }

  CardSettingsFilePicker _buildCardSettingsAudio() {
    return CardSettingsFilePicker(
      key: _audioKey,
      label: 'lesson_form.general.audio.label'.tr(),
      icon: Icon(PlatformIcons(context).musicNote),
      initialValue: widget.lesson != null && widget.lesson.audioBytes > 0
          ? Uint8List(widget.lesson.audioBytes)
          : null,
      unattachDialogTitle:
          'lesson_form.general.audio.unattach_confirmation'.tr(),
      unattachDialogCancel: 'cancel'.tr(),
      unattachDialogConfirm: 'unattach'.tr(),
      fileExtension: ".mp3",
      fileType: FileTypeCross.custom,
      onChanged: (value) {
        _audioFile = value;
        _audioChanged = true;
        _lessonModel = _lessonModel.copyWith(audioBytes: value.length);
      },
    );
  }

  CardSettingsFilePicker _buildCardSettingsImage() {
    return CardSettingsFilePicker(
      key: _imageKey,
      label: 'lesson_form.general.image.label'.tr(),
      icon: Icon(PlatformIcons(context).photoCamera),
      initialValue: widget.lesson != null && widget.lesson.imageBytes > 0
          ? Uint8List(widget.lesson.imageBytes)
          : null,
      unattachDialogTitle:
          'lesson_form.general.image.unattach_confirmation'.tr(),
      unattachDialogCancel: 'cancel'.tr(),
      unattachDialogConfirm: 'unattach'.tr(),
      fileExtension: ".jpg",
      fileType: FileTypeCross.custom,
      onChanged: (value) {
        _imageFile = value;
        _imageChanged = true;
        _lessonModel = _lessonModel.copyWith(imageBytes: value.length);
      },
    );
  }

  CardSettingsFilePicker _buildCardSettingsGrammaticalScheme() {
    return CardSettingsFilePicker(
      key: _grammarKey,
      label: 'lesson_form.general.grammar.label'.tr(),
      icon: Icon(PlatformIcons(context).photoCamera),
      initialValue: widget.lesson != null && widget.lesson.grammarBytes > 0
          ? Uint8List(widget.lesson.grammarBytes)
          : null,
      unattachDialogTitle:
          'lesson_form.general.grammar.unattach_confirmation'.tr(),
      unattachDialogCancel: 'cancel'.tr(),
      unattachDialogConfirm: 'unattach'.tr(),
      fileExtension: ".jpg",
      fileType: FileTypeCross.custom,
      onChanged: (value) {
        _grammarSchemeFile = value;
        _grammarChanged = true;
        _lessonModel = _lessonModel.copyWith(grammarBytes: value.length);
      },
    );
  }

  // Event handlers

  onDonePressed() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      final key = formLocalizationKey(_lessonModel);

      showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
          title: Text("lesson_form.$key.confirmation".tr()),
          actions: <Widget>[
            PlatformDialogAction(
              child: PlatformText("cancel".tr()),
              onPressed: () => Navigator.pop(context),
            ),
            PlatformDialogAction(
              child: PlatformText(key.tr()),
              onPressed: () {
                Navigator.pop(context);
                applyLesson();
              },
            ),
          ],
        ),
      );
    }
  }

  applyLesson() async {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformProgressDialog(
        text: "lesson_form.${formLocalizationKey(_lessonModel)}.progress".tr(),
      ),
    );

    final fs = context.read<FirestoreService>();
    if (_lessonModel.documentId != null) {
      await fs.updateLesson(
        widget.lang,
        widget.lessonSection,
        _lessonModel,
      );
    } else {
      _lessonModel = _lessonModel.copyWith(
        documentId: await fs.insertLesson(
          widget.lang,
          widget.lessonSection,
          _lessonModel,
          widget.insertPosition,
        ),
      );
    }

    final basePath = FirebasePaths.lessonPath(
      widget.lang,
      widget.lessonSection,
      _lessonModel,
    );

    if (_videoChanged && _videoFile != null) {
      await FirebaseStorageService.uploadToStorage(
        _videoFile,
        "$basePath/video.mp4",
      );
    }

    if (_grammarChanged && _grammarSchemeFile != null) {
      await FirebaseStorageService.uploadToStorage(
        _grammarSchemeFile,
        "$basePath/grammar.jpg",
      );
    }

    if (_audioChanged && _audioFile != null) {
      await FirebaseStorageService.uploadToStorage(
        _audioFile,
        "$basePath/audio.mp3",
      );
    }

    if (_imageChanged && _imageFile != null) {
      await FirebaseStorageService.uploadToStorage(
        _imageFile,
        "$basePath/image.jpg",
      );
    }

    if (_pdfChanged && _pdfFile != null) {
      await FirebaseStorageService.uploadToStorage(
        _pdfFile,
        "$basePath/pdf.pdf",
      );
    }

    Navigator.pop(context);
    Navigator.pop(context, true);
  }
}
