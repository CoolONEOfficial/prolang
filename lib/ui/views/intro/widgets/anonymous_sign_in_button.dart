import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/constants/theme_colors.dart';
import 'package:prolang/app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class AnonymousSignInButton extends StatelessWidget {
  const AnonymousSignInButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        onPressed: () {
          context.read<FirebaseAuthService>().signInAnonymously();
        },
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: ThemeColors.primaryDarken(),
        child: Row(
          children: <Widget>[
            Icon(
              PlatformIcons(context).person,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "intro.auth.button.anonymous".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
