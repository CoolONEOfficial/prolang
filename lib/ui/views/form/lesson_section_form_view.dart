import 'package:card_settings/card_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/helpers/form_localization.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:prolang/ui/widgets/platform_progress_dialog.dart';
import 'package:prolang/ui/widgets/required_indicator.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/ui/widgets/responsive_safe_area.dart';
import 'package:provider/provider.dart';

class LessonSectionFormView extends StatefulWidget {
  final int insertPosition;
  final Lang lang;
  final LessonSection section;

  const LessonSectionFormView({
    this.insertPosition,
    @required this.lang,
    this.section,
    Key key,
  }) : super(key: key);

  @override
  _LessonSectionFormState createState() =>
      _LessonSectionFormState(section ?? LessonSection());
}

class _LessonSectionFormState extends State<LessonSectionFormView> {
  LessonSection _sectionModel;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // control state only works if the field order never changes.
  // to support orientation changes, we assign a unique key to each field
  // if you only have one orientation, the _formKey is sufficient
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _descriptionKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _priceKey = GlobalKey<FormState>();

  _LessonSectionFormState(this._sectionModel);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return ResponsiveSafeArea(
      child: PlatformScaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: PlatformAppBar(
          title: Text(
                  "lesson_section_form.${formLocalizationKey(_sectionModel)}.title")
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
            label: 'lesson_section_form.general.label'.tr(),
          ),
          children: <Widget>[
            _buildCardSettingsText_Title(),
            _buildCardSettingsText_Description(),
            _buildCardSettingsPrice(),
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
            _buildCardSettingsPrice(),
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

  CardSettingsNumberPicker _buildCardSettingsPrice() {
    return CardSettingsNumberPicker(
      key: _descriptionKey,
      label: 'lesson_section_form.general.price.label'.tr(),
      initialValue: 3000,
      requiredIndicator: RequiredIndicator(),
      min: 0,
      max: 20000,
      stepInterval: 100,
      validator: (value) {
        if (value == null) return 'required_field'.tr();
        return null;
      },
      onSaved: (value) =>
          _sectionModel = _sectionModel.copyWith(price: value),
      onChanged: (value) {
        setState(() {
          _sectionModel = _sectionModel.copyWith(price: value);
        });
      },
    );
  }

  // Event handlers

  onDonePressed() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      final key = formLocalizationKey(_sectionModel);

      showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
          title: Text("lesson_section_form.$key.confirmation".tr()),
          actions: <Widget>[
            PlatformDialogAction(
              child: PlatformText("cancel".tr()),
              onPressed: () => Navigator.pop(context),
            ),
            PlatformDialogAction(
              child: PlatformText(key.tr()),
              onPressed: () {
                Navigator.pop(context);
                applyLessonSection();
              },
            ),
          ],
        ),
      );
    }
  }

  applyLessonSection() async {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformProgressDialog(
          text:
              "lesson_section_form.${formLocalizationKey(_sectionModel)}.progress"
                  .tr()),
    );

    final fs = context.read<FirestoreService>();
    if (_sectionModel.documentId != null) {
      await fs.updateLessonSection(
        widget.lang,
        _sectionModel,
      );
    } else {
      await fs.insertLessonSection(
        widget.lang,
        _sectionModel,
        widget.insertPosition,
      );
    }

    Navigator.pop(context);
    Navigator.pop(context, true);
  }
}
