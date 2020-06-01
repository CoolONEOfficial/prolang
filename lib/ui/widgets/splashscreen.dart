import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prolang/app/constants/theme_colors.dart';
import 'package:prolang/ui/widgets/loading_indicator.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.primaryLight,
      child: SafeArea(
        child: LoadingIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
