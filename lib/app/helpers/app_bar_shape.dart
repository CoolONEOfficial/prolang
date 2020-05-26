import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

ShapeBorder appBarShape(BuildContext context) => getValueForScreenType(
      context: context,
      mobile: null,
      tablet: ContinuousRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
      ),
    );
