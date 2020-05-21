import 'package:card_settings/card_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/models/lesson.dart';

class LessonCreate extends StatefulWidget {
  @override
  _LessonCreateState createState() => _LessonCreateState();
}

class _LessonCreateState extends State<LessonCreate> {
  var _lessonModel = Lesson();

  // once the form submits, this is flipped to true, and fields can then go into autovalidate mode.
  bool _autoValidate = false;

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
      initialValue: _lessonModel.title,
      requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Name is required.';
        return null;
      },
      onSaved: (value) => _lessonModel = _lessonModel.copyWith(title: value),
      onChanged: (value) {
        setState(() {
          _lessonModel = _lessonModel.copyWith(title: value);
        });
        //_showSnackBar('Name', value);
      },
    );
  }
}
