import 'package:flutter/material.dart';
import 'package:prolang/app/constants/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../intro_view_model.dart';

class AnonymousSignInButton extends StatelessWidget {
  const AnonymousSignInButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        context.read<IntroViewModel>().signInAnonymously();
      },
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: ThemeColors.primaryDarken(),
      child: Text(
        "intro.auth.button.anonymous".tr(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }
}
