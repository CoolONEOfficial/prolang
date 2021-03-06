import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart' as buttons;
import 'package:prolang/app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final light = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: buttons.GoogleSignInButton(
        onPressed: () async {
          await context.read<FirebaseAuthService>().signInWithGoogle();
        },
        darkMode: !light,
        text: "intro.auth.button.google".tr(),
        textStyle: TextStyle(
          fontSize: 14,
          color: light ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
