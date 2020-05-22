import 'package:card_settings/card_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:prolang/app/models/lesson_section.dart';

class LessonSectionCreateView extends StatefulWidget {
  final int insertPosition;

  const LessonSectionCreateView(
    this.insertPosition, {
    Key key,
  }) : super(key: key);

  @override
  _LessonSectionCreateState createState() => _LessonSectionCreateState();
}

class _LessonSectionCreateState extends State<LessonSectionCreateView> {
  var _sectionModel = LessonSection();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // control state only works if the field order never changes.
  // to support orientation changes, we assign a unique key to each field
  // if you only have one orientation, the _formKey is sufficient
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: PlatformAppBar(
        title: Text("lesson_create.title").tr(),
        trailingActions: <Widget>[
          PlatformIconButton(
            icon: Icon(PlatformIcons(context).done),
            onPressed: () {
              context.read<FirestoreService>();
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: OrientationBuilder(
          builder: (context, orientation) => orientation == Orientation.portrait
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
            label: 'Bio',
          ),
          children: <Widget>[
            _buildCardSettingsText_Name(),
            // _buildCardSettingsListPicker_Type(),
            // _buildCardSettingsRadioPicker_Gender(),
            // _buildCardSettingsNumberPicker_Age(),
            // _buildCardSettingsParagraph_Description(5),
            // _buildCardSettingsCheckboxPicker_Hobbies(),
            // _buildCardSettingsDateTimePicker_Birthday(),
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
            label: 'Bio',
          ),
          children: <Widget>[
            _buildCardSettingsText_Name(),
            // _buildCardSettingsListPicker_Type(),
            // CardFieldLayout(
            //   <Widget>[
            //     _buildCardSettingsRadioPicker_Gender(),
            //     _buildCardSettingsNumberPicker_Age(labelAlign: TextAlign.right),
            //   ],
            //   flexValues: [2, 1],
            // ),
            // _buildCardSettingsParagraph_Description(3),
            // _buildCardSettingsCheckboxPicker_Hobbies(),
            // _buildCardSettingsDateTimePicker_Birthday(),
          ],
        ),
      ],
    );
  }

  CardSettingsText _buildCardSettingsText_Name() {
    return CardSettingsText(
      key: _nameKey,
      label: 'Name',
      hintText: 'something cute...',
      initialValue: _sectionModel.title,
      requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Name is required.';
        return null;
      },
      onSaved: (value) => _sectionModel = _sectionModel.copyWith(title: value),
      onChanged: (value) {
        setState(() {
          _sectionModel = _sectionModel.copyWith(title: value);
        });
        //_showSnackBar('Name', value);
      },
    );
  }
}
