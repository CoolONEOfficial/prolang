import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class PlatformProgressDialog extends StatelessWidget {
  const PlatformProgressDialog({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(
      content: Row(
        children: <Widget>[
          PlatformCircularProgressIndicator(),
          SizedBox(width: 16),
          Text(text, style: Theme.of(context).textTheme.subtitle1)
        ],
      ),
    );
  }
}
