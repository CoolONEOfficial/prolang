// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:card_settings/card_settings.dart';
import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:easy_localization/easy_localization.dart';

/// This is the date picker field
class CardSettingsAudioRecorder extends FormField<Uint8List> {
  CardSettingsAudioRecorder({
    Key key,
    bool autovalidate: false,
    FormFieldSetter<Uint8List> onSaved,
    FormFieldValidator<Uint8List> validator,
    Uint8List initialValue,
    this.visible = true,
    this.label = 'Audio',
    this.onChanged,
    this.contentAlign,
    this.icon,
    this.labelAlign,
    this.requiredIndicator,
    this.firstDate,
    this.lastDate,
    this.dateFormat,
    this.style,
    this.showMaterialonIOS,
    this.unattachDialogTitle,
    this.unattachDialogConfirm,
    this.unattachDialogCancel,
  }) : super(
            key: key,
            initialValue: initialValue ?? Uint8List(0),
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<Uint8List> field) =>
                (field as _CardSettingsDatePickerState)._build(field.context));

  final String unattachDialogTitle;

  final String unattachDialogConfirm;

  final String unattachDialogCancel;

  final ValueChanged<Uint8List> onChanged;

  final String label;

  final TextAlign labelAlign;

  final TextAlign contentAlign;

  final DateTime firstDate;

  final DateTime lastDate;

  final DateFormat dateFormat;

  final Icon icon;

  final Widget requiredIndicator;

  final bool visible;

  final TextStyle style;

  final bool showMaterialonIOS;

  @override
  _CardSettingsDatePickerState createState() => _CardSettingsDatePickerState();
}

enum RecordState {
  INACTIVE,
  RECORDING,
  LOADING,
}

class _CardSettingsDatePickerState extends FormFieldState<Uint8List>
    with SingleTickerProviderStateMixin {
  @override
  CardSettingsAudioRecorder get widget =>
      super.widget as CardSettingsAudioRecorder;

  RecordState _recordState = RecordState.INACTIVE;

  Animation<double> _animation;
  AnimationController _controller;

  DateTime _startRec;

  final GlobalKey<FormState> _iconKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );
    Tween tween = Tween<double>(begin: 1.0, end: 1.5);
    _animation = tween.animate(_controller);
    requestPermissions();
  }

  requestPermissions() async {
    if (await Permission.microphone.status != PermissionStatus.granted) {
      Permission.microphone.request();
    }

    if (await Permission.storage.status != PermissionStatus.granted) {
      Permission.storage.request();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  String formatDuration(Duration d) {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    // We want to round up the remaining time to the nearest second
    d += Duration(microseconds: 999999);
    return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
  }

  Widget _build(BuildContext context) {
    String formattedValue() => _recordState == RecordState.RECORDING
        ? formatDuration(DateTime.now().difference(_startRec))
        : _recordState == RecordState.INACTIVE
            ? formatBytes(value?.length ?? 0, 2)
            : "Ждите";

    if (showCupertino(context, widget.showMaterialonIOS))
      return cupertinoSettingsDatePicker(formattedValue);
    else
      return materialSettingsDatePicker(formattedValue);
  }

  Widget _text(String Function() formattedValue) {
    return Text(
      formattedValue(),
      style: widget?.style ?? Theme.of(context).textTheme.subtitle1,
      textAlign: widget?.contentAlign ?? CardSettings.of(context).contentAlign,
    );
  }

  Widget cupertinoSettingsDatePicker(String Function() formattedValue) {
    return Container(
      child: widget?.visible == false
          ? null
          : CSControl(
              nameWidget: widget?.requiredIndicator != null
                  ? Text((widget?.label ?? "") + ' *')
                  : Text(widget?.label),
              contentWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _recordState == RecordState.RECORDING
                      ? TimerBuilder.periodic(Duration(milliseconds: 10),
                          builder: (_) => _text(formattedValue))
                      : _text(formattedValue),
                  _iconButton(),
                ],
              ),
              style: CSWidgetStyle(icon: widget?.icon),
            ),
    );
  }

  Widget materialSettingsDatePicker(String Function() formattedValue) {
    return CardSettingsField(
      label: widget?.label ?? "Audio",
      labelAlign: widget?.labelAlign,
      visible: widget?.visible ?? true,
      icon: widget?.icon ?? Icon(Icons.event),
      requiredIndicator: widget?.requiredIndicator,
      errorText: errorText,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _recordState == RecordState.RECORDING
              ? TimerBuilder.periodic(Duration(seconds: 1),
                  builder: (_) => _text(formattedValue))
              : _text(formattedValue),
          _iconButton(),
        ],
      ),
    );
  }

  String path;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/${DateTime.now().toIso8601String()}.mp3";
  }

  Widget _iconButton() {
    return (value?.length ?? 0) == 0
        ? GestureDetector(
            key: _iconKey,
            onLongPressStart: (_) async {
              setState(() {
                _recordState = RecordState.LOADING;
              });
              path = await getFilePath();
              RecordMp3.instance.start(
                path,
                (type) {
                  debugPrint("err $type");
                },
              );

              _startRec = DateTime.now();
              setState(() {
                _recordState = RecordState.RECORDING;
              });
              _controller.forward();
            },
            onLongPressEnd: (_) async {
              _controller.reverse();
              if (RecordMp3.instance.stop()) {
                didChange(await File.fromUri(Uri.file(path)).readAsBytes());
                if (widget.onChanged != null) widget.onChanged(value);
              }
              setState(() {
                _recordState = RecordState.INACTIVE;
                _startRec = null;
              });
            },
            child: Center(
              heightFactor: 2,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, snapshot) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Transform.scale(
                    scale: _animation.value,
                    child: _recordState == RecordState.INACTIVE
                        ? Icon(PlatformIcons(context).mic)
                        : Icon(PlatformIcons(context).micOutline),
                  ),
                ),
              ),
            ),
          )
        : PlatformIconButton(
            icon: Icon(PlatformIcons(context).delete),
            onPressed: () {
              showPlatformDialog(
                context: context,
                builder: (_) => PlatformAlertDialog(
                  title: Text(widget.unattachDialogTitle),
                  actions: <Widget>[
                    PlatformDialogAction(
                      child: PlatformText(
                        widget.unattachDialogCancel,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    PlatformDialogAction(
                      cupertino: (_, __) => CupertinoDialogActionData(
                        isDestructiveAction: true,
                      ),
                      child: PlatformText(
                        widget.unattachDialogConfirm,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        didChange(null);
                        if (widget.onChanged != null) widget.onChanged(value);
                      },
                    )
                  ],
                ),
              );
            },
          );
  }
}
