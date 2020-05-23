// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'dart:typed_data';

import 'package:card_settings/card_settings.dart';
import 'package:card_settings/helpers/platform_functions.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/helpers/byte_format.dart';
import 'package:easy_localization/easy_localization.dart';

/// This is the file picker field
class CardSettingsFilePicker extends FormField<Uint8List> {
  CardSettingsFilePicker({
    Key key,
    bool autovalidate: false,
    FormFieldSetter<Uint8List> onSaved,
    FormFieldValidator<Uint8List> validator,
    Uint8List initialValue,
    this.visible = true,
    this.label = 'Label',
    this.unattachConfirmation = 'Unattach video?',
    this.onChanged,
    this.contentAlign,
    this.icon,
    this.labelAlign,
    this.requiredIndicator,
    this.style,
    this.showMaterialonIOS,
    this.fileType,
    this.fileExtension,
  }) : super(
            key: key,
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<Uint8List> field) =>
                (field as _CardSettingsFilePickerState)._build(field.context));

  final ValueChanged<Uint8List> onChanged;

  final String label;

  final String unattachConfirmation;

  final TextAlign labelAlign;

  final TextAlign contentAlign;

  final Icon icon;

  final Widget requiredIndicator;

  final bool visible;

  final TextStyle style;

  final bool showMaterialonIOS;

  final FileTypeCross fileType;

  final String fileExtension;

  @override
  _CardSettingsFilePickerState createState() => _CardSettingsFilePickerState();
}

class _CardSettingsFilePickerState extends FormFieldState<Uint8List> {
  @override
  CardSettingsFilePicker get widget => super.widget as CardSettingsFilePicker;

  void _showDialog() {
    FilePickerCross filePicker = FilePickerCross(
      fileExtension: widget.fileExtension,
      type: widget.fileType,
    );
    filePicker.pick().then((value) => setState(() {
          final _file = filePicker.toUint8List();
          didChange(_file);
          if (widget.onChanged != null) widget.onChanged(_file);
        }));
  }

  Widget _build(BuildContext context) {
    String formattedValue =
        (value == null) ? '' : formatBytes(value.length, 2);

    if (showCupertino(context, widget.showMaterialonIOS))
      return cupertinoSettingsDatePicker(formattedValue);
    else
      return materialSettingsDatePicker(formattedValue);
  }

  onTap() {
    if (value == null) {
      _showDialog();
    } else {
      showPlatformDialog(
        context: context,
        builder: (context) => PlatformAlertDialog(
          title: Text(widget.unattachConfirmation),
          actions: [
            PlatformDialogAction(
              child: PlatformText("cancel".tr()),
              onPressed: () => Navigator.of(context).pop(),
            ),
            PlatformDialogAction(
              child: PlatformText("unattach".tr()),
              ios: (_) =>
                  CupertinoDialogActionData(isDestructiveAction: true),
              onPressed: () {
                didChange(null);
                if (widget.onChanged != null) widget.onChanged(null);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }
  }

  Widget cupertinoSettingsDatePicker(String formattedValue) {
    return Container(
      child: widget?.visible == false
          ? null
          : GestureDetector(
              onTap: onTap,
              child: CSControl(
                nameWidget: widget?.requiredIndicator != null
                    ? Text((widget?.label ?? "") + ' *')
                    : Text(widget?.label),
                contentWidget: Text(
                  formattedValue,
                  style: widget?.style ?? Theme.of(context).textTheme.subtitle1,
                  textAlign: widget?.contentAlign ??
                      CardSettings.of(context).contentAlign,
                ),
                style: CSWidgetStyle(icon: widget?.icon),
              ),
            ),
    );
  }

  Widget materialSettingsDatePicker(String formattedValue) {
    return GestureDetector(
      onTap: onTap,
      child: CardSettingsField(
        label: widget?.label ?? "File",
        labelAlign: widget?.labelAlign,
        visible: widget?.visible ?? true,
        icon: widget?.icon ?? Icon(Icons.attach_file),
        requiredIndicator: widget?.requiredIndicator,
        errorText: errorText,
        content: Text(
          formattedValue,
          style: widget?.style ?? Theme.of(context).textTheme.subtitle1,
          textAlign:
              widget?.contentAlign ?? CardSettings.of(context).contentAlign,
        ),
        pickerIcon: value == null ? Icons.attach_file : Icons.clear,
      ),
    );
  }
}
