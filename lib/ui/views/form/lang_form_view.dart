import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:card_settings/card_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:emojis/emoji.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:image/image.dart' as Image;
import 'package:prolang/app/constants/firebase_paths.dart';
import 'package:prolang/app/helpers/form_localization.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/services/firebase_storage_service.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:prolang/ui/views/form/widgets/image_crop_dialog.dart';
import 'package:prolang/ui/widgets/platform_progress_dialog.dart';
import 'package:prolang/ui/widgets/required_indicator.dart';
import 'package:prolang/ui/widgets/responsive_safe_area.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor/tinycolor.dart';

class LangFormView extends StatefulWidget {
  final int insertPosition;
  final Lang lang;

  const LangFormView({
    this.insertPosition,
    this.lang,
    Key key,
  }) : super(key: key);

  @override
  _LangFormState createState() => _LangFormState(lang ?? Lang());
}

class _LangFormState extends State<LangFormView> {
  Lang _langModel;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Uint8List _avatarFile;
  bool _avatarChanged = false;
  Uint8List _headerFile;
  bool _headerChanged = false;

  // control state only works if the field order never changes.
  // to support orientation changes, we assign a unique key to each field
  // if you only have one orientation, the _formKey is sufficient
  final GlobalKey<FormState> _titleKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _flagKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _teacherKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _colorKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _headerKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _avatarKey = GlobalKey<FormState>();

