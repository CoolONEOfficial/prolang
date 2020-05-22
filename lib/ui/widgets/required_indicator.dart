import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RequiredIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Text('*', style: TextStyle(color: Colors.red));
}
