import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart' as buttons;
import 'package:easy_localization/easy_localization.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final light = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: buttons.AppleSignInButton(
        style: light ? buttons.AppleButtonStyle.whiteOutline :  buttons.AppleButtonStyle.black,
        onPressed: () async {
         // await context.read<FirebaseAuthService>().sign();
        },
        text: "intro.auth.button.apple".tr(),
        textStyle: TextStyle(
          fontSize: 14,
          color: light ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
