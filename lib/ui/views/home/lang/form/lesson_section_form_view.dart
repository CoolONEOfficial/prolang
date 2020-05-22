import 'package:card_settings/card_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:prolang/ui/widgets/platform_progress_dialog.dart';
import 'package:prolang/ui/widgets/required_indicator.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:provider/provider.dart';

class LessonSectionFormView extends StatefulWidget {
  final int insertPosition;
  final Lang lang;

  const LessonSectionFormView({
    this.insertPosition,
    @required
    this.lang,
    Key key,
  }) : super(key: key);

  @override
  _LessonSectionFormState createState() => _LessonSectionFormState();
}

class _LessonSectionFormState extends State<LessonSectionFormView> {
  var _sectionModel = LessonSection();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // control state only works if the field order never changes.
  // to support orientation changes, we assign a unique key to each field
  // if you only have one orientation, the _formKey is sufficient
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _descriptionKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return PlatformScaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: PlatformAppBar(
        title: Text("lesson_section_form.title").tr(),
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
    );
  }

  /* CARDSETTINGS FOR EACH LAYOUT */

  CardSettings _buildPortraitLayout() {
    return CardSettings.sectioned(
      labelWidth: 100,
      children: <CardSettingsSection>[
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'lesson_section_form.general.label'.tr(),
          ),
          children: <Widget>[
            _buildCardSettingsText_Title(),
            _buildCardSettingsText_Description(),
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
            label: 'lesson_section_form.general.label'.tr(),
          ),
          children: <Widget>[
            _buildCardSettingsText_Title(),
            _buildCardSettingsText_Description(),
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
      label: 'lesson_section_form.general.title.label'.tr(),
      hintText: 'lesson_section_form.general.title.hint'.tr(),
      initialValue: _sectionModel.title,
      requiredIndicator: RequiredIndicator(),
      validator: (value) {
        if (value == null || value.isEmpty) return 'required_field'.tr();
        return null;
      },
      onSaved: (value) => _sectionModel = _sectionModel.copyWith(title: value),
      onChanged: (value) {
        setState(() {
          _sectionModel = _sectionModel.copyWith(title: value);
        });
      },
    );
  }

  CardSettingsText _buildCardSettingsText_Description() {
    return CardSettingsParagraph(
      key: _descriptionKey,
      label: 'lesson_section_form.general.description.label'.tr(),
      hintText: 'lesson_section_form.general.description.hint'.tr(),
      initialValue: _sectionModel.description,
      requiredIndicator: RequiredIndicator(),
      validator: (value) {
        if (value == null || value.isEmpty) return 'required_field'.tr();
        return null;
      },
      onSaved: (value) =>
          _sectionModel = _sectionModel.copyWith(description: value),
      onChanged: (value) {
        setState(() {
          _sectionModel = _sectionModel.copyWith(description: value);
        });
      },
    );
  }

  // Event handlers

  onDonePressed() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
          title: Text("lesson_section_form.confirmation".tr()),
          actions: <Widget>[
            PlatformDialogAction(
              child: PlatformText("cancel".tr()),
              onPressed: () => Navigator.pop(context),
            ),
            PlatformDialogAction(
              child: PlatformText("create".tr()),
              onPressed: createLessonSection,
            ),
          ],
        ),
      );
    }
  }

  createLessonSection() async {
    Navigator.pop(context);

    showPlatformDialog(
      context: context,
      builder: (_) =>
          PlatformProgressDialog(text: "lesson_section_form.progress".tr()),
    );

    await context.read<FirestoreService>().insertLessonSection(
          widget.lang,
          _sectionModel,
          widget.insertPosition,
        );

    Navigator.pop(context);
    Navigator.pop(context, true);
  }
}