  _LangFormState(this._langModel);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return ResponsiveSafeArea(
      child: PlatformScaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: PlatformAppBar(
          title:
              Text("lang_form.${formLocalizationKey(_langModel)}.title").tr(),
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
      labelWidth: 180,
      children: <CardSettingsSection>[
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'lang_form.general.label'.tr(),
          ),
          children: <Widget>[
            _buildCardSettingsText_Title(),
            _buildCardSettingsTeacher(),
            _buildCardSettingsColor(),
            _buildCardSettingsAvatar(),
            _buildCardSettingsHeader(),
            _buildCardSettingsFlag(),
          ],
        ),
      ],
    );
  }

  CardSettings _buildLandscapeLayout() {
    return CardSettings.sectioned(
      labelPadding: 12.0,
      labelWidth: 180,
      children: <CardSettingsSection>[
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'lang_form.general.label'.tr(),
          ),
          children: <Widget>[
            _buildCardSettingsText_Title(),
            _buildCardSettingsTeacher(),
            _buildCardSettingsColor(),
            _buildCardSettingsAvatar(),
            _buildCardSettingsHeader(),
            _buildCardSettingsFlag(),
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
      key: _titleKey,
      label: 'lang_form.general.title.label'.tr(),
      hintText: 'lang_form.general.title.hint'.tr(),
      initialValue: _langModel.title,
      requiredIndicator: RequiredIndicator(),
      validator: (value) {
        if (value == null || value.isEmpty) return 'required_field'.tr();
        return null;
      },
      onSaved: (value) => _langModel = _langModel.copyWith(title: value),
      onChanged: (value) {
        setState(() {
          _langModel = _langModel.copyWith(title: value);
        });
      },
    );
  }

  CardSettingsSelectionPicker _buildCardSettingsFlag() {
    return CardSettingsSelectionPicker(
      options: Emoji.byGroup(EmojiGroup.flags)
          .map<String>((emoji) => emoji.char)
          .toList(),
      icon: Icon(PlatformIcons(context).flag),
      key: _flagKey,
      label: 'lang_form.general.flag.label'.tr(),
      hintText: 'lang_form.general.flag.hint'.tr(),
      initialValue: _langModel.flag,
      requiredIndicator: RequiredIndicator(),
      validator: (value) {
        if (value == null || value.isEmpty) return 'required_field'.tr();
        return null;
      },
      onSaved: (value) => _langModel = _langModel.copyWith(flag: value),
      onChanged: (value) {
        setState(() {
          _langModel = _langModel.copyWith(flag: value);
        });
      },
    );
  }

  CardSettingsText _buildCardSettingsTeacher() {
    return CardSettingsText(
      key: _teacherKey,
      label: 'lang_form.general.teacher.label'.tr(),
      hintText: 'lang_form.general.teacher.hint'.tr(),
      initialValue: _langModel.teacher,
      requiredIndicator: RequiredIndicator(),
      validator: (value) {
        if (value == null || value.length == 0) return 'required_field'.tr();
        return null;
      },
      onSaved: (value) => _langModel = _langModel.copyWith(teacher: value),
      onChanged: (value) {
        setState(() {
          _langModel = _langModel.copyWith(teacher: value);
        });
      },
    );
  }

  CardSettingsColorPicker _buildCardSettingsColor() {
    return CardSettingsColorPicker(
      key: _colorKey,
      label: 'lang_form.general.color.label'.tr(),
      initialValue: _langModel.color != null
          ? TinyColor.fromString(_langModel.color).color
          : null,
      pickerType: CardSettingsColorPickerType.material,
      requiredIndicator: RequiredIndicator(),
      validator: (value) {
        if (value == null) return 'required_field'.tr();
        return null;
      },
      onSaved: (value) => _langModel = _langModel.copyWith(
        color: '#${value.value.toRadixString(16)}',
      ),
      onChanged: (value) {
        setState(() {
          _langModel = _langModel.copyWith(
            color: '#${value.value.toRadixString(16)}',
          );
        });
      },
    );
  }

  CardSettingsFilePicker _buildCardSettingsAvatar() {
    return CardSettingsFilePicker(
      key: _avatarKey,
      label: 'lang_form.general.avatar.label'.tr(),
      icon: Icon(PlatformIcons(context).person),
      initialValue:
          widget.lang != null ? Uint8List(widget.lang.avatarBytes) : null,
      unattachDialogTitle:
          'lang_form.general.avatar.unattach_confirmation'.tr(),
      unattachDialogCancel: 'cancel'.tr(),
      unattachDialogConfirm: 'unattach'.tr(),
      requiredIndicator: RequiredIndicator(),
      fileType: FileTypeCross.image,
      validator: (value) {
        if (value == null || value.length == 0) return 'required_field'.tr();
        return null;
      },
      onChanged: (value) async {
        if (value != null) {
          ui.Image cropped = await Navigator.of(context).push(
            platformPageRoute(
              context: context,
              builder: (context) => ImageCropDialog(value),
            ),
          );
          if (cropped == null) {
            return;
          }
          final byteData = await cropped.toByteData();
          var image = Image.Image.fromBytes(
            cropped.width,
            cropped.height,
            byteData.buffer.asUint8List(
              byteData.offsetInBytes,
              byteData.lengthInBytes,
            ),
          );
          _avatarFile = Image.encodePng(image);
        } else {
          _avatarFile = null;
        }
        _avatarChanged = true;
        _langModel = _langModel.copyWith(
          avatarBytes: _avatarFile?.length ?? 0,
        );
      },
    );
  }

  CardSettingsFilePicker _buildCardSettingsHeader() {
    return CardSettingsFilePicker(
      key: _headerKey,
      label: 'lang_form.general.header.label'.tr(),
      icon: Icon(PlatformIcons(context).photoCamera),
      initialValue:
          widget.lang != null ? Uint8List(widget.lang.headerBytes) : null,
      unattachDialogTitle:
          'lang_form.general.header.unattach_confirmation'.tr(),
      unattachDialogCancel: 'cancel'.tr(),
      unattachDialogConfirm: 'attach'.tr(),
      requiredIndicator: RequiredIndicator(),
      fileType: FileTypeCross.image,
      validator: (value) {
        if (value == null || value.length == 0) return 'required_field'.tr();
        return null;
      },
      onChanged: (value) {
        final image = Image.decodeImage(value);
        _headerFile = Image.encodeJpg(image, quality: 85);
        _headerChanged = true;
        _langModel = _langModel.copyWith(headerBytes: value.length);
      },
    );
  }

  // Event handlers

  onDonePressed() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      final key = formLocalizationKey(_langModel);

      showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
          title: Text("lang_form.$key.confirmation".tr()),
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
        text: "lang_form.${formLocalizationKey(_langModel)}.progress".tr(),
      ),
    );

    final fs = context.read<FirestoreService>();
    if (_langModel.documentId != null) {
      await fs.updateLang(_langModel);
    } else {
      _langModel = _langModel.copyWith(
        documentId: await fs.insertLang(
          _langModel,
          widget.insertPosition,
        ),
      );
    }

    final basePath = FirebasePaths.langPath(_langModel);

    if (_avatarChanged && _avatarFile != null) {
      await FirebaseStorageService.uploadToStorage(
        _avatarFile,
        "$basePath/avatar.png",
      );
    }

    if (_headerChanged && _headerFile != null) {
      await FirebaseStorageService.uploadToStorage(
        _headerFile,
        "$basePath/header.jpg",
      );
    }

    Navigator.pop(context);
    Navigator.pop(context, true);
  }
}
