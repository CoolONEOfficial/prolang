import 'package:flutter/material.dart';

Color answerToColor(double answer) =>
    answer == 0 ? Colors.red : answer == 1.0 ? Colors.green : Colors.yellow;
